import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Simpan data profil
  String username = "Nama Pengguna";
  String email = "email@example.com";
  String location = "Jakarta, Indonesia";
  int petCount = 3;
  String? profileImagePath = 'assets/img/img1.png'; // Path default

  // Controller untuk form edit
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController petCountController = TextEditingController();

  // Fungsi untuk mengupdate profil
  void _updateProfile() {
    setState(() {
      username = usernameController.text;
      email = emailController.text;
      location = locationController.text;
      petCount = int.tryParse(petCountController.text) ?? petCount;
    });
    Navigator.of(context).pop(); // Tutup popup
  }

  // Fungsi untuk menampilkan popup pemilihan gambar
  void _showImagePickerDialog() {
    // Daftar gambar di folder assets/img/
    final List<String> images = [
      'assets/img/img1.png',
      'assets/img/img2.png',
      'assets/img/img3.png',
      'assets/img/img4.png',
      'assets/img/img5.png',
      'assets/img/img6.png',
      'assets/img/img7.png',
      'assets/img/img8.png',
      'assets/img/img9.png',
      'assets/img/img10.png',
      'assets/img/img11.png',
      'assets/img/img12.png',
      'assets/img/img13.png',
      'assets/img/img14.png',
      'assets/img/img15.png',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Pilih Gambar Profil',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: images.map((imagePath) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      profileImagePath = imagePath; // Simpan path gambar
                    });
                    Navigator.of(context).pop(); // Tutup popup
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset(
                      imagePath,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan popup edit profil
  void _showEditProfileDialog() {
    usernameController.text = username;
    emailController.text = email;
    locationController.text = location;
    petCountController.text = petCount.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Text(
              'Edit Profil',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: const Color.fromARGB(255, 75, 215, 225),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _showImagePickerDialog, // Buka popup pemilihan gambar
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profileImagePath!),
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white70,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: "Nama Pengguna"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Lokasi"),
                ),
                TextField(
                  controller: petCountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Jumlah Hewan Peliharaan"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: _updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 75, 215, 225),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        title: Text(
          'Profil Pengguna',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor:const Color.fromARGB(255, 75, 215, 225),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(profileImagePath!),
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                username,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00796B),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 30),
              _buildProfileCard(
                icon: Icons.location_on,
                title: 'Lokasi',
                subtitle: location,
              ),
              const SizedBox(height: 15),
              _buildProfileCard(
                icon: Icons.pets,
                title: 'Jumlah Hewan Peliharaan',
                subtitle: "$petCount ekor",
              ),
              const SizedBox(height: 15),
              _buildProfileCard(
                icon: Icons.edit,
                title: 'Edit Profil',
                onTap: _showEditProfileDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xFFB2EBF2),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFFFFA726),
          size: 30,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                ),
              )
            : null,
        trailing: onTap != null ? const Icon(Icons.chevron_right, color: Colors.black54) : null,
        onTap: onTap,
      ),
    );
  }
}
