import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Layouts/AppBarLayout.dart';
import 'package:skillsprint/Pages/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage(
      {super.key, required this.title, required this.authService});

  final AuthServiceInterface authService;
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formRegister = GlobalKey<FormState>();
  String _pseudo = "";
  String _email = "";
  String _mdp = "";
  bool _obscureMdp = true;

  Future<void> register() async {
    String response = await widget.authService.register(_email, _mdp, _pseudo);
    if (response == '') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(title: "Connectez-vous", authService: widget.authService,),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Votre compte a été créé."),
      ));
    } else {
      String str = "Une erreur est survenue";
      if (response == "weak-password") {
        str = "$str: mot de passe trop faible.";
      } else if (response == "email-already-in-use") {
        str = "$str: email déjà utilisé.";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(str),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLayout(
          title: widget.title,
          authService: widget.authService,
          isConnected: false),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _formRegister,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Pseudo:'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _pseudo = "";
                        } else {
                          _pseudo = value;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Email:'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _email = "";
                        } else {
                          _email = value;
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          obscureText: _obscureMdp,
                          decoration: const InputDecoration(
                            label: Text('Mot de passe:'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              _mdp = "";
                            } else {
                              _mdp = value;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureMdp = !_obscureMdp;
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye_rounded)),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    onPressed: () {
                      if (_formRegister.currentState!.validate()) {
                        register();
                      }
                    },
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
