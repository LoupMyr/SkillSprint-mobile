
import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Pages/LoginPage.dart';
import 'package:skillsprint/Services/AuthService.dart';


Future<void> main() async {
  runApp(MyApp(authService: await AuthService.create()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authService});
  final AuthServiceInterface authService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accueil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: LoginPage(title: "Connexion", authService: authService,),
    );
  }
}
