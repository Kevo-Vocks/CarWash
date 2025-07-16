// booking_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:car_wash/features/services/domain/entities/service.dart';
import 'payment_input.dart';

class BookingBottomSheet extends StatelessWidget {
  final bool isExpanded;
  final List<Service> selectedServices;
  final double totalPrice;
  final DateTime? selectedDateTime;
  final String? paymentMethod;
  final bool isProcessingPayment;

  final VoidCallback onCollapse;
  final VoidCallback onExpand;
  final VoidCallback onPickDateTime;
  final Function(String?) onPaymentMethodChanged;
  final VoidCallback onSubmitBooking;

  final TextEditingController cardNumberController;
  final TextEditingController mpesaNumberController;

  const BookingBottomSheet({
    Key? key,
    required this.isExpanded,
    required this.selectedServices,
    required this.totalPrice,
    required this.selectedDateTime,
    required this.paymentMethod,
    required this.isProcessingPayment,
    required this.onCollapse,
    required this.onExpand,
    required this.onPickDateTime,
    required this.onPaymentMethodChanged,
    required this.onSubmitBooking,
    required this.cardNumberController,
    required this.mpesaNumberController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentMethods = ['Visa', 'PayPal', 'Mpesa'];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: isExpanded ? 417 : 138, // Adjust height based on expansion state
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
    top: Radius.circular(30), // Smooth rounded top)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: SafeArea(
        top: false,
        child: isExpanded
            ? Column(
  children: [
    // Scrollable main content
    Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Total and Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total: KSh ${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${selectedServices.length} service(s) selected',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: onCollapse,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Date and Time Picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                selectedDateTime == null
                    ? 'Select Date & Time'
                    : DateFormat('yyyy-MM-dd – HH:mm').format(selectedDateTime!),
              ),
              trailing: const Icon(Icons.calendar_today, color: Colors.blue),
              onTap: onPickDateTime,
            ),

            const SizedBox(height: 12),

            const Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            ...['Visa', 'PayPal', 'Mpesa'].map(
              (method) => RadioListTile<String>(
                title: Text(method),
                value: method,
                groupValue: paymentMethod,
                onChanged: onPaymentMethodChanged,
                activeColor: Colors.blue[700],
                contentPadding: EdgeInsets.zero,
              ),
            ),

            PaymentInput(
              paymentMethod: paymentMethod,
              cardController: cardNumberController,
              mpesaController: mpesaNumberController,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    ),

    // Fixed bottom Confirm Booking button
    Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onSubmitBooking,
          icon: isProcessingPayment
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.check_circle_outline, color: Colors.white),
          label: const Text(
            'Confirm Booking',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ),
  ],
)

      
            : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          Text(
            'KSh ${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
          ),
          Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          '(${selectedServices.length} selected)',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ),
          ),
          const SizedBox(height: 8),
          Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: selectedServices.isEmpty ? null : onExpand,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          disabledBackgroundColor: Colors.grey[400],
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.white),
        label: const Text(
          'Book Selected Services',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
          ),
        ],
      ),
      
      ),

    );
  }
}
