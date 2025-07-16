// service_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_wash/features/services/domain/entities/service.dart';
import 'package:car_wash/features/services/presentation/bloc/services_bloc.dart';
import 'package:car_wash/features/services/presentation/bloc/services_state.dart';
import 'package:car_wash/features/services/presentation/bloc/services_event.dart';

class ServiceList extends StatelessWidget {
  final List<Service> selectedServices;
  final void Function(Service, bool) onServiceToggle;
  final String carWashId;

  const ServiceList({
    Key? key,
    required this.selectedServices,
    required this.onServiceToggle,
    required this.carWashId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        if (state is ServicesLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue));
        } else if (state is ServicesLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.services.length,
            itemBuilder: (context, index) {
              final service = state.services[index];
              final isSelected = selectedServices.contains(service);

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: isSelected ? Colors.blue[50] : null,
                child: CheckboxListTile(
                  title: Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    'KSh ${service.price.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  value: isSelected,
                  activeColor: Colors.blue[700],
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    onServiceToggle(service, value ?? false);
                  },
                ),
              );
            },
          );
        } else if (state is ServicesError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Error: ${state.message}', style: TextStyle(color: Colors.red[700], fontSize: 16)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<ServicesBloc>().add(FetchServices(carWashId)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700]),
                  child: const Text('Retry', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No services available', style: TextStyle(color: Colors.black54)));
      },
    );
  }
}
