import tensorflow as tf
import os

# Chemin du modèle d'entrée
keras_model_path = r'C:\Users\waris\Plant_Desease_Prediction\plant_disease_app\assets\model\trained_plant_disease_model.keras'

# Vérifier si le fichier du modèle existe
if not os.path.exists(keras_model_path):
    raise FileNotFoundError(f"Le modèle spécifié n'existe pas à l'emplacement : {keras_model_path}")

# Charger le modèle (désactivation de la compilation initiale pour éviter les erreurs liées aux optimisateurs)
model = tf.keras.models.load_model(keras_model_path, compile=False)

# Compiler le modèle avec les paramètres appropriés
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

# Convertir le modèle en TFLite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Chemin pour sauvegarder le modèle converti
tflite_model_path = r'C:\Users\waris\Plant_Desease_Prediction\plant_disease_app\assets\model\plant_disease_model.tflite'

# Sauvegarder le modèle converti
with open(tflite_model_path, 'wb') as f:
    f.write(tflite_model)

print(f"Modèle converti avec succès en TFLite et sauvegardé à : {tflite_model_path}")
