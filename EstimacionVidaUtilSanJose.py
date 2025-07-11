import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import datetime
from datetime import datetime, timedelta



# 1) Datos simulados ampliados de la empresa Lácteos San José

data = pd.DataFrame({
    'tipo_producto': [
        'Queso', 'Yogurt', 'Mantequilla',
        'Queso', 'Yogurt',
        'Manjar', 'Natilla', 'Queso con orégano'
    ],
    'temperatura': [10, 4, 6, 14, 8, 12, 9, 11],
    'humedad':     [70, 60, 50, 75, 65, 68, 66, 69],
    'ph':          [6.2, 4.5, 5.2, 6.0, 4.8, 5.9, 5.7, 6.3],
    'vida_util_dias': [20, 15, 30, 18, 12, 22, 16, 24]
})

 

# 2) Convertir tipo_producto a variables numéricas


data = pd.get_dummies(data, columns=['tipo_producto'], drop_first=False)
# Esto crea columnas como tipo_producto_Yogurt, tipo_producto_Mantequilla, etc.





# 3) Separar variables de entrada (X) y salida (y)

X = data.drop(columns=['vida_util_dias'])
y = data['vida_util_dias']



# 4) Dividir en entrenamiento y prueba



X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)



# 5) Entrenar el modelo de regresión

modelo = LinearRegression()
modelo.fit(X_train, y_train)



# 6) Función para estimar vida útil dado un input

def estimar_vida_util(tipo, fecha_str, temperatura, humedad, ph):
    # Convertir la fecha de DD-MM-YYYY a YYYY-MM-DD
    try:
        fecha_produccion = datetime.strptime(fecha_str, "%Y-%m-%d").date()
    except ValueError:
        # Si viene en DD-MM-YYYY, convertirlo
        fecha_produccion = datetime.strptime(fecha_str, "%d-%m-%Y").date()

    # Preparar la muestra con todas las columnas de X
    muestra = {
        'temperatura': temperatura,
        'humedad': humedad,
        'ph': ph
    }
    # Añadir dummies para cada categoría
    for col in X.columns:
        if col.startswith('tipo_producto_'):
            muestra[col] = (col == f'tipo_producto_{tipo}')

    muestra_df = pd.DataFrame([muestra])[X.columns]

    # Predicción
    vida_util = round(modelo.predict(muestra_df)[0])

    # Fechas
    fecha_vencimiento = fecha_produccion + timedelta(days=vida_util)
    hoy = datetime.now().date()
    dias_restantes = (fecha_vencimiento - hoy).days

    return {
        'vida_util_dias': vida_util,
        'fecha_produccion': fecha_produccion,
        'fecha_vencimiento': fecha_vencimiento,
        'dias_restantes': dias_restantes
    }



# 7) Uso por consola

if __name__ == "__main__":
    print("=== Estimación de vida útil – Lácteos San José ===")
    print("\nBase de datos completa de productos:\n")
    print(data)  # Muestra todo el DataFrame
    print(f"\nTotal de registros: {len(data)}\n")
    tipo = input(
        "Tipo de producto (Queso/Yogurt/Mantequilla/Manjar/Natilla/Queso con orégano): "
    ).strip()
    
    # Solicitar la fecha en formato DD-MM-YYYY
    fecha_str = input("Fecha de producción (DD-MM-YYYY): ").strip()
    

    try:
        fecha_obj = datetime.strptime(fecha_str, "%d-%m-%Y")
        fecha_str = fecha_obj.strftime("%Y-%m-%d")
    except ValueError:
        print("Formato de fecha incorrecto. Usa DD-MM-YYYY.")
        exit(1)
    
    temperatura = float(input("Temperatura (°C): ").strip())
    humedad = float(input("Humedad (%): ").strip())
    ph = float(input("pH: ").strip())

    resultado = estimar_vida_util(tipo, fecha_str, temperatura, humedad, ph)

    print(f"\nPredicción de vida útil para {tipo}: {resultado['vida_util_dias']} días")
    print(f"Fecha de producción: {resultado['fecha_produccion']}")
    print(f"Fecha estimada de vencimiento: {resultado['fecha_vencimiento']}")
    if resultado['dias_restantes'] >= 0:
        print(f"Días restantes para vencer: {resultado['dias_restantes']}")
    else:
        print("¡Atención! El producto ha superado su vida útil estimada.")

