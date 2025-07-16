import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';
import 'package:location/location.dart';

abstract class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final LocationData? userLocation;
  final List<CarWash> carWashes;
  final bool isMapExpanded;
  final int selectedIndex;

  DashboardLoaded({
    required this.userLocation,
    required this.carWashes,
    required this.isMapExpanded,
    required this.selectedIndex,
  });

  DashboardLoaded copyWith({
    LocationData? userLocation,
    List<CarWash>? carWashes,
    bool? isMapExpanded,
    int? selectedIndex,
  }) {
    return DashboardLoaded(
      userLocation: userLocation ?? this.userLocation,
      carWashes: carWashes ?? this.carWashes,
      isMapExpanded: isMapExpanded ?? this.isMapExpanded,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError({required this.message});
}