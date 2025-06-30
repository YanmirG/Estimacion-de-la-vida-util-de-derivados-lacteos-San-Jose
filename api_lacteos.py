from flask import Flask, jsonify, request
from flask_cors import CORS
import pyodbc
from PIL import Image
import numpy as np
import tensorflow as tf

app = Flask(__name__)
CORS(app)  # Permitir acceso desde tu app Android

# Conexión a SQL Server
conn_str = (
    'DRIVER={ODBC Driver 18 for SQL Server};'
    'SERVER=YAN\\SQLYAN;'
    'DATABASE=SistemaLacteosSanJose;'
    'Trusted_Connection=yes;'
    'Encrypt=no;'
)

# Cargar el modelo solo una vez al iniciar la API
modelo = tf.keras.models.load_model('modelo_lacteos.h5')

def preparar_imagen(imagen_pil):
    imagen = imagen_pil.resize((224, 224))
    imagen = np.array(imagen) / 255.0
    imagen = np.expand_dims(imagen, axis=0)
    return imagen

@app.route('/productos', methods=['GET'])
def obtener_productos():
    try:
        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM ProductoLacteo")
        columnas = [col[0] for col in cursor.description]
        productos = [dict(zip(columnas, row)) for row in cursor.fetchall()]
        conn.close()
        return jsonify(productos)
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/estimacion', methods=['GET', 'POST'])
def estimacion():
    try:
        if request.method == 'POST':
            if request.is_json:
                data = request.get_json()
            else:
                data = request.form
        else:
            data = request.args

        print("Datos recibidos:", data)
        




        campos = ['temperatura', 'humedad', 'ph', 'fecha_produccion']
        for campo in campos:
            if campo not in data or data.get(campo) in [None, '']:
                return jsonify({"error": f"Falta el campo obligatorio: {campo}"}), 400

        temperatura = float(data.get('temperatura'))
        humedad = float(data.get('humedad'))
        ph = float(data.get('ph'))
        fecha_produccion = data.get('fecha_produccion')

        vida_util = int((temperatura + humedad + ph) / 5)

        return jsonify({
            "vida_util_dias": vida_util,
            "fecha_produccion": fecha_produccion
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/analizar_imagen', methods=['POST'])
def analizar_imagen():
    if 'imagen' not in request.files:
        return jsonify({'error': 'No se envió ninguna imagen'}), 400
    file = request.files['imagen']
    try:
        img = Image.open(file.stream).convert('RGB')
        imagen_preparada = preparar_imagen(img)
        prediccion = modelo.predict(imagen_preparada)
        estado = 'MalEstado' if prediccion[0][0] > 0.5 else 'BuenEstado'
        confianza = float(prediccion[0][0]) if estado == 'MalEstado' else 1 - float(prediccion[0][0])
        return jsonify({
            'estado': estado,
            'confianza': round(confianza, 3)
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
# Este script define una API RESTful para interactuar con la base de datos de Lácteos San José.
# Permite obtener productos y estimar la vida útil de un producto lácteo.
