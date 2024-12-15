import 'package:flutter/material.dart';
import 'pages/get_started.dart';
import 'admin/admin_dashboard.dart';
import 'utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AdoptMe',
      theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Styles.blackColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: Styles.blackColor)),
      home: const GetStarted(),
      routes: {
        '/admin': (context) => const AdminDashboard(),
        
      },
    );
  }
}