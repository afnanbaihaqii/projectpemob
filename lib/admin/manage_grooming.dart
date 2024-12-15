import 'package:flutter/material.dart';
import 'package:pawtrack/models/grooming_service.dart';
import 'package:pawtrack/utils/styles.dart';
import 'package:pawtrack/pages/grooming_page.dart';

class ManageGrooming extends StatefulWidget {
  @override
  _ManageGroomingState createState() => _ManageGroomingState();
}

class _ManageGroomingState extends State<ManageGrooming> {
  List<GroomingService> services = [];

  void _addService(String name, String description, double price) {
    setState(() {
      services.add(GroomingService(
        id: DateTime.now().toString(),
        name: name,
        description: description,
        price: price,
      ));
    });
  }

  void _removeService(String id) {
    setState(() {
      services.removeWhere((service) => service.id == id);
    });
  }

  void _navigateToGroomingPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GroomingPage(services: services),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Grooming'),
        backgroundColor: Styles.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Manage Your Grooming Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(service.name, style: const TextStyle(fontSize: 20)),
                      subtitle: Text(
                          'Description: ${service.description}\nPrice: \$${service.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeService(service.id),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToGroomingPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                'View Grooming Services',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String name = '';
                    String description = '';
                    String priceString = '';
                    return AlertDialog(
                      title: Text('Add Grooming Service'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: 'Service Name'),
                            onChanged: (value) => name = value,
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Description'),
                            onChanged: (value) => description = value,
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Price'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => priceString = value,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            double price = double.tryParse(priceString) ?? 0.0;
                            _addService(name, description, price);
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
              backgroundColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
