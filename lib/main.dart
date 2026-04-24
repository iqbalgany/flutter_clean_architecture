import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/pages/pokemon_page.dart';
import 'package:flutter_clean_architecture/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDepedencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: PokemonPage());
  }
}
