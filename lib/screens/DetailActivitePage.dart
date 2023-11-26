import 'package:flutter/material.dart';

class DetailActivitePage extends StatelessWidget {
  final Map<String, dynamic> activity;

  DetailActivitePage({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'activité'),
        backgroundColor: Colors.teal[200],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // décalage vers le bas
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  activity['imageUrl'], // Mise à jour du champ 'Image' en 'imageUrl'
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Titre: ${activity['titre']}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Categorie: ${activity['categorie']}',
                      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Lieu: ${activity['lieu']}',
                      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Prix: ${activity['prix']}',
                      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 10),
                    // Text(
                    //   'Catégorie: ${activity['Categorie']}', // Commenté car 'Categorie' n'était pas présent dans les données
                    //   style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    // ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.person, size: 18),
                        SizedBox(width: 5),
                        Text(
                          'Nombre de personnes: ${activity['nombreMin']}',
                          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
