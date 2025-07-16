
import 'package:equatable/equatable.dart';

class CarWash extends Equatable {
  final String id;
  final String name;
  final String location;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String openHours;

  const CarWash({
    required this.id,
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.openHours,
  });

  @override
  List<Object?> get props => [id, name, location, latitude, longitude, imageUrl, openHours];
}

