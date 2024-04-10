import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Domain/Services/ProgrammeServiceInterface.dart';
import 'package:skillsprint/Layouts/CustomStyle.dart';
import 'package:skillsprint/Models/Programme.dart';
import 'package:skillsprint/Pages/DetailsProgramme.dart';
import 'package:skillsprint/Services/ProgrammeService.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.authService});

  final AuthServiceInterface authService;

  @override
  State<Accueil> createState() => ListeProgramme();
}

class ListeProgramme extends State<Accueil> {
  final ProgrammeServiceInterface programmeService = ProgrammeService();
  List<Programme> lesProgrammes = [];

  Future<String> getAllProgrammes() async {
    lesProgrammes = await programmeService.getProgrammesPublic();
    return '';
  }

  List<Widget> createCards() {
    List<Widget> result = [];
    for (Programme p in lesProgrammes) {
      result.add(const Padding(padding: EdgeInsets.symmetric(vertical: 10)));
      result.add(
        InkWell(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.5,
            decoration: CustomStyle.boxDecorationGradient,
            child: Center(
              child: Text(
                p.nom.isEmpty ? "Sans nom" : p.nom,
                style: CustomStyle.textStyleCardTitle,
              ),
            ),
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsProgramme(
                    title: p.nom,
                    authService: widget.authService,
                    programme: p),
              )),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllProgrammes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget widget = const SizedBox();
          if (snapshot.hasData) {
            widget = Column(children: createCards());
          } else if (snapshot.hasError) {
            widget = const SizedBox(child: Text("Une erreur est survenue"));
          } else {
            widget = const SizedBox(child: Text("Chargement..."));
          }
          return Scaffold(
            body: Center(
              child: widget,
            ),
          );
        });
  }
}
