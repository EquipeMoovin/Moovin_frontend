import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/injection.dart';

import 'package:moovin_mobile/features/auth/presentation/screens/verify_email_screen.dart';
import 'features/auth/presentation/screens/forgot_password_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/placeholder_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) =>
            const PlaceholderScreen(title: 'Dashboard'),
      ),
      GoRoute(
        path: '/verify/:email',
        builder: (context, state) => BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
          child: VerifyEmailScreen(email: state.pathParameters['email']!),
        ),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) =>
            const ForgotPasswordScreen(title: 'Recuperar Senha'),
      ),
    ],

    redirect: (context, state) {
      // Adicione lógica de redirecionamento se necessário
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Moovin Mobile',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
