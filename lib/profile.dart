// import 'package:car_wash/models/cars.dart';
// import 'package:flutter/material.dart';


// import 'package:intl/intl.dart';

// class ProfilePage extends StatelessWidget {
//   final List<Booking> bookings;

//   const ProfilePage({super.key, required this.bookings});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           _buildUserInfo(),
//           const Divider(),
//           Expanded(child: _buildBookingHistory()),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserInfo() {
    
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 40,
//             backgroundImage: AssetImage('assets/avatar_placeholder.png'), // Add your asset or network image
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 4),
//               const Text('john.doe@example.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBookingHistory() {
//     if (bookings.isEmpty) {
//       return const Center(child: Text('No bookings yet.'));
//     }
//     return ListView.builder(
//       padding: const EdgeInsets.all(10),
//       itemCount: bookings.length,
//       itemBuilder: (context, index) {
//         final booking = bookings[index];
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           child: ListTile(
//             leading: Image.network(booking.carWash.imageUrl, width: 60, fit: BoxFit.cover),
//             title: Text('${booking.carWash.name} - ${booking.service.name}'),
//             subtitle: Text(
//               'Date: ${DateFormat.yMMMd().add_jm().format(booking.dateTime)}\n'
//               'Payment: ${booking.paymentMethod}\n'
//               'Status: Confirmed',
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
