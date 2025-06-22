from flask import Flask, jsonify, request
from flask_cors import CORS
import pyodbc

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

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
# Este script define una API RESTful para interactuar con la base de datos de Lácteos San José.
# Permite obtener productos y estimar la vida útil de un producto lácteo.
