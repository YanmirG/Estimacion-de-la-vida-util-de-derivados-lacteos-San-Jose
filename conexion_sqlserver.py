import pyodbc
import pandas as pd

# Conexión a SQL Server (respetando tu configuración)
conn_str = (
    'DRIVER={ODBC Driver 18 for SQL Server};'
    'SERVER=YAN\\SQLYAN;'
    'DATABASE=SistemaLacteosSanJose;'
    'Trusted_Connection=yes;'
    'Encrypt=no;'
)

try:
    # Crear conexión
    conn = pyodbc.connect(conn_str)
    print("✅ Conexión exitosa a SQL Server, Yanmir ⚔️\n")

    # Cargar datos de ProductoLacteo incluyendo la fecha_produccion
    consulta = "SELECT id_producto, tipo_producto, fecha_produccion, lote FROM ProductoLacteo"
    df = pd.read_sql(consulta, conn)
    print("📦 Datos de ProductoLacteo (con fecha_produccion):\n", df, "\n")

    tablas = {
        "CondicionAmbiental": "SELECT * FROM CondicionAmbiental",
        "EstimacionVidaUtil": "SELECT * FROM EstimacionVidaUtil",
        "Usuario": "SELECT * FROM Usuario"
    }

    for nombre_tabla, consulta in tablas.items():
        print(f"📂 Tabla: {nombre_tabla}")
        df_tabla = pd.read_sql(consulta, conn)
        print(df_tabla, "\n")

    conn.close()
    print("🔒 Conexión cerrada correctamente.")

except Exception as e:
    print("❌ Error en la conexión o lectura de datos:", e)
# Este script conecta a SQL Server, recupera datos de ProductoLacteo y muestra otras tablas.
# Puedes usar este dataframe para entrenar tu modelo de IA o realizar análisis.