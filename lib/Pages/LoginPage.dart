import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Layouts/AppBarLayout.dart';
import 'package:skillsprint/Pages/HomePage.dart';
import 'package:skillsprint/Services/AuthService.dart';
import 'package:skillsprint/firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthServiceInterface _authService;
  final _formLogin = GlobalKey<FormState>();
  String _email = "";
  String _mdp = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscureMdp = true;

  Future<void> login() async {
    UserCredential? user = await _authService.login(this._email, this._mdp);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            title: "Accueil",
            authService: this._authService,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Bienvenue ${user.user!.displayName} !"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email ou mot de passe invalide"),
      ));
    }
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;
      if (remeberMe) {
        setState(() {
          _rememberMe = true;
        });
        _emailController.text = email;
        _passwordController.text = password;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _handleRemeberme(bool value) {
    _rememberMe = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _rememberMe = value;
    });
  }

  Future<String> createAuth() async {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseApp app =
        await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);
    this._authService = AuthService(auth);
    return '';
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: createAuth(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Container container = Container();
        if (snapshot.hasData) {
          container = Container(
            child: Form(
              key: this._formLogin,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        label: Text('Email:'),
                      ),
                      validator: (valeur) {
                        if (valeur == null || valeur.isEmpty) {
                          this._email = "";
                        } else {
                          this._email = valeur;
                        }
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
                          controller: _passwordController,
                          obscureText: this._obscureMdp,
                          decoration: const InputDecoration(
                            label: Text('Mot de passe:'),
                          ),
                          validator: (valeur) {
                            if (valeur == null || valeur.isEmpty) {
                              this._mdp = "";
                            } else {
                              this._mdp = valeur;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                this._obscureMdp = !this._obscureMdp;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye_rounded)),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 50.0,
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.teal.shade400,
                          ),
                          child: Checkbox(
                            activeColor: Colors.deepOrange,
                            value: this._rememberMe,
                            onChanged: (bool? value) {
                              _handleRemeberme(value!);
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'Se souvenir de moi',
                        style: TextStyle(
                          color: Color(0xff646464),
                          fontSize: 12,
                          fontFamily: 'Rubic',
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    onPressed: () async {
                      if (this._formLogin.currentState!.validate()) {
                        await login();
                      }
                    },
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          container = Container(
            child: const Icon(Icons.error_outline,
                color: Color.fromARGB(255, 255, 17, 0)),
          );
        } else {
          container = Container(child: const Text("Loading"));
        }
        return Scaffold(
          appBar: AppBarLayout(
              title: widget.title,
              authService: this._authService,
              isConnected: false),
          body: Center(
            child: Column(
              children: <Widget>[container],
            ),
          ),
        );
      },
    );
  }
}
