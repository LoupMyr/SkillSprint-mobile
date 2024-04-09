import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Layouts/AppBarLayout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.authService});
  final AuthServiceInterface authService;
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLayout(title: "Accueil", authService: widget.authService),
      body: const Center(
        child:
          Column(
            children: [
              Text("HomePage")
            ],
          ),
      ),
    );
  }
}
