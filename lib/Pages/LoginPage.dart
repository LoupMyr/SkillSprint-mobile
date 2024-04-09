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
    UserCredential? user = await _authService.login(_email, _mdp);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            title: "Accueil",
            authService: _authService,
            user: user
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
      var rememberMe = prefs.getBool("remember_me") ?? false;
      if (rememberMe) {
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

  void _handleRememberMe(bool value) {
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
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
    FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);
    _authService = AuthService(auth);
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
        Widget widget = const SizedBox();
        if (snapshot.hasData) {
          widget = SizedBox(
            child: Form(
              key: _formLogin,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: _emailController,
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
                          controller: _passwordController,
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
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              _handleRememberMe(value!);
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
                      if (_formLogin.currentState!.validate()) {
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
        }
        else if (snapshot.hasError) {
          widget = const SizedBox(
            child: Icon(Icons.error_outline,
                color: Color.fromARGB(255, 255, 17, 0)),
          );
        }
        else {
          widget = const SizedBox(child: Text("Loading"));
        }
        return Scaffold(
          appBar: AppBarLayout(
              title: "Connexion",
              authService: _authService,
              isConnected: false),
          body: Center(
            child: Column(
              children: <Widget>[widget],
            ),
          ),
        );
      },
    );
  }
}
