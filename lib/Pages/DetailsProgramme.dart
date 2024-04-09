import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Domain/Services/ExerciceServiceInterface.dart';
import 'package:skillsprint/Layouts/AppBarLayout.dart';
import 'package:skillsprint/Layouts/CustomStyle.dart';
import 'package:skillsprint/Models/Exercice.dart';
import 'package:skillsprint/Models/Programme.dart';
import 'package:skillsprint/Services/ExerciceService.dart';

class DetailsProgramme extends StatefulWidget {
  const DetailsProgramme(
      {super.key,
      required this.title,
      required this.authService,
      required this.programme});

  final String title;
  final AuthServiceInterface authService;
  final Programme programme;

  @override
  State<DetailsProgramme> createState() => _DetailsProgrammeState();
}

class _DetailsProgrammeState extends State<DetailsProgramme> {
  ExerciceServiceInterface exerciceService = ExerciceService();
  List<Exercice> lesExercices = [];

  Future<String> getAllExercices() async {
    lesExercices =
        await exerciceService.getExercicesInProgramme(widget.programme);
    return '';
  }

  List<Widget> createCards() {
    List<Widget> result = [];
    for (Exercice exo in lesExercices) {
      result.add(const Padding(padding: EdgeInsets.symmetric(vertical: 10)));
      result.add(
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.height * 0.5,
          decoration: CustomStyle.boxDecorationGradient,
          child: Center(
            child: Column(
              children: [
                Text(
                  exo.nom.isEmpty ? "Sans nom" : exo.nom,
                  style: CustomStyle.textStyleCardTitle,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Text("${exo.nbSerie} série", style: CustomStyle.textStyleCardSubTitle),
                const Text("-", style: CustomStyle.textStyleCardSubTitle),
                Text("${exo.nbRep} répétions", style: CustomStyle.textStyleCardSubTitle),

              ],
            ),
          ),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllExercices(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget item = const SizedBox();
          if (snapshot.hasData) {
            item = Column(children: createCards());
          } else if (snapshot.hasError) {
            item = const SizedBox(child: Text("Une erreur est survenue"));
          } else {
            item = const SizedBox(child: Text("Chargement..."));
          }
          return Scaffold(
            appBar: AppBarLayout(
                title: widget.title, authService: widget.authService),
            body: SingleChildScrollView(
              child: Center(child: item),
            ),
          );
        });
  }
}
