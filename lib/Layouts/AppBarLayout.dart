import 'package:flutter/material.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/Pages/LoginPage.dart';
import 'package:skillsprint/Pages/RegisterPage.dart';

class AppBarLayout extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const AppBarLayout(
      {super.key,
      required this.title,
      required this.authService,
      this.isConnected = true});

  final String title;
  final AuthServiceInterface authService;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        isConnected
            ? IconButton(
                onPressed: () async {
                  int response = await authService.logout();
                  if(response == 0){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contect) => LoginPage(title: "Connectez-vous", authService: authService,)));
                  }
                },
                icon: const Icon(Icons.logout_rounded))
            : IconButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(
                          title: "Inscrivez vous", authService: authService),
                    ),
                  ),
                },
                icon: const Icon(Icons.person),
              ),
      ],
    );
  }
}
