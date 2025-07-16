
import 'dart:math';

import 'package:car_wash/features/carWash/presentation/bloc/dashboard_event.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_wash/features/carWash/domain/usecases/get_nearest_car_washes.dart';
import 'package:car_wash/features/carWash/domain/usecases/get_user_location.dart';
import 'dart:async';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetUserLocation getUserLocation;
  final GetNearestCarWashes getNearestCarWashes;
  StreamSubscription? _locationSubscription;

  DashboardBloc({
    required this.getUserLocation,
    required this.getNearestCarWashes,
  }) : super(DashboardInitial()) {
    on<FetchUserLocation>(_onFetchUserLocation);
    on<ToggleMapExpansion>(_onToggleMapExpansion);
    on<ChangeTab>(_onChangeTab);
    on<StartLocationListening>(_onStartLocationListening);
    on<StopLocationListening>(_onStopLocationListening);
  }

  Future<void> _onFetchUserLocation(FetchUserLocation event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final locationData = await getUserLocation();
      final carWashes = await getNearestCarWashes(locationData);
      emit(DashboardLoaded(
        userLocation: locationData,
        carWashes: carWashes,
        isMapExpanded: false,
        selectedIndex: 0,
      ));
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  void _onToggleMapExpansion(ToggleMapExpansion event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(currentState.copyWith(isMapExpanded: !currentState.isMapExpanded));
    }
  }

  void _onChangeTab(ChangeTab event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(currentState.copyWith(selectedIndex: event.index));
    } else {
      emit(DashboardLoaded(
        userLocation: null,
        carWashes: [],
        isMapExpanded: false,
        selectedIndex: event.index,
      ));
    }
  }

  Future<void> _onStartLocationListening(StartLocationListening event, Emitter<DashboardState> emit) async {
    if (_locationSubscription != null) return; // Avoid duplicate subscriptions
    emit(DashboardLoading());
    _locationSubscription = getUserLocation.streamLocation().listen(
      (locationData) async {
        if (state is DashboardLoaded) {
          final currentState = state as DashboardLoaded;
          final currentLocation = currentState.userLocation;
          if (currentLocation != null) {
            final distance = _calculateDistance(
              currentLocation.latitude!,
              currentLocation.longitude!,
              locationData.latitude!,
              locationData.longitude!,
            );
            if (distance > 500) { // Threshold in meters
              emit(DashboardLoading());
              final carWashes = await getNearestCarWashes(locationData);
              emit(currentState.copyWith(userLocation: locationData, carWashes: carWashes));
            }
          } else {
            emit(DashboardLoading());
            final carWashes = await getNearestCarWashes(locationData);
            emit(DashboardLoaded(
              userLocation: locationData,
              carWashes: carWashes,
              isMapExpanded: false,
              selectedIndex: 0,
            ));
          }
        }
      },
      onError: (e) => emit(DashboardError(message: e.toString())),
      onDone: () => _locationSubscription = null,
    );
  }

  Future<void> _onStopLocationListening(StopLocationListening event, Emitter<DashboardState> emit) async {
    if (_locationSubscription != null) {
      await _locationSubscription!.cancel();
      _locationSubscription = null;
    }
  }


double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000; // meters
  final double dLat = _toRadians(lat2 - lat1);
  final double dLon = _toRadians(lon2 - lon1);
  final double a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(_toRadians(lat1)) * cos(_toRadians(lat2));
  final double c = 2 * sqrt(a) * atan2(sqrt(a), sqrt(1 - a)); // Corrected atan usage
  return earthRadius * c;
}

double _toRadians(double degree) => degree * (pi / 180); // Use pi from dart:math
}