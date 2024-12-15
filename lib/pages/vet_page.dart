import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pawtrack/models/vet_service.dart';
import 'package:pawtrack/utils/styles.dart';
import 'package:pawtrack/widgets/back_button.dart';
import 'package:pawtrack/widgets/vet_card.dart';
import 'package:pawtrack/admin/manage_vet.dart';

class VetPage extends StatefulWidget {
  const VetPage({super.key});

  @override
  State<VetPage> createState() => _VetPageState();
}

class _VetPageState extends State<VetPage> {
  late ScrollController _controller;
  double headerHeight = 140;

  List<Vet> veterinaryPackage = [
    Vet(
      id: '1',
      title: 'Dokter Hewan (Kucing)',
      petImage: 'assets/svg/pet_circle.svg',
      items: [
        'Konsultasi sekali saja',
        'Konsultasi melalui Panggilan & Video',
        'Saran yang Dipersonalisasi',
      ],
      price: 149.0,
    ),
    Vet(
      id: '2',
      title: 'Perawatan Esensial Online',
      sub: '(220 menit/bulan)',
      petImage: 'assets/svg/pet_circle.svg',
      items: [
        'Konsultasi melalui Chat',
        'Saran yang Dipersonalisasi',
        'Tindak lanjut selama 1 bulan',
        'Pencegahan Kutu & Tungau',
      ],
      price: 499.0,
    ),
  ];

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        headerHeight = _controller.offset > 0 ? 0 : 140;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.manage_accounts),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminVetManagement(
                vets: veterinaryPackage,
              ),
            ),
          );

          if (result != null) {
            setState(() {
              veterinaryPackage = result;
            });
          }
        },
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Gap(100),
                AnimatedContainer(
                  margin: EdgeInsets.only(bottom: headerHeight == 0 ? 0 : 16),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInExpo,
                  width: double.infinity,
                  height: headerHeight,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/png/vet.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Styles.bgColor, width: 3),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: _controller,
                    itemBuilder: (context, index) {
                      final vet = veterinaryPackage[index];
                      return VetCard(vet.toVeterinaryDetails());
                    },
                    separatorBuilder: (context, index) => const Gap(12),
                    itemCount: veterinaryPackage.length,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            child: Row(
              children: [
                const PetBackButton(),
                const Gap(20),
                Text(
                  'Pet Veterinary',
                  style: TextStyle(
                    color: Styles.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
