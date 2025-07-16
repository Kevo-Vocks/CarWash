import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';
import 'package:car_wash/features/carWash/domain/entities/booking.dart';
import 'package:car_wash/features/services/domain/entities/service.dart';
import 'package:car_wash/features/services/presentation/bloc/services_bloc.dart';
import 'package:car_wash/features/services/presentation/bloc/services_event.dart';

import '../widgets/service_list.dart';
import '../widgets/booking_bottom_sheet.dart';

class ServicesPage extends StatefulWidget {
  final CarWash carWash;

  const ServicesPage({Key? key, required this.carWash}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<Service> _selectedServices = [];
  bool _isBookingExpanded = false;
  DateTime? _selectedDateTime;
  String? _paymentMethod;
  bool _isProcessingPayment = false;

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _mpesaNumberController = TextEditingController();

  double get _totalPrice =>
      _selectedServices.fold(0.0, (sum, service) => sum + service.price);

  void _toggleBookingExpansion() {
    if (_selectedServices.isNotEmpty && !_isBookingExpanded) {
      setState(() => _isBookingExpanded = true);
    }
  }

  void _collapseBooking() {
    setState(() {
      _isBookingExpanded = false;
      _selectedDateTime = null;
      _paymentMethod = null;
      _cardNumberController.clear();
      _mpesaNumberController.clear();
    });
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  Future<void> _processMpesaPayment() async {
    if (_mpesaNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your Mpesa phone number')),
      );
      return;
    }

    setState(() => _isProcessingPayment = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isProcessingPayment = false);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mpesa Payment'),
        content: Text('Payment request sent to ${_mpesaNumberController.text}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitBooking() async {
    if (_selectedDateTime == null || _paymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date/time and payment method')),
      );
      return;
    }

    if ((_paymentMethod == 'Visa' || _paymentMethod == 'PayPal') &&
        _cardNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your $_paymentMethod card number')),
      );
      return;
    }

    if (_paymentMethod == 'Mpesa') {
      await _processMpesaPayment();
    }

    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      carWash: widget.carWash,
      services: _selectedServices,
      dateTime: _selectedDateTime!,
      paymentMethod: _paymentMethod!,
      cardNumber: (_paymentMethod == 'Visa' || _paymentMethod == 'PayPal')
          ? _cardNumberController.text
          : null,
      mpesaNumber: _paymentMethod == 'Mpesa' ? _mpesaNumberController.text : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking successful!')),
    );
    _collapseBooking();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _mpesaNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ServicesBloc>().add(FetchServices(widget.carWash.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carWash.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
        backgroundColor: Colors.blue[700],
      ),
      body: Stack(
        children: [
          ServiceList(
            selectedServices: _selectedServices,
            carWashId: widget.carWash.id,
            onServiceToggle: (service, isSelected) {
              setState(() {
                if (isSelected) {
                  _selectedServices.add(service);
                } else {
                  _selectedServices.remove(service);
                }
              });
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            // bottom: MediaQuery.of(context).padding.bottom,
            bottom: 0,
            child: BookingBottomSheet(
              isExpanded: _isBookingExpanded,
              selectedServices: _selectedServices,
              totalPrice: _totalPrice,
              selectedDateTime: _selectedDateTime,
              paymentMethod: _paymentMethod,
              isProcessingPayment: _isProcessingPayment,
              onCollapse: _collapseBooking,
              onExpand: _toggleBookingExpansion,
              onPickDateTime: _pickDateTime,
              onPaymentMethodChanged: (value) => setState(() {
                _paymentMethod = value;
                _cardNumberController.clear();
                _mpesaNumberController.clear();
              }),
              onSubmitBooking: _submitBooking,
              cardNumberController: _cardNumberController,
              mpesaNumberController: _mpesaNumberController,
            ),
          ),
        ],
      ),
    );
  }
}
