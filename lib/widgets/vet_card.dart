import 'package:pawtrack/models/package_details.dart';
import 'package:pawtrack/utils/layouts.dart';
import 'package:pawtrack/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'book_button.dart';

class VetCard extends StatelessWidget {
  final VeterinaryDetails vetItem;
  const VetCard(this.vetItem, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return FittedBox(
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Styles.bgColor,
          borderRadius: BorderRadius.circular(17),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Bagian Kiri: Detail Layanan
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Gap(5),
                    Text(
                      vetItem.title,
                      style: TextStyle(
                        color: Styles.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const Gap(7),
                    // Null safety untuk pet (ikon hewan)
                    if (vetItem.pet != null)
                      SvgPicture.asset(
                        vetItem.pet!,
                        height: 30,
                      ),
                  ],
                ),
                const Gap(15),
                // Daftar Item Layanan
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: vetItem.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '• $item ',
                            style: TextStyle(
                              color: Styles.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          if (index == 0 && vetItem.sub != null) // Null safety untuk sub
                            TextSpan(
                              text: vetItem.sub!,
                              style: TextStyle(
                                color: Styles.highlightColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const Gap(8),
              ],
            ),

            // Bagian Kanan: Harga dan Tombol
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40, bottom: 12),
                  child: Column(
                    children: [
                      Text(
                        'Rp${vetItem.price}',
                        style: TextStyle(
                          color: Styles.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        'starting cost',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                const BookButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
