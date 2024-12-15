import 'package:pawtrack/models/grooming_service.dart';
import 'package:pawtrack/models/package.dart';
import 'package:pawtrack/utils/layouts.dart';
import 'package:pawtrack/utils/styles.dart';
import 'package:pawtrack/widgets/back_button.dart';
import 'package:pawtrack/widgets/package_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class GroomingPage extends StatefulWidget {
  const GroomingPage({super.key, required this.services});

  final List<GroomingService> services;

  @override
  State<GroomingPage> createState() => _GroomingPageState();
}

class _GroomingPageState extends State<GroomingPage> {
  final List<Map<String, dynamic>> groomingList = [
    {'name': 'Mandi Spa', 'services': 7, 'bonus': 160, 'price': 960},
    {'name': 'Mandi + Perawatan Dasar', 'services': 10, 'bonus': 239, 'price': 1438},
    {'name': 'Layanan Lengkap', 'services': 12, 'bonus': 299, 'price': 1798},
  ];

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<Map<String, dynamic>> _packages = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      for (var i = 0; i < groomingList.length; i++) {
        listKey.currentState?.insertItem(0, duration: Duration(milliseconds: 500 - i * 200));
        _packages.add(groomingList[i]);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    builder: (context, value, _) {
                      return Stack(
                        children: [
                          Container(
                            width: value * size.width,
                            height: value * size.width,
                            decoration: BoxDecoration(
                              color: Styles.bgColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(value * size.width / 2),
                                bottomRight: Radius.circular(value * size.width / 2),
                              ),
                            ),
                            child: Column(
                              children: [
                                Gap(value * 50),
                                SvgPicture.asset(
                                  'assets/svg/person2.svg',
                                  height: value * 200,
                                ),
                                Gap(value * 20),
                                Text(
                                  'Select your pet',
                                  style: TextStyle(fontSize: value * 15, height: 2),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(left: 15, top: 50, child: PetBackButton()),
                          Positioned(
                            left: size.width * 0.3,
                            right: size.width * 0.3,
                            bottom: 40,
                            child: AnimatedScale(
                              scale: value,
                              curve: Curves.easeOutBack,
                              duration: const Duration(milliseconds: 600),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  fixedSize: Size(value * 150, value * 44),
                                  backgroundColor: Styles.bgWithOpacityColor,
                                  shape: const StadiumBorder(),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/svg/dog_icon.svg', height: value * 30),
                                    const Spacer(),
                                    Text(
                                      'Dog',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Styles.highlightColor,
                                        fontSize: value * 16,
                                      ),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset('assets/svg/arrow_down.svg', height: value * 30),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
              const Gap(10),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, _) {
                  return Text(
                    'Dog Grooming Packages',
                    style: TextStyle(
                      color: Styles.blackColor,
                      fontSize: value * 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
              const Gap(5),
              MediaQuery.removeViewPadding(
                context: context,
                removeTop: true,
                child: AnimatedList(
                  key: listKey,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  initialItemCount: _packages.length,
                  itemBuilder: (context, index, animation) {
                    final package = Package.fromJson(_packages[index]);
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-0.5, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeIn,
                        ),
                      ),
                      child: PackageCard(package),
                    );
                  },
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                builder: (context, value, _) {
                  return AnimatedScale(
                    scale: value,
                    curve: Curves.easeOutBack,
                    duration: const Duration(seconds: 1),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: const Size(215, 44),
                        backgroundColor: Styles.bgColor,
                        shape: const StadiumBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Gap(0),
                          Text(
                            'Select your package',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Styles.highlightColor,
                              fontSize: 15,
                            ),
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Styles.bgWithOpacityColor,
                            child: SvgPicture.asset(
                              'assets/svg/arrow_down2.svg',
                              height: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
