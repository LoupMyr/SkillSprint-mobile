import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[700],
        elevation: 0, // Supprime l'ombre sous l'app bar
      ),
      body: user != null ? ProfilContent(user: user) : Center(child: CircularProgressIndicator()),
      backgroundColor: Colors.grey[200],
    );
  }
}

class ProfilContent extends StatefulWidget {
  final User user;

  const ProfilContent({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilContentState createState() => _ProfilContentState();
}

class _ProfilContentState extends State<ProfilContent> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.displayName ?? "");
    _emailController = TextEditingController(text: widget.user.email ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedCreationDate = DateFormat.yMMMMd().format(widget.user.metadata.creationTime!);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/00/97/00/09/360_F_97000908_wwH2goIihwrMoeV9QF3BW6HtpsVFaNVM.jpg'),
              backgroundColor: Colors.grey[400],
            ),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          UserInfoRow(
            label: 'Nom:',
            value: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Entrez votre nom',
                border: InputBorder.none,
              ),
            ),
          ),
          UserInfoRow(
            label: 'Email:',
            value: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Entrez votre email',
                border: InputBorder.none,
              ),
            ),
          ),
          UserInfoRow(
            label: 'Date de création:',
            value: Text(formattedCreationDate),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _updateProfile(context);
            },
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfile(BuildContext context) async {
    try {
      await widget.user.updateDisplayName( _nameController.text.trim());
      await widget.user.verifyBeforeUpdateEmail(_emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profil mis à jour avec succès'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la mise à jour du profil: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }
}

class UserInfoRow extends StatelessWidget {
  final String label;
  final Widget value;

  const UserInfoRow({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(
            width: 200, // Ajustez la largeur pour mieux s'adapter
            child: value,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Profil(),
  ));
}
