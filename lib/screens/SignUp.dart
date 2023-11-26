import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'inscription'),
        backgroundColor: Colors.teal[200],
      ),
      backgroundColor: Colors.teal[200],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                  labelText: 'Le nom d\'utilisateur',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.person)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.email)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                String userName = _userNameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;

                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  // Enregistrez les informations supplémentaires de l'utilisateur dans Cloud Firestore
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userCredential.user?.uid)
                      .set({
                    'userName': userName,
                    'email': email,
                    // Ajoutez d'autres champs si nécessaire
                  });

                  // Affichez un message de succès
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Inscription réussie!'),
                    ),
                  );

                  // Affichez d'autres actions nécessaires après l'inscription
                  print('Utilisateur enregistré avec succès!');
                } catch (e) {
                  // Gérez les erreurs d'inscription, par exemple, affichez un message d'erreur à l'utilisateur
                  print('Erreur lors de l\'inscription: $e');
                }
              },
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
