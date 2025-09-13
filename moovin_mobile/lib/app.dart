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
  late final _router = GoRouter(
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
    // Redirect simples: se autenticado, vai para dashboard; senão, fica no login
    redirect: (context, state) {
      final authBloc = context.read<AuthBloc>();
      final authState = authBloc.state;

      // Se tentando acessar dashboard sem auth, redireciona para login
      if (state.uri.toString() == '/dashboard' && authState is! AuthAuthenticated) {
        return '/login';
      }
      // Se autenticado e no login, vai para dashboard (sem role ainda)
      if (state.uri.toString() == '/login' && authState is AuthAuthenticated) {
        return '/dashboard';
      }
      return null;  // Sem redirecionamento
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Meu App Auth - Apenas Login',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}