import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/booking_repository.dart';
import 'features/bookings/bloc/booking_bloc.dart';
import 'features/splash/presentation/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VedicApp());
}

class VedicApp extends StatelessWidget {
  const VedicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BookingRepository(),
      child: BlocProvider(
        create: (context) => BookingBloc(
          repository: context.read<BookingRepository>(),
        )..add(LoadBookingsEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vedic Workflows',
          theme: ThemeData(
            primaryColor: const Color(0xFF3B137B),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B137B)),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}