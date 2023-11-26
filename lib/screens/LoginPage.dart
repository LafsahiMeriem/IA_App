import 'package:flutter/material.dart';
import 'package:untitled3/screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignUp.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Center(child: Text("Application des activités")),
          backgroundColor: Colors.teal[200],
        ),
        backgroundColor: Colors.teal[200],
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Login",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        // Sign in with email and password
                        await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } catch (e) {
                        print("Error: $e");
                        _showErrorDialog(context, 'Email ou mot de passe incorrect.');
                      }
                    },
                    child: Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                  ),
                ],
              ),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "  Bonjour  ",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            letterSpacing: 2.0,
            color: Colors.black,
            fontFamily: 'VotrePolice',
          ),
        ),
        Text("Entrer vos identifiants pour vous connecter"),
      ],
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Vous n'avez pas de compte ? "),
        SizedBox(
          height: 33,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUp(),
              ),
            );
          },
          child: Text(
            "S'inscrire",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur de connexion'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
