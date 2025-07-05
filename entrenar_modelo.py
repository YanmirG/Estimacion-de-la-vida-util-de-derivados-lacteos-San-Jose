import tensorflow as tf
from tensorflow.keras.utils import image_dataset_from_directory # type: ignore
from tensorflow.keras.applications import MobileNetV2 # type: ignore
from tensorflow.keras.layers import GlobalAveragePooling2D, Dense # type: ignore

print(tf.__version__)

# 1) Ruta a tu dataset
ruta_dataset = r'C:\Users\PC 19\OneDrive\Documentos\Estimacion de vida util\Estimacion-de-la-vida-util-de-derivados-lacteos-San-Jose\dataset_lacteos'

# 2) Cargar todas las imágenes (BuenEstado / MalEstado)
dataset = image_dataset_from_directory(
    ruta_dataset,
    labels='inferred',
    label_mode='binary',
    image_size=(224, 224),
    batch_size=16,
    shuffle=True
)

# 3) Separar en entrenamiento (80%) y validación (20%)
total_batches = tf.data.experimental.cardinality(dataset).numpy()
train_size = int(0.8 * total_batches)
train_ds = dataset.take(train_size)
val_ds   = dataset.skip(train_size)

# 4) Prefetch para rendimiento
AUTOTUNE = tf.data.AUTOTUNE
train_ds = train_ds.cache().prefetch(AUTOTUNE)
val_ds   = val_ds.cache().prefetch(AUTOTUNE)

# 5) Modelo con MobileNetV2 preentrenado
base_model = MobileNetV2(input_shape=(224,224,3), include_top=False, weights='imagenet')
base_model.trainable = False

model = tf.keras.Sequential([
    base_model,
    GlobalAveragePooling2D(),
    Dense(1, activation='sigmoid')
])

model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics=['accuracy'])

# 6) Entrenar con 30 épocas
model.fit(train_ds, validation_data=val_ds, epochs=30)

# 7) Guardar en formato .keras
model.save('modelo_lacteos.keras')
print("✅ Entrenamiento terminado. Modelo guardado como 'modelo_lacteos.keras'")
