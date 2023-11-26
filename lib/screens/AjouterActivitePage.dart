import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tflite/tflite.dart';
import 'package:untitled3/screens/tflite.dart';

class AjouterActivitePage extends StatefulWidget {
  @override
  _AjouterActivitePageState createState() => _AjouterActivitePageState();
}

class _AjouterActivitePageState extends State<AjouterActivitePage> {
  final TextEditingController titreController = TextEditingController();
  final TextEditingController lieuController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController nbrPerController = TextEditingController();

  String? selectedCategory;

  // Declare _image and _output variables
  late File _image = File("");
  List? _output;
  late String _categorie = "";

  // Move detectimage outside of getCategoryFromImage


  Future<void> getCategoryFromImage() async {
      //Pick an image from camera or gallery
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      } else {
        setState(() {
          _image = File(image.path);
        });
        List<dynamic>? output = await TFliteModel(_image).detectImage();
        print("The Output :${output}");
        setState(() {
          if (output?[0]['confidence']>0.8) _categorie = output![0]['label'].toString().substring(2);
          else _categorie = 'autre';
        });
      ;
    }

    @override
    void initState() {
      super.initState();
    }


    @override
    void dispose() {
      super.dispose();
    }
  }

  void ajouterActivite() async {
    try {
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'activité : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titreController,
              decoration: InputDecoration(
                labelText: 'Titre de l\'activité',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: lieuController,
              decoration: InputDecoration(
                labelText: 'Lieu de l\'activité',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nbrPerController,
              decoration: InputDecoration(
                labelText: 'Nombre de personne',
                filled: true,
                fillColor: Colors.white, border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            _output != null
                ? Text(
              'Categorie: ${_output![0]['label'].toString().substring(2)}',
              style: TextStyle(fontSize: 18),
            )
                : SizedBox.shrink(), // Use SizedBox.shrink() to render an empty widget

            TextField(
              controller: prixController,
              decoration: InputDecoration(

                labelText: 'Prix de l\'activité',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _image.path.isNotEmpty
                ? Container(
              margin: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Text(_categorie),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Image.file(
                      _image,
                      height: 200,
                      width: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            )
                : Container(),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                getCategoryFromImage();
              },

              child: Text('Sélectionner une image depuis la galerie'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ajouterActivite();
              },

              child: Text('Valider'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
