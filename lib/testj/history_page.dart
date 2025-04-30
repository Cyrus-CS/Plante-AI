import 'package:flutter/material.dart';
import 'dart:io';
import '../testj/database_helper.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Map<String, dynamic>>> _predictions;
  final Set<int> _selectedItems = {};

  final Color primaryColor = Color(0xFF234520);
  final Color secondaryColor = Color(0xFF5B8C2D);

  @override
  void initState() {
    super.initState();
    _loadPredictions();
  }

  void _loadPredictions() {
    setState(() {
      _predictions = DatabaseHelper().fetchPredictions();
    });
  }

  void _deleteSelectedItems() async {
    final count = _selectedItems.length;
    for (int id in _selectedItems) {
      await DatabaseHelper().deletePrediction(id);
    }
    setState(() => _selectedItems.clear());
    _loadPredictions();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$count prédiction(s) supprimée(s) !'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _toggleSelection(int id) {
    setState(() {
      if (_selectedItems.contains(id)) {
        _selectedItems.remove(id);
      } else {
        _selectedItems.add(id);
      }
    });
  }

  void _toggleSelectAll(List<Map<String, dynamic>> predictions) {
    setState(() {
      if (_selectedItems.length == predictions.length) {
        _selectedItems.clear();
      } else {
        _selectedItems.addAll(predictions.map((p) => p['id']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des analyses'),
        backgroundColor: primaryColor,
        actions: [
          if (_selectedItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteSelectedItems,
            ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _predictions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucune prédiction trouvée."));
          }

          final predictions = snapshot.data!;

          return Column(
            children: [
              if (predictions.length > 1)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sélection : ${_selectedItems.length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _toggleSelectAll(predictions),
                        child: Text(
                          _selectedItems.length == predictions.length
                              ? "Tout désélectionner"
                              : "Tout sélectionner",
                          style: TextStyle(color: secondaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  itemCount: predictions.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final prediction = predictions[index];
                    final isSelected =
                        _selectedItems.contains(prediction['id']);
                    final bool isSuccess =
                        prediction['status']?.toLowerCase() == 'success';

                    return Container(
                      color: isSelected ? secondaryColor.withOpacity(0.2) : null,
                      child: ListTile(
                        leading: _buildImage(prediction['imagePath']),
                        title: Text(
                          prediction['plantName'] ?? 'Inconnue',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Maladie : ${prediction['disease'] ?? 'N/A'}"),
                            Text("Conseil : ${prediction['advice'] ?? 'N/A'}"),
                            Text("Date : ${prediction['dateTime'] ?? ''}"),
                            Text(
                              "Statut : ${isSuccess ? 'Succès ' : 'Erreur '}",
                              style: TextStyle(
                                color: isSuccess ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          isSuccess
                              ? Icons.check_circle_outline
                              : Icons.error_outline,
                          color: isSuccess ? Colors.green : Colors.red,
                        ),
                        onTap: () {
                          if (_selectedItems.isNotEmpty) {
                            _toggleSelection(prediction['id']);
                          } else {
                            Navigator.pushNamed(context, '/predict',
                                arguments: prediction);
                          }
                        },
                        onLongPress: () => _toggleSelection(prediction['id']),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(imagePath),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
        },
      ),
    );
  }
}
