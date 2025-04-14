import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'dart:io';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Map<String, dynamic>>> _predictions;
  final Set<int> _selectedItems = {};

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
    final int count = _selectedItems.length;

    for (int id in _selectedItems) {
      await DatabaseHelper().deletePrediction(id);
    }

    setState(() {
      _selectedItems.clear();
    });

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
        title: Text('Historique'),
        actions: [
          if (_selectedItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: _deleteSelectedItems,
            ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _predictions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune prédiction trouvée.'));
          }

          final predictions = snapshot.data!;

          return Column(
            children: [
              if (predictions.length > 1)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sélection : ${_selectedItems.length}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => _toggleSelectAll(predictions),
                        child: Text(
                          _selectedItems.length == predictions.length
                              ? "Tout désélectionner"
                              : "Tout sélectionner",
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  itemCount: predictions.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final prediction = predictions[index];
                    final isSelected =
                        _selectedItems.contains(prediction['id']);

                    return ListTile(
                      leading: _buildImage(prediction['imagePath']),
                      title: Text(prediction['plantName']),
                      subtitle: Text(
                        'Maladie: ${prediction['disease']}\n'
                        'Conseil: ${prediction['advice']}\n'
                        'Date: ${prediction['dateTime']}',
                      ),
                      tileColor: isSelected ? Colors.blue.shade100 : null,
                      onLongPress: () => _toggleSelection(prediction['id']),
                      onTap: () {
                        if (_selectedItems.isNotEmpty) {
                          _toggleSelection(prediction['id']);
                        } else {
                          Navigator.pushNamed(context, '/predict',
                              arguments: prediction);
                        }
                      },
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
          return Icon(Icons.broken_image, size: 50, color: Colors.grey);
        },
      ),
    );
  }
}
