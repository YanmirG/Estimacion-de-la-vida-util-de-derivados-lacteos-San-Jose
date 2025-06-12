import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import datetime

# ---------------------------------------------------
# 1) Datos simulados ampliados de la empresa Lácteos San José
# ---------------------------------------------------
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

# Convertir tipo_producto a variables numéricas
data = pd.get_dummies(data, columns=['tipo_producto'], drop_first=True)

# Separar variables de entrada (X) y salida (y)
X = data.drop(columns=['vida_util_dias'])
y = data['vida_util_dias']

# Dividir en entrenamiento y prueba
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Modelo de regresión
modelo = LinearRegression()
modelo.fit(X_train, y_train)

# Ingreso de datos por el usuario
print("=== Sistema de estimación de vida útil para Lácteos San José ===")
tipo = input("Tipo de producto (Queso/Yogurt/Mantequilla): ").strip().capitalize()
fecha_str = input("Fecha de producción (YYYY-MM-DD): ").strip()
temperatura = float(input("Temperatura de almacenamiento (°C): ").strip())
humedad = float(input("Humedad (%): ").strip())
ph = float(input("pH: ").strip())

# Procesar fecha de producción
try:
    fecha_produccion = datetime.datetime.strptime(fecha_str, "%Y-%m-%d").date()
except ValueError:
    print("Fecha inválida. Usa el formato YYYY-MM-DD.")
    exit(1)

# Crear la muestra con las columnas correctas
nueva_muestra = {
    'temperatura': [temperatura],
    'humedad': [humedad],
    'ph': [ph],
    'tipo_producto_Yogurt': [1 if tipo == 'Yogurt' else 0],
    'tipo_producto_Mantequilla': [1 if tipo == 'Mantequilla' else 0]
}

nueva_muestra_df = pd.DataFrame(nueva_muestra)

# Asegurar que todas las columnas estén presentes y en el mismo orden que X
for col in X.columns:
    if col not in nueva_muestra_df.columns:
        nueva_muestra_df[col] = 0
nueva_muestra_df = nueva_muestra_df[X.columns]

# Predicción
prediccion = modelo.predict(nueva_muestra_df)
vida_util = round(prediccion[0])

# Calcular fecha de vencimiento y días restantes
fecha_vencimiento = fecha_produccion + datetime.timedelta(days=vida_util)
hoy = datetime.date.today()
dias_restantes = (fecha_vencimiento - hoy).days

print(f"\nPredicción de vida útil para {tipo}: {vida_util} días")
print(f"Fecha de producción: {fecha_produccion}")
print(f"Fecha estimada de vencimiento: {fecha_vencimiento}")
if dias_restantes >= 0:
    print(f"Días restantes para vencer: {dias_restantes}")
else:
    print("¡Atención! El producto ha superado su vida útil estimada.")
