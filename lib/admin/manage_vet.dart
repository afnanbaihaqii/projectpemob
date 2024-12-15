import 'package:flutter/material.dart';
import 'package:pawtrack/models/vet_service.dart';

class AdminVetManagement extends StatefulWidget {
  final List<Vet> vets;

  const AdminVetManagement({super.key, required this.vets});

  @override
  State<AdminVetManagement> createState() => _AdminVetManagementState();
}


class _AdminVetManagementState extends State<AdminVetManagement> {
  late List<Vet> _vets;

  @override
  void initState() {
    super.initState();
    _vets = widget.vets; // Inisialisasi daftar vets dari parameter
  }

  // Fungsi untuk menambah vet baru
  void _addVet(Vet vet) {
    setState(() {
      _vets.add(vet);
    });
  }

  // Fungsi untuk menghapus vet
  void _deleteVet(String id) {
    setState(() {
      _vets.removeWhere((vet) => vet.id == id);
    });
  }

  // Fungsi untuk mengedit vet
  void _editVet(String id, Vet updatedVet) {
    setState(() {
      final index = _vets.indexWhere((vet) => vet.id == id);
      if (index != -1) _vets[index] = updatedVet;
    });
  }

  // Dialog untuk menambah atau mengedit vet
  void _showVetForm({Vet? vet}) {
    final _formKey = GlobalKey<FormState>();
    String title = vet?.title ?? '';
    String sub = vet?.sub ?? '';
    String petImage = vet?.petImage ?? '';
    String items = vet?.items.join(', ') ?? '';
    double price = vet?.price ?? 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(vet == null ? 'Add Vet' : 'Edit Vet'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  onChanged: (val) => title = val,
                ),
                TextFormField(
                  initialValue: sub,
                  decoration: const InputDecoration(labelText: 'Subtitle'),
                  onChanged: (val) => sub = val,
                ),
                TextFormField(
                  initialValue: petImage,
                  decoration: const InputDecoration(labelText: 'Pet Image URL'),
                  onChanged: (val) => petImage = val,
                ),
                TextFormField(
                  initialValue: items,
                  decoration: const InputDecoration(labelText: 'Items (comma-separated)'),
                  onChanged: (val) => items = val,
                ),
                TextFormField(
                  initialValue: price.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                  onChanged: (val) => price = double.tryParse(val) ?? 0,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newVet = Vet(
                    id: vet?.id ?? DateTime.now().toString(),
                    title: title,
                    sub: sub,
                    petImage: petImage,
                    items: items.split(',').map((e) => e.trim()).toList(),
                    price: price,
                  );

                  if (vet == null) {
                    _addVet(newVet);
                  } else {
                    _editVet(vet.id, newVet);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text(vet == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vet Management'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, _vets); // Kembalikan daftar yang diperbarui
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _vets.length,
        itemBuilder: (context, index) {
          final vet = _vets[index];
          return Card(
            child: ListTile(
              title: Text(vet.title),
              subtitle: Text('Price: \$${vet.price.toString()}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showVetForm(vet: vet),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteVet(vet.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showVetForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
