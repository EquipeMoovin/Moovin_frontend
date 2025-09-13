import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // Opcional: para status bar, etc.
import 'core/injection.dart' as di;
import 'app.dart';  // O widget principal do app
import 'features/auth/presentation/screens/login_screen.dart'; // Exemplo de tela inicial
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Garante que o Flutter esteja pronto (ex: para async)

  // Configura injeção de dependências (GetIt)
  await di.setup();

  // Opcional: Configura orientação da tela (ex: portrait only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moovin Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const LoginScreen(), // Mudar para sua tela de login
    );
  }
}