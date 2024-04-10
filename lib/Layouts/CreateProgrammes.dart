import 'package:flutter/material.dart';

class ProgrammeForm extends StatefulWidget {
  const ProgrammeForm({super.key});

  @override
  State<ProgrammeForm> createState() => CreateProgrammes();
}

class CreateProgrammes extends State<ProgrammeForm> {
  bool isChecked = false;
  List<Widget> exerciseForms =
      []; // Liste pour stocker les formulaires d'exercices

  int exerciseCount = 1; // Compteur pour le nom des exercices

  @override
  void initState() {
    super.initState();
    // Initialiser avec un formulaire d'exercice lors de la création de l'objet d'état
    exerciseForms.add(buildExerciseForm());
    exerciseCount++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // Afficher les formulaires d'exercices existants
                  Column(children: exerciseForms),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    // Ajouter un nouveau formulaire d'exercice à la liste
                    setState(() {
                      exerciseForms.add(buildExerciseForm());
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
                    // Supprimer le dernier formulaire d'exercice de la liste
                    setState(() {
                      if (exerciseForms.isNotEmpty) {
                        exerciseForms.removeLast();
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
        ],
      ),
    );
  }

  // Fonction pour construire un nouveau formulaire d'exercice
  Widget buildExerciseForm() {
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
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nombre de série',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(20),
                child: CheckboxListTile(
                  title: const Text("Rendre visible"),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
