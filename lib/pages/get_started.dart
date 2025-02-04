import 'package:pawtrack/pages/home.dart';
import 'package:pawtrack/pages/login_page.dart'; // Import halaman login
import 'package:pawtrack/utils/layouts.dart';
import 'package:pawtrack/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 700),
        builder: (context, value, _) {
          return Column(
            children: [
              Opacity(
                opacity: value,
                child: SizedBox(
                  width: double.infinity,
                  height: Layouts.getSize(context).height * 0.65,
                  child: SvgPicture.asset(
                    'assets/svg/starter_header.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(25),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  'Pawtrack',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Styles.blackColor,
                    fontSize: value * 26,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ).apply(fontWeightDelta: 2),
                ),
              ),
              const Gap(5),
              Text(
                'Adopt me, we both need the love',
                // ignore: deprecated_member_use
                textScaleFactor: value,
                style: TextStyle(color: Styles.highlightColor),
              ),
              const Gap(30),
              Opacity(
                opacity: value,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Home()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: const Text('Get Started',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                    const Gap(15), // Jarak antara button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800], // Warna button
                        elevation: 0,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
