import tensorflow as tf
print(tf.__version__)
from tensorflow.keras.preprocessing import image_dataset_from_directory # type: ignore

# Ruta a tu dataset
ruta_dataset = r'C:\Users\PC 19\OneDrive\Documentos\Estimacion de vida util\Estimacion-de-la-vida-util-de-derivados-lacteos-San-Jose\dataset_lacteos'

# Cargar imágenes desde las carpetas
dataset = image_dataset_from_directory(
    ruta_dataset,
    labels='inferred',
    label_mode='binary',  # Dos clases: BuenEstado y MalEstado
    image_size=(224, 224),  # Tamaño estándar para modelos preentrenados
    batch_size=8
)

# Separar en entrenamiento y validación
train_ds = dataset.take(6)
val_ds = dataset.skip(6)

# Crear un modelo simple usando MobileNetV2 preentrenado
base_model = tf.keras.applications.MobileNetV2(input_shape=(224,224,3),
                                               include_top=False,
                                               weights='imagenet')
base_model.trainable = False

model = tf.keras.Sequential([
    base_model,
    tf.keras.layers.GlobalAveragePooling2D(),
    tf.keras.layers.Dense(1, activation='sigmoid')
])
# Asegúrate de que el modelo esté compilado antes de entrenarlo
## Esto es necesario para que el modelo sepa cómo optimizarse
model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics=['accuracy'])

# Entrenar el modelo
model.fit(train_ds, validation_data=val_ds, epochs=5)

# Guardar el modelo entrenado
model.save('modelo_lacteos.h5')