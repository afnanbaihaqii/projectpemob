import 'package:flutter/material.dart';
import 'package:pawtrack/models/pet.dart'; 

class Cat extends Pet {
  Cat({required String id, required String name, required String imageUrl, required String description})
      : super(id: id, name: name, imageUrl: imageUrl, type: 'cat', description: description);
}

class CatAdoptionPage extends StatefulWidget {
  @override
  _CatAdoptionPageState createState() => _CatAdoptionPageState();
}

class _CatAdoptionPageState extends State<CatAdoptionPage> {
  List<Pet> pets = [];
  String selectedType = 'all';
  final List<String> petTypes = ['all', 'cat', 'dog'];

  void _addPet(String name, String imageUrl, String type, String description) {
    if (name.isEmpty || imageUrl.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua input harus diisi!')),
      );
      return;
    }

    setState(() {
      pets.add(Pet(
        id: DateTime.now().toString(),
        name: name,
        imageUrl: imageUrl,
        type: type,
        description: description,
      ));
    });
  }

  void _sendAdoptionRequest(Pet pet) async {
    try {
      await addAdoptionRequest(pet);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permintaan adopsi dikirim untuk ${pet.name}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengirim permintaan adopsi')),
      );
    }
  }

  void _removePet(String id) {
    setState(() {
      pets.removeWhere((pet) => pet.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredPets = selectedType == 'all'
        ? pets
        : pets.where((pet) => pet.type == selectedType).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopsi Hewan'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Temukan Hewan yang Cocok untuk Anda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pilih Jenis Hewan:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedType,
                  items: petTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type[0].toUpperCase() + type.substring(1)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredPets.length,
                itemBuilder: (context, index) {
                  final pet = filteredPets[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network(
                            pet.imageUrl,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pet.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                pet.description,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _sendAdoptionRequest(pet),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Adopsi'),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removePet(pet.id),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String name = '';
                    String imageUrl = '';
                    String description = '';
                    String type = petTypes[1];

                    return AlertDialog(
                      title: const Text('Tambah Hewan'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: const InputDecoration(labelText: 'Nama Hewan'),
                            onChanged: (value) => name = value,
                          ),
                          TextField(
                            decoration: const InputDecoration(labelText: 'URL Gambar'),
                            onChanged: (value) => imageUrl = value,
                          ),
                          TextField(
                            decoration: const InputDecoration(labelText: 'Deskripsi'),
                            onChanged: (value) => description = value,
                          ),
                          DropdownButton<String>(
                            value: type,
                            items: petTypes.sublist(1).map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type[0].toUpperCase() + type.substring(1)),
                              );
                            }).toList(),
                            onChanged: (value) => type = value!,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _addPet(name, imageUrl, type, description);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Tambah'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }
  
  addAdoptionRequest(Pet pet) {}
}
