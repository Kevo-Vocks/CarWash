import 'dart:math';

import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class CarWashListItem extends StatelessWidget {
  final CarWash carWash;
  final LocationData? userLocation;
  final VoidCallback onTap;

  const CarWashListItem({
    super.key,
    required this.carWash,
    required this.userLocation,
    required this.onTap,
  });

  bool isOpenNow(String openHours) {
    try {
      final parts = openHours.split(' - ');
      if (parts.length != 2) return false;

      TimeOfDay parseTime(String t) {
        final format = RegExp(r'(\d+):(\d+) (AM|PM)');
        final match = format.firstMatch(t);
        if (match == null) throw Exception('Invalid time format');
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        final ampm = match.group(3);
        if (ampm == 'PM' && hour != 12) hour += 12;
        if (ampm == 'AM' && hour == 12) hour = 0;
        return TimeOfDay(hour: hour, minute: minute);
      }

      final now = TimeOfDay.now();
      final open = parseTime(parts[0]);
      final close = parseTime(parts[1]);

      bool afterOpen = (now.hour > open.hour) || (now.hour == open.hour && now.minute >= open.minute);
      bool beforeClose = (now.hour < close.hour) || (now.hour == close.hour && now.minute <= close.minute);

      return afterOpen && beforeClose;
    } catch (_) {
      return false;
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    final openStatus = isOpenNow(carWash.openHours) ? 'Open now' : 'Closed';
    final distanceKm = userLocation != null
        ? calculateDistance(
            userLocation!.latitude!,
            userLocation!.longitude!,
            carWash.latitude,
            carWash.longitude,
          )
        : 0.0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(carWash.imageUrl, width: 80, fit: BoxFit.cover),
        title: Text(carWash.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(carWash.location),
            const SizedBox(height: 4),
            Text('Open Hours: ${carWash.openHours}', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
            const SizedBox(height: 4),
            Text(
              openStatus,
              style: TextStyle(
                fontSize: 12,
                color: openStatus == 'Open now' ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('Distance: ${distanceKm.toStringAsFixed(2)} km', style: const TextStyle(fontSize: 12)),
          ],
        ),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }
}