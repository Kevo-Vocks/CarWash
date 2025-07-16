import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';

abstract class CarWashDataSource {
  Future<List<CarWash>> getCarWashes();
}

class CarWashDataSourceImpl implements CarWashDataSource {
  @override
  Future<List<CarWash>> getCarWashes() async {
    // Static list of car washes
    return carWashes;
  }
}

// Static list from your provided code
final List<CarWash> carWashes = [
  CarWash(
    id: '1',
    name: 'Sparkle Wash',
    imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=800&q=80',
    // services: 'SparkleWashServices',
    location: '123 Main Street, Downtown',
    openHours: '8:00 AM - 8:00 PM',
    latitude: -1.2921,
    longitude: 36.8219,
  ),
  CarWash(
    id: '2',
    name: 'CleanRide',
    imageUrl: 'https://images.unsplash.com/photo-1549924231-f129b911e442?auto=format&fit=crop&w=800&q=80',
    // services: 'CleanRide',
    location: '456 Elm Avenue, Uptown',
    openHours: '7:00 AM - 9:00 PM',
    latitude: -1.2833,
    longitude: 36.8167,
  ),
  CarWash(
    id: '3',
    name: 'Extreme Clean - Ananas Mall',
    imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
    // services: 'ExtremeCleanAnanasMall',
    location: 'Ananas Mall, Kiambu',
    openHours: '7:00 AM - 7:00 PM',
    latitude: -1.1700,
    longitude: 36.8300,
  ),
  CarWash(
    id: '4',
    name: 'Ashworth Car Wash',
    imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=800&q=80',
    // services: 'AshworthCarWash',
    location: 'Westlands Road, Nairobi',
    openHours: '7:00 AM - 5:00 PM',
    latitude: -1.2600,
    longitude: 36.7960,
  ),
  CarWash(
    id: '5',
    name: 'Auto Sparkle Car Wash',
    imageUrl: 'https://images.unsplash.com/photo-1549924231-f129b911e442?auto=format&fit=crop&w=800&q=80',
    // services: 'AutoSparkleCarWash',
    location: 'Peponi Road opposite Sarit Center, Nairobi',
    openHours: '7:00 AM - 7:00 PM',
    latitude: -1.2540,
    longitude: 36.8070,
  ),
  CarWash(
    id: '6',
    name: 'The Rok Carwash',
    imageUrl: 'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=800&q=80',
    // services: 'TheRokCarwash',
    location: '16 School Lane, Nairobi',
    openHours: '8:00 AM - 6:00 PM',
    latitude: -1.2800,
    longitude: 36.8200,
  ),
  CarWash(
    id: '7',
    name: 'Wambugu Car Wash Centre',
    imageUrl: 'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?auto=format&fit=crop&w=800&q=80',
    // services: 'WambuguCarWashCentre',
    location: 'Parklands, Nairobi',
    openHours: '7:00 AM - 6:00 PM',
    latitude: -1.2605,
    longitude: 36.8300,
  ),
  CarWash(
    id: '8',
    name: 'The Accacian Car Wash',
    imageUrl: 'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?auto=format&fit=crop&w=800&q=80',
    // services: 'TheAccacianCarWash',
    location: 'Limuru Road, Ruaka',
    openHours: '7:00 AM - 8:00 PM',
    latitude: -1.2100,
    longitude: 36.7800,
  ),
  CarWash(
    id: '9',
    name: 'Happy Vantage Car Wash',
    imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=800&q=80',
    // services: 'HappyVantageCarWash',
    location: 'Ruaka Town',
    openHours: '8:00 AM - 7:00 PM',
    latitude: -1.2100,
    longitude: 36.7800,
  ),
  CarWash(
    id: '10',
    name: 'Safi Car Wash',
    imageUrl: 'https://images.unsplash.com/photo-1515377905703-c4788e51af15?auto=format&fit=crop&w=800&q=80',
    // services: 'SafiCarWash',
    location: 'Kiambu Town',
    openHours: '7:00 AM - 6:00 PM',
    latitude: -1.1700,
    longitude: 36.8300,
  ),
];