import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image/image.dart' as img;
import '../testj/plant_data.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final ImagePicker _picker = ImagePicker();
  Interpreter? _interpreter;
  bool _modelLoaded = false;

  bool _isProcessing = false;
  File? _selectedImage;

  String? _message;
  String? _disease;
  String? _advice;
  String? _accuracy;

  final allowedPlants = ['tomato', 'apple', 'mango'];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset("assets/model/plant_disease_model.tflite");
      _modelLoaded = true;
    } catch (e) {
      _modelLoaded = false;
    }
  }

  Future<void> _selectImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });

      if (!_modelLoaded) {
        _showError("Erreur de chargement du modèle");
        return;
      }

      await _analyze(picked.path);
    }
  }

  Future<void> _analyze(String path) async {
    setState(() {
      _isProcessing = true;
      _message = null;
      _disease = null;
      _advice = null;
      _accuracy = null;
    });

    try {
      final imgData = File(path).readAsBytesSync();
      final decoded = img.decodeImage(imgData)!;
      final resized = img.copyResize(decoded, width: 224, height: 224);

      final input = List.generate(
        1,
        (_) => List.generate(
          224,
          (y) => List.generate(
            224,
            (x) {
              final pixel = resized.getPixel(x, y);
              return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
            },
          ),
        ),
      );

      final output = List.generate(1, (_) => List.filled(39, 0.0));
      _interpreter!.run(input, output);

      int index = 0;
      double confidence = 0.0;
      for (int i = 0; i < output[0].length; i++) {
        if (output[0][i] > confidence) {
          confidence = output[0][i];
          index = i;
        }
      }

      if (!plantDiseaseData.containsKey(index)) {
        _showError("Classe inconnue détectée");
        return;
      }

      final result = plantDiseaseData[index]!;
      final labelLower = result.name.toLowerCase();

      if (!allowedPlants.any((plant) => labelLower.contains(plant))) {
        _showError("Image invalide : plante non reconnue (tomate, pommier, manguier)");
        return;
      }

      setState(() {
        _disease = result.name;
        _advice = result.solutions;
        _accuracy = (confidence * 100).toStringAsFixed(2);
        _message = result.description;
      });
    } catch (e) {
      _showError("Erreur durant la prédiction");
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showError(String msg) {
    setState(() {
      _message = msg;
      _disease = null;
      _advice = null;
      _accuracy = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prédiction de maladies des plantes")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.file(_selectedImage!, height: 200),
                ),
              if (_isProcessing)
                const SpinKitFadingCircle(color: Colors.green, size: 50)
              else if (_disease != null)
                Card(
                  margin: const EdgeInsets.all(12),
                  color: Colors.green.shade50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text("🌿 ${_disease!}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("📌 Précision: $_accuracy%", style: TextStyle(color: Colors.green[900])),
                        const SizedBox(height: 8),
                        Text("💬 Description: $_message"),
                        const SizedBox(height: 8),
                        Text("🛠️ Conseil: $_advice"),
                      ],
                    ),
                  ),
                )
              else if (_message != null)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _message!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                const Text("Sélectionnez une image à analyser"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _selectImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo),
                    label: const Text("Galerie"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () => _selectImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Caméra"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
