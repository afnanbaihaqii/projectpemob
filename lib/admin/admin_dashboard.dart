import 'package:flutter/material.dart';
import 'package:pawtrack/models/pet.dart';
import 'package:pawtrack/utils/styles.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<Pet> pets = [];
  List<Pet> adoptionRequests = []; // Request adopsi dari user
  List<String> groomingServices = []; // Data layanan grooming

  // Fungsi untuk menambahkan layanan grooming
  void _addGroomingService(String service) {
    setState(() {
      groomingServices.add(service);
    });
  }

  // Fungsi menghapus layanan grooming
  void _removeGroomingService(int index) {
    setState(() {
      groomingServices.removeAt(index);
    });
  }

  // Menambahkan data hewan baru
  void _addPet(String name, String imageUrl, String type, String description) {
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

  // Menghapus data hewan
  void _removePet(String id) {
    setState(() {
      pets.removeWhere((pet) => pet.id == id);
    });
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildPetManagementPage(),
      _buildAdoptionRequestPage(),
      _buildGroomingManagementPage(),
      _buildVetManagementPage(), // Halaman Manage Vet
    ]);
  }

  // Halaman untuk manajemen dokter hewan
  Widget _buildVetManagementPage() {
    return const Column(
      children: [
        Text(
          'Manage Vet',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Center(
            child: Text("Manage Vet Page"), // Halaman untuk manage vet
          ),
        ),
      ],
    );
  }

  // Halaman utama untuk manajemen pets
  Widget _buildPetManagementPage() {
    return Column(
      children: [
        const Text(
          'Manage Pets',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text(pet.name, style: TextStyle(fontSize: 20)),
                  leading: Image.network(pet.imageUrl,
                      width: 50, height: 50, fit: BoxFit.cover),
                  subtitle: Text('Type: ${pet.type}\n${pet.description}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removePet(pet.id),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Halaman untuk request adopsi
  Widget _buildAdoptionRequestPage() {
    return Column(
      children: [
        const Text(
          'Adoption Requests',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: adoptionRequests.length,
            itemBuilder: (context, index) {
              final pet = adoptionRequests[index];
              return Card(
                child: ListTile(
                  title: Text(pet.name),
                  subtitle: Text('Requested for Adoption'),
                  leading: Image.network(pet.imageUrl,
                      width: 50, height: 50, fit: BoxFit.cover),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () => _acceptAdoption(pet.id),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () => _rejectAdoption(pet.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Halaman untuk manajemen grooming
  Widget _buildGroomingManagementPage() {
    return Column(
      children: [
        const Text(
          'Grooming Services',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: groomingServices.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(groomingServices[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeGroomingService(index),
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
                String service = '';
                return AlertDialog(
                  title: Text('Add Grooming Service'),
                  content: TextField(
                    decoration: InputDecoration(labelText: 'Service Name'),
                    onChanged: (value) => service = value,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _addGroomingService(service);
                        Navigator.of(context).pop();
                      },
                      child: Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Styles.bgColor,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Manage Pets"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Adoption Requests"),
          BottomNavigationBarItem(
              icon: Icon(Icons.brush), label: "Layanan Grooming"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), label: "Kelola Dokter Hewan"),
        ],
      ),
    );
  }

  void _acceptAdoption(String id) {
    setState(() {
      adoptionRequests.removeWhere((pet) => pet.id == id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Adoption request accepted!")),
      );
    });
  }

  void _rejectAdoption(String id) {
    setState(() {
      adoptionRequests.removeWhere((pet) => pet.id == id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Adoption request rejected.")),
      );
    });
  }
}
