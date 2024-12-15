import 'package:pawtrack/models/package_details.dart';

class Vet {
  final String id;
  final String title;
  final String? sub;
  final String petImage;
  final List<String> items;
  final double price;

  Vet({
    required this.id,
    required this.title,
    this.sub,
    required this.petImage,
    required this.items,
    required this.price,
  });

  VeterinaryDetails toVeterinaryDetails() {
    return VeterinaryDetails(
      title: title,
      sub: sub ?? '',
      pet: petImage,
      items: items,
      price: price.toInt(),
    );
  }
}
