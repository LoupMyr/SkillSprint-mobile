import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Domain/Services/ExerciceServiceInterface.dart';
import 'package:skillsprint/Domain/Services/LikeServiceInterface.dart';
import 'package:skillsprint/Layouts/AppBarLayout.dart';
import 'package:skillsprint/Layouts/CustomStyle.dart';
import 'package:skillsprint/Models/Exercice.dart';
import 'package:skillsprint/Models/Like.dart';
import 'package:skillsprint/Models/Programme.dart';
import 'package:skillsprint/Services/ExerciceService.dart';
import 'package:skillsprint/Services/LikeService.dart';

class DetailsProgramme extends StatefulWidget {
  const DetailsProgramme({super.key,
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
  LikeServiceInterface likeService = LikeService();
  List<Exercice> _lesExercices = [];
  int _nbLikes = 0;
  bool _alreadyLiked = false;

  Future<String> getAllExercices() async {
    _lesExercices =
    await exerciceService.getExercicesInProgramme(widget.programme);
    await getNbLikes();
    _alreadyLiked = await likeService.hasLiked(widget.programme);
    return '';
  }

  Future<void> getNbLikes() async {
    List<Like> likes = await likeService.getLikesByProgrammeUid(
        widget.programme);
    _nbLikes = likes.length;
  }

  Future<void> addLike() async {
    if (!_alreadyLiked) {
      await likeService.postLike(Like(
          "", FirebaseAuth.instance.currentUser!.uid, widget.programme.uid));
      _alreadyLiked = true;
      setState(() {
        _nbLikes;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Like ajouté !"),
      ));
    }
  }

  Future<void> deleteLike() async {
    if(_alreadyLiked){
      await likeService.deleteLike(widget.programme);
      _alreadyLiked = false;
      setState(() {
        _nbLikes;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Like supprimé !"),
      ));
    }
  }

  List<Widget> createCards() {
    List<Widget> result = [];
    for (Exercice exo in _lesExercices) {
      result.add(const Padding(padding: EdgeInsets.symmetric(vertical: 10)));
      result.add(
        Container(
          width: MediaQuery
              .of(context)
              .size
              .height * 0.5,
          decoration: CustomStyle.boxDecorationGradient,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Column(children: createExoText(exo)),
          ),
        ),
      );
    }
    return result;
  }

  List<Widget> createExoText(Exercice exo) {
    return [
      Text(
        exo.nom.isEmpty ? "Sans nom" : exo.nom,
        style: CustomStyle.textStyleCardTitle,
      ),
      Text(
        exo.desc.isEmpty ? "Sans description" : exo.desc,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white)
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text("${exo.nbSerie} série", style: CustomStyle.textStyleCardSubTitle),
      const Text("-", style: CustomStyle.textStyleCardSubTitle),
      Text("${exo.nbRep} répétions", style: CustomStyle.textStyleCardSubTitle),
    ];
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
            floatingActionButton: ElevatedButton.icon(
              onPressed: _alreadyLiked ? deleteLike : addLike,
              icon: _alreadyLiked
                  ? const Icon(Icons.verified_rounded)
                  : const Icon(Icons.thumb_up),
              label: Text(_nbLikes.toString()),
              style: ElevatedButton.styleFrom(
                foregroundColor: _alreadyLiked ? Colors.blue : Colors.black54,
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                minimumSize: const Size.fromRadius(40),
              ),
            ),
          );
        });
  }
}
