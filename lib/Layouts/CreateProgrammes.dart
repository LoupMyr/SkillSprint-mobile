import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Layouts/Accueil.dart';
import 'package:skillsprint/Layouts/Profil.dart';
import 'package:skillsprint/Models/Exercice.dart';
import 'package:skillsprint/Models/Programme.dart';
import 'package:skillsprint/Pages/HomePage.dart';
import 'package:skillsprint/Services/AuthService.dart';
import 'package:skillsprint/Services/ExerciceService.dart';
import 'package:skillsprint/Services/ProgrammeService.dart';

class ProgrammeForm extends StatefulWidget {
  const ProgrammeForm({super.key, required this.authService});
  final AuthServiceInterface authService;

  @override
  State<ProgrammeForm> createState() => CreateProgrammes();
}

class CreateProgrammes extends State<ProgrammeForm> {
  ExerciceService exoService = ExerciceService();
  ProgrammeService programmeService = ProgrammeService();

  bool isChecked = false;
  List<Widget> exerciseForms = [];
  User? user = FirebaseAuth.instance.currentUser;

  int exerciseCount = 1;

  // Contrôleurs pour les champs de saisie
  final TextEditingController programNameController = TextEditingController();
  final List<TextEditingController> exerciseNameControllers = [];
  final List<TextEditingController> repetitionControllers = [];
  final List<TextEditingController> setControllers = [];
  final List<TextEditingController> descriptionControllers = [];

  @override
  void initState() {
    super.initState();
    exerciseForms.add(buildExerciseForm(exerciseCount));
    exerciseCount++;
  }

  @override
  void dispose() {
    // Libérer les contrôleurs
    programNameController.dispose();
    exerciseNameControllers.forEach((controller) => controller.dispose());
    repetitionControllers.forEach((controller) => controller.dispose());
    setControllers.forEach((controller) => controller.dispose());
    descriptionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void testPush() {
    List<String> listeExercice = [];

    for (var i = 0; i < exerciseNameControllers.length; i++) {
      String exerciceId = ExerciceService.generateUID();
      Exercice exo = Exercice(
          exerciceId,
          exerciseNameControllers[i].text,
          descriptionControllers[i].text,
          int.parse(setControllers[i].text),
          int.parse(repetitionControllers[i].text));

      listeExercice.add(exerciceId);
      exoService.addExercices(exo.serialize(), exerciceId);
    }

    Programme prgrm = Programme(
        "", programNameController.text, isChecked, listeExercice, user!.uid);
    programmeService.postProgrammes(prgrm.serialize());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Le programme a été créé avec succès"),
    ));
    setState(() {
      isChecked = false;
    });
    programNameController.clear();
    exerciseNameControllers.forEach((controller) => controller.clear());
    descriptionControllers.forEach((controller) => controller.clear());
    setControllers.forEach((controller) => controller.clear());
    repetitionControllers.forEach((controller) => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Créer ton programme",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: programNameController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Nom du programme',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.all(20),
                    child: CheckboxListTile(
                      title: const Text("Rendre public"),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Column(children: exerciseForms),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              exerciseForms.add(buildExerciseForm(exerciseCount));
                              exerciseCount++;
                            });
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (exerciseForms.isNotEmpty) {
                                exerciseForms.removeLast();
                                exerciseNameControllers.removeLast().dispose();
                                repetitionControllers.removeLast().dispose();
                                setControllers.removeLast().dispose();
                                descriptionControllers.removeLast().dispose();
                                exerciseCount--;
                              }
                            });
                          },
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  Container(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepOrange)),
                      onPressed: (testPush),
                      child: const Text(
                        "Créer le programme",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExerciseForm(int index) {
    if (exerciseNameControllers.isEmpty ||
        index >= exerciseNameControllers.length) {
      exerciseNameControllers.add(TextEditingController());
    }
    if (repetitionControllers.isEmpty ||
        index >= repetitionControllers.length) {
      repetitionControllers.add(TextEditingController());
    }
    if (setControllers.isEmpty || index >= setControllers.length) {
      setControllers.add(TextEditingController());
    }
    if (descriptionControllers.isEmpty ||
        index >= descriptionControllers.length) {
      descriptionControllers.add(TextEditingController());
    }
    return Column(
      children: [
        const SizedBox(height: 20),
        Text("Exercice $exerciseCount"),
        Form(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: exerciseNameControllers.last,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nom de l\'exercice',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: repetitionControllers.last,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nombre de répétition',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: setControllers.last,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nombre de série',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  maxLines: null,
                  controller: descriptionControllers.last,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
