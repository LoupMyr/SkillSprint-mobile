import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Layouts/AppBarLayout.dart';
import 'package:skillsprint/Models/Programme.dart';
import 'package:skillsprint/Services/AuthService.dart';

class DetailsProgramme extends StatefulWidget {
  const DetailsProgramme({super.key, required this.title, required this.authService, required this.programme});
  final String title;
  final AuthServiceInterface authService;
  final Programme programme;

  @override
  State<DetailsProgramme> createState() => _DetailsProgrammeState();
}

class _DetailsProgrammeState extends State<DetailsProgramme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLayout(title: widget.title, authService: widget.authService),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
            ],
          )
        ),
      ),
    );
  }
}
