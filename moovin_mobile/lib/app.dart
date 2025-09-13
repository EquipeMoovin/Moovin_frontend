import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/injection.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/placeholder_screen.dart';  // Placeholder para pós-login
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'core/util/role_manager.dart';  // Mantenha para navegação futura

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Configuração simples do GoRouter: login como inicial, dashboard como pós-auth
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
        path: '/dashboard',
        builder: (context, state) => const PlaceholderScreen(title: 'Dashboard - Bem-vindo!'),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Meu App Auth - Apenas Login',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}