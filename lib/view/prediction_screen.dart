import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../testj/plant_data.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  String? _result;
  String? _accuracy;
  bool _isProcessing = false;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  Interpreter? _interpreter;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
          "assets/models/trained_plant_disease_model.tflite");
      print("Modèle chargé avec succès");
    } catch (e) {
      print("Erreur lors du chargement du modèle: $e");
      _showDialog(
          "Impossible de charger le modèle. Vérifiez son chemin et son format.");
    }
  }

  bool _isModelLoaded() {
    if (_interpreter == null) {
      _showDialog("Le modèle n'est pas chargé. Veuillez réessayer.");
      return false;
    }
    return true;
  }

  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await _predict(pickedFile.path);
    } else {
      _showDialog("Aucune image sélectionnée.");
    }
  }

  Future<List<List<List<List<double>>>>> _preprocessImage(
      String imagePath) async {
    // 1. Charger l'image depuis le fichier
    File imageFile = File(imagePath);
    Uint8List imageBytes = await imageFile.readAsBytes();

    // 2. Décoder l'image
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception("Impossible de charger l'image.");
    }

    // 3. Redimensionner l'image à la taille requise par le modèle (ex: 224x224)
    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // 4. Normaliser les pixels (de 0-255 à 0.0-1.0)
    List<List<List<List<double>>>> input = List.generate(
      1,
      (batch) => List.generate(
        224,
        (y) => List.generate(
          224,
          (x) {
            img.Pixel pixel = resizedImage.getPixel(x, y);
            return [
              pixel.r / 255.0, // Rouge normalisé
              pixel.g / 255.0, // Vert normalisé
              pixel.b / 255.0 // Bleu normalisé
            ];
          },
        ),
      ),
    );

    return input;
  }

  Future<void> _predict(String imagePath) async {
    if (!_isModelLoaded()) return;

    setState(() {
      _isProcessing = true;
      _result = null;
      _accuracy = null;
    });

    try {
      var input = await _preprocessImage(imagePath);
      List<List<double>> output =
          List.generate(1, (index) => List.filled(39, 0));
      _interpreter!.run(input, output);

      int bestIndex = 0;
      double bestConfidence = 0.0;
      for (int i = 0; i < output[0].length; i++) {
        if (output[0][i] > bestConfidence) {
          bestConfidence = output[0][i];
          bestIndex = i;
        }
      }

      if (plantDiseaseData.containsKey(bestIndex)) {
        PlantDiseaseInfo diseaseInfo = plantDiseaseData[bestIndex]!;
        setState(() {
          _result = "Maladie détectée : ${diseaseInfo.name}";
          _accuracy =
              "Précision : ${(bestConfidence * 100).toStringAsFixed(2)}%\n"
              "Description : ${diseaseInfo.description}\n"
              "Solutions : ${diseaseInfo.solutions}";
        });
      } else {
        setState(() {
          _result = "Classe inconnue : $bestIndex";
          _accuracy =
              "Précision : ${(bestConfidence * 100).toStringAsFixed(2)}%";
        });
      }
    } catch (e) {
      _showDialog("Erreur lors de la prédiction: $e");
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Attention"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prédiction de maladies des plantes")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200),
            const SizedBox(height: 10),
            _isProcessing
                ? const SpinKitFadingCircle(color: Colors.green, size: 50.0)
                : _result != null
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(_result!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text(_accuracy ?? "",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.blue)),
                          ],
                        ),
                      )
                    : const Text("Chargez une image pour prédire",
                        style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_library,
                      size: 40, color: Colors.blue),
                  onPressed: () => _selectImage(ImageSource.gallery),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.camera_alt,
                      size: 40, color: Colors.green),
                  onPressed: () => _selectImage(ImageSource.camera),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
