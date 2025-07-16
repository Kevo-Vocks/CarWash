import 'package:car_wash/features/carWash/presentation/bloc/dashboard_event.dart';
import 'package:car_wash/features/services/data/datasources/services_datasource.dart';
import 'package:car_wash/features/services/data/repositories/services_repository_impl.dart';
import 'package:car_wash/features/services/domain/repositories/services_repository.dart';
import 'package:car_wash/features/services/domain/usecases/get_services.dart';
import 'package:car_wash/features/services/presentation/bloc/services_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:car_wash/core/router/app_router.dart';
import 'package:car_wash/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:car_wash/features/auth/data/datasources/auth_remote_data_source_imp.dart';
import 'package:car_wash/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:car_wash/features/auth/domain/repositories/auth_repository.dart';
import 'package:car_wash/features/auth/domain/usecases/login.dart';
import 'package:car_wash/features/auth/domain/usecases/register.dart';
import 'package:car_wash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:car_wash/features/carWash/data/datasources/car_wash_datasource.dart';
import 'package:car_wash/features/carWash/data/datasources/location_datasource.dart';
import 'package:car_wash/features/carWash/data/repositories/car_wash_repository_impl.dart';
import 'package:car_wash/features/carWash/data/repositories/location_repository_impl.dart';
import 'package:car_wash/features/carWash/domain/repositories/car_wash_repository.dart';
import 'package:car_wash/features/carWash/domain/repositories/location_repository.dart';
import 'package:car_wash/features/carWash/domain/usecases/get_nearest_car_washes.dart';
import 'package:car_wash/features/carWash/domain/usecases/get_user_location.dart';
import 'package:car_wash/features/carWash/presentation/bloc/dashboard_bloc.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Authentication Providers
        Provider<AuthRemoteDataSource>(
          create: (_) {
            print('Providing AuthRemoteDataSource');
            return AuthRemoteDataSourceImpl();
          },
        ),
        Provider<AuthRepository>(
          create: (context) {
            print('Providing AuthRepository');
            return AuthRepositoryImpl(
              remoteDataSource: context.read<AuthRemoteDataSource>(),
            );
          },
        ),
        Provider<Login>(
          create: (context) {
            print('Providing Login');
            return Login(context.read<AuthRepository>());
          },
        ),
        Provider<Register>(
          create: (context) {
            print('Providing Register');
            return Register(context.read<AuthRepository>());
          },
        ),
        BlocProvider<AuthBloc>(
          create: (context) {
            print('Providing AuthBloc');
            return AuthBloc(
              loginUseCase: context.read<Login>(),
              registerUseCase: context.read<Register>(),
            );
          },
        ),
        // Car Wash / Dashboard Feature
        Provider<LocationDataSource>(
          create: (_) {
            final location = Location();
            print('Providing LocationDataSource with Location: $location (${location.runtimeType})');
            return LocationDataSourceImpl(location);
          },
        ),
        Provider<CarWashDataSource>(
          create: (_) {
            print('Providing CarWashDataSource');
            return CarWashDataSourceImpl();
          },
        ),
        Provider<LocationRepository>(
          create: (context) {
            print('Providing LocationRepository with dataSource: ${context.read<LocationDataSource>()}');
            return LocationRepositoryImpl(context.read<LocationDataSource>());
          },
        ),
        Provider<CarWashRepository>(
          create: (context) {
            print('Providing CarWashRepository');
            return CarWashRepositoryImpl(context.read<CarWashDataSource>());
          },
        ),
        Provider<GetUserLocation>(
          create: (context) {
            print('Providing GetUserLocation with repository: ${context.read<LocationRepository>()}');
            return GetUserLocation(context.read<LocationRepository>());
          },
        ),
        Provider<GetNearestCarWashes>(
          create: (context) {
            print('Providing GetNearestCarWashes');
            return GetNearestCarWashes(context.read<CarWashRepository>());
          },
        ),
        BlocProvider<DashboardBloc>(
          create: (context) {
            print('Providing DashboardBloc with getUserLocation: ${context.read<GetUserLocation>()}, getNearestCarWashes: ${context.read<GetNearestCarWashes>()}');
            return DashboardBloc(
              getUserLocation: context.read<GetUserLocation>(),
              getNearestCarWashes: context.read<GetNearestCarWashes>(),
            )..add(FetchUserLocation());
          },
        ),
        // Services Feature
        Provider<ServicesDataSource>(
          create: (_) {
            print('Providing ServicesDataSource');
            return ServicesDataSourceImpl();
          },
        ),
        Provider<ServicesRepository>(
          create: (context) {
            print('Providing ServicesRepository');
            return ServicesRepositoryImpl(context.read<ServicesDataSource>());
          },
        ),
        Provider<GetServices>(
          create: (context) {
            print('Providing GetServices');
            return GetServices(context.read<ServicesRepository>());
          },
        ),
        BlocProvider<ServicesBloc>(
          create: (context) {
            print('Providing ServicesBloc');
            return ServicesBloc(
              getServices: context.read<GetServices>(),
            );
          },
        ),
      ],
      child: const CarWashApp(),
    ),
  );
}

class CarWashApp extends StatelessWidget {
  const CarWashApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
      secondary: Colors.green,
      tertiary: Colors.blue,
    );

    final ThemeData theme = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(20),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          minimumSize: const Size(300, 56),
        ),
      ),
      cardTheme: CardTheme(
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: colorScheme.surfaceVariant,
        iconColor: colorScheme.primary,
        textColor: colorScheme.onSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      splashColor: colorScheme.secondary.withOpacity(0.3),
      highlightColor: colorScheme.secondary.withOpacity(0.1),
    );

    return MaterialApp.router(
      title: 'Car Wash Booking',
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}