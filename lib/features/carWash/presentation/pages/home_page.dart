import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_wash/features/carWash/domain/usecases/get_nearest_car_washes.dart';
import 'package:car_wash/features/carWash/domain/usecases/get_user_location.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_bloc.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_event.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_state.dart';
import 'package:car_wash/features/carWash/presentation/pages/dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print('HomePage initState');
    WidgetsBinding.instance.addObserver(this); // Start observing lifecycle changes
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Clean up observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('HomePage: App lifecycle state changed to $state');
    final bloc = context.read<DashboardBloc>();
    if (state == AppLifecycleState.resumed) {
      print('HomePage: App resumed, starting location listening');
      bloc.add(StartLocationListening());
    } else if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      print('HomePage: App paused/inactive, stopping location listening');
      bloc.add(StopLocationListening());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return BlocProvider(
      create: (context) => DashboardBloc(
        getUserLocation: context.read<GetUserLocation>(),
        getNearestCarWashes: context.read<GetNearestCarWashes>(),
      )..add(FetchUserLocation()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            _selectedIndex = state.selectedIndex;
          }
          return Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: [
                const DashboardPage(),
                // const BookingHistoryPage(bookings: []), // Placeholder, update with BookingsBloc
                // const ProfilePage(bookings: []), // Placeholder, update with BookingsBloc
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => context.read<DashboardBloc>().add(ChangeTab(index)),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'Bookings'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        },
      ),
    );
  }
}