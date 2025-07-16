import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_event.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_state.dart';
import 'package:car_wash/features/services/presentation/pages/service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:car_wash/features/auth/presentation/screen/forgot_password.dart';
import 'package:car_wash/features/auth/presentation/screen/login_screen.dart';
import 'package:car_wash/features/auth/presentation/screen/register_screen.dart';
import 'package:car_wash/features/carWash/presentation/pages/home_page.dart';
import 'package:car_wash/features/splash/presentation/screen/splash_screen.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_bloc.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/services/:carWashId',
      builder: (context, state) {
        final carWashId = state.pathParameters['carWashId']!;
        print('Navigating to /services/$carWashId, state: ${context.read<DashboardBloc>().state}');
        final dashboardState = context.read<DashboardBloc>().state;
        CarWash? carWash;
        if (dashboardState is DashboardLoaded) {
          try {
            carWash = dashboardState.carWashes.firstWhere(
              (wash) => wash.id == carWashId,
              orElse: () => throw Exception('CarWash not found'),
            );
            print('Found car wash: ${carWash.name} (ID: $carWashId)');
          } catch (e) {
            print('CarWash not found for ID: $carWashId');
            return Scaffold(
              appBar: AppBar(title: const Text('Services')),
              body: Center(child: Text('Car Wash with ID $carWashId not found')),
            );
          }
        } else {
          print('DashboardBloc state is not DashboardLoaded: $dashboardState');
          return Scaffold(
            appBar: AppBar(title: const Text('Services')),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Car wash data not loaded'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      print('AppRouter: Triggering FetchUserLocation');
                      context.read<DashboardBloc>().add(FetchUserLocation());
                    },
                    child: const Text('Retry Loading Car Washes'),
                  ),
                ],
              ),
            ),
          );
        }
        return ServicesPage(carWash: carWash);
      },
    ),
  ]
);