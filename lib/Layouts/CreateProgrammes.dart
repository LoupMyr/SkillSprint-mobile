import 'package:flutter/material.dart';

class ProgrammeForm extends StatefulWidget {
  const ProgrammeForm({super.key});

  @override
  State<ProgrammeForm> createState() => CreateProgrammes();
}

class CreateProgrammes extends State<ProgrammeForm> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Créer ton programme"),
          Form(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nom du programme',
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
                    title: Text("Rendre visible"),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  )),
              ElevatedButton(onPressed: () => {}, child: Text("Envoyer"))
            ],
          ))
        ],
      ),
    );
  }
}
