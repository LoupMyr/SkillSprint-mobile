import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:skillsprint/Domain/Services/UserServiceInterface.dart';
import 'package:skillsprint/Layouts/CustomStyle.dart';
import 'package:skillsprint/Services/UserService.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: user != null
          ? ProfilContent(user: user)
          : const Center(child: CircularProgressIndicator()),
      backgroundColor: Colors.grey[200],
    );
  }
}

class ProfilContent extends StatefulWidget {
  const ProfilContent({super.key, required this.user});

  final User user;

  @override
  ProfilContentState createState() => ProfilContentState();
}

class ProfilContentState extends State<ProfilContent> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final UserServiceInterface _userService = UserService();

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.user.displayName ?? "");
    _emailController = TextEditingController(text: widget.user.email ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile(BuildContext context) async {
    List<String> response =
        await _userService.updateDisplayName(_nameController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response[0]),
      backgroundColor: response[1] == "success" ? Colors.green : Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    String formattedCreationDate =
        DateFormat.yMMMMd().format(widget.user.metadata.creationTime!);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: const NetworkImage(
                  'https://t4.ftcdn.net/jpg/00/97/00/09/360_F_97000908_wwH2goIihwrMoeV9QF3BW6HtpsVFaNVM.jpg'),
              backgroundColor: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Informations Utilisateur',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
                fontFamily: 'Roboto',
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: UserInfoRow(
              label: 'Nom:',
              value: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Entrez votre nom',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                const Text(
                  'Email:',
                  style: CustomStyle.textStyleTitleProfil,
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Text(_emailController.text,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: Row(
              children: [
                const Text(
                  'Date de création:',
                  style: CustomStyle.textStyleTitleProfil,
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Text(formattedCreationDate,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _updateProfile(context);
              },
              child: const Text('Enregistrer'),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final String label;
  final Widget value;

  const UserInfoRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: value,
          ),
        ],
      ),
    );
  }
}
