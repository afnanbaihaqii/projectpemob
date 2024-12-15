import 'package:flutter/material.dart';
import 'home.dart'; 
import '/admin/admin_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username, _password;
  String? _selectedRole = 'user'; // Role default

  // Simulasi proses login
  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_username == 'admin' && _password == 'admin123' && _selectedRole == 'admin') {
        // Login sebagai Admin
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
      } else if (_username == 'user' && _password == 'user123' && _selectedRole == 'user') {
        // Login sebagai User
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Home()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed! Check credentials')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                onSaved: (value) => _username = value,
                validator: (value) => value!.isEmpty ? 'Enter your username' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => _password = value,
                validator: (value) => value!.isEmpty ? 'Enter your password' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: const [
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'user', child: Text('User')),
                ],
                onChanged: (value) => setState(() => _selectedRole = value),
                decoration: const InputDecoration(labelText: 'Select Role'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
