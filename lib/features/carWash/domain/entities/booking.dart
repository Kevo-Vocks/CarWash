import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';
import 'package:car_wash/features/services/domain/entities/service.dart';
import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String id;
  final CarWash carWash;
  final List<Service> services;
  final DateTime dateTime;
  final String paymentMethod;
  final String? cardNumber;
  final String? mpesaNumber;

  const Booking({
    required this.id,
    required this.carWash,
    required this.services,
    required this.dateTime,
    required this.paymentMethod,
    this.cardNumber,
    this.mpesaNumber,
  });

  @override
  List<Object?> get props => [id, carWash, services, dateTime, paymentMethod, cardNumber, mpesaNumber];
}