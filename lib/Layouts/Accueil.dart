import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Domain/Services/LikeServiceInterface.dart';
import 'package:skillsprint/Domain/Services/ProgrammeServiceInterface.dart';
import 'package:skillsprint/Layouts/CustomStyle.dart';
import 'package:skillsprint/Models/Like.dart';
import 'package:skillsprint/Models/Programme.dart';
import 'package:skillsprint/Pages/DetailsProgramme.dart';
import 'package:skillsprint/Services/LikeService.dart';
import 'package:skillsprint/Services/ProgrammeService.dart';

enum RadioAffichage { public, user, likes }

class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.authService});

  final AuthServiceInterface authService;

  @override
  State<Accueil> createState() => ListeProgramme();
}

class ListeProgramme extends State<Accueil> {
  final ProgrammeServiceInterface programmeService = ProgrammeService();
  List<Programme> _lesProgrammes = [];
  bool _programmesPublic = true;
  bool _programmesUser = false;
  bool _programmesLiker = false;
  String _title = "";
  RadioAffichage? _choix = RadioAffichage.public;

  Future<String> getAllProgrammes() async {
    if (_programmesPublic) {
      _lesProgrammes = await programmeService.getProgrammesPublic();
    } else if (_programmesUser) {
      _lesProgrammes = await programmeService
          .getProgrammesByUidUser(FirebaseAuth.instance.currentUser!.uid);
    } else if (_programmesLiker) {
      LikeServiceInterface likeService = LikeService();
      List<Like> likes = await likeService.getLikesByUserUid();
      _lesProgrammes = await programmeService.getProgrammesByLikes(likes);
    }
    return '';
  }

  List<Widget> createCards() {
    _title = _programmesPublic
        ? "Liste des programmes public"
        : _programmesUser
            ? "Liste de vos programmes"
            : "Liste des programmes liké";
    List<Widget> result = [
      Column(
        children: <Widget>[
          ListTile(
            title: const Text('Programmes public'),
            leading: Radio<RadioAffichage>(
              value: RadioAffichage.public,
              groupValue: _choix,
              onChanged: (RadioAffichage? value) async {
                _programmesPublic = true;
                _programmesUser = true;
                _programmesLiker = false;
                await getAllProgrammes();
                setState(() {
                  _choix = value;
                  _lesProgrammes;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Vos programmes'),
            leading: Radio<RadioAffichage>(
              value: RadioAffichage.user,
              groupValue: _choix,
              onChanged: (RadioAffichage? value) async {
                _programmesPublic = false;
                _programmesUser = true;
                _programmesLiker = false;
                await getAllProgrammes();
                setState(() {
                  _choix = value;
                  _lesProgrammes;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Vos likes'),
            leading: Radio<RadioAffichage>(
              value: RadioAffichage.likes,
              groupValue: _choix,
              onChanged: (RadioAffichage? value) async {
                _programmesPublic = false;
                _programmesUser = false;
                _programmesLiker = true;
                await getAllProgrammes();
                setState(() {
                  _choix = value;
                  _lesProgrammes;
                });
              },
            ),
          ),
        ],
      ),
      SizedBox(
        child: Text(
          _title,
          style: CustomStyle.textStyleTitle,
        ),
      )
    ];
    if (_lesProgrammes.isNotEmpty) {
      for (Programme p in _lesProgrammes) {
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
    } else {
      result.add(const Padding(padding: EdgeInsets.symmetric(vertical: 10)));
      result.add(const SizedBox(
        child: Text("Aucun programme trouvé",
            style: TextStyle(color: Colors.black)),
      ));
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
            backgroundColor: Colors.grey[200],
            body: Center(
              child: widget,
            ),
          );
        });
  }
}
