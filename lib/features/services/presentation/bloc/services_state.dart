import 'package:car_wash/features/services/domain/entities/service.dart';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<Service> services;

  ServicesLoaded({required this.services});
}

class ServicesError extends ServicesState {
  final String message;

  ServicesError({required this.message});
}