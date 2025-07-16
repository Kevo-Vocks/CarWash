import 'package:car_wash/features/carWash/presentation/bloc/dashboard_bloc.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_event.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_state.dart';
import 'package:car_wash/features/carWash/presentation/widgets/car_wash_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    print('DashboardPage: Initializing, triggering FetchUserLocation');
    context.read<DashboardBloc>().add(FetchUserLocation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        print('DashboardPage: Current state: $state');
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardLoaded) {
          print('DashboardPage: Loaded ${state.carWashes.length} car washes');
          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: state.isMapExpanded ? MediaQuery.of(context).size.height * 0.6 : 200,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(
                        state.userLocation?.latitude ?? -1.2921,
                        state.userLocation?.longitude ?? 36.8219,
                      ),
                      initialZoom: 13,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.car_wash',
                      ),
                      MarkerLayer(
                        markers: [
                          if (state.userLocation != null &&
                              state.userLocation!.latitude != null &&
                              state.userLocation!.longitude != null)
                            Marker(
                              point: LatLng(
                                state.userLocation!.latitude ?? -1.2921,
                                state.userLocation!.longitude ?? 36.8219,
                              ),
                              child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
                            ),
                          ...state.carWashes.map((wash) => Marker(
                                point: LatLng(wash.latitude, wash.longitude),
                                child: const Icon(Icons.location_on, color: Colors.red),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.read<DashboardBloc>().add(ToggleMapExpansion()),
                child: Text(state.isMapExpanded ? "Collapse Map 🔽" : "Expand Map 🔼"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.location_pin, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      'Nearest car washes to you',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[700],
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.carWashes.length,
                  itemBuilder: (context, index) {
                    final carWash = state.carWashes[index];
                    print('DashboardPage: Rendering car wash ID: ${carWash.id}, Name: ${carWash.name}');
                    return CarWashListItem(
                      carWash: carWash,
                      userLocation: state.userLocation,
                      onTap: () {
                        print('DashboardPage: Navigating to /services/${carWash.id}');
                        context.go('/services/${carWash.id}');
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is DashboardError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<DashboardBloc>().add(FetchUserLocation()),
                  child: const Text('Retry Location Permission'),
                ),
              ],
            ),
          );
        }
        return Center(
          child: ElevatedButton(
            onPressed: () => context.read<DashboardBloc>().add(FetchUserLocation()),
            child: const Text('Fetch Car Washes'),
          ),
        );
      },
    );
  }
}