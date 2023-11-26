import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled3/screens/DetailActivitePage.dart';
import 'AjouterActivitePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = 'Tous';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        backgroundColor: Colors.teal[200],
      ),
      body: _buildBody(),
      backgroundColor: Colors.teal[200],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Activités',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ajouter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[200],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    if (_selectedIndex == 0) {
      return Text('Activités - $_selectedCategory');
    } else if (_selectedIndex == 1) {
      return Text('Ajouter');
    } else {
      return Text('Profil');
    }
  }

  List<Widget> _buildAppBarActions() {
    if (_selectedIndex == 0) {
      return [
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            _chooseCategory();
          },
        ),
        if (_selectedCategory != 'Tous')
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                _selectedCategory = 'Tous';
              });
            },
          ),
      ];
    } else {
      return [];
    }
  }

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return Scrollbar(
        child: FutureBuilder(
          future: _selectedCategory == 'Tous'
              ? _getAllActivities()
              : getActivitiesByCategory(_selectedCategory),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur : ${snapshot.error}'));
            } else {
              List<Map<String, dynamic>> activities =
              snapshot.data as List<Map<String, dynamic>>;
              return ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> activity = activities[index];
                  return Card(
                    elevation: 2.0,
                    margin:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailActivitePage(
                                activity: activity),
                          ),
                        );
                      },
                      title: Text(activity['titre']),
                      subtitle: Text(
                          '${activity['lieu']} - ${activity['prix']}'),
                      leading: Image.network(
                        activity['imageUrl'],
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    } else if (_selectedIndex == 1) {
      return AjouterActivitePage();
    } else {
      return Center(
        child: Text(
          'Contenu de Profil',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<Map<String, dynamic>>> getActivitiesByCategory(
      String category) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Activity')
        .where('categorie', isEqualTo: category)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> _getAllActivities() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Activity').get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  void _chooseCategory() async {
    String? selectedCategory = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choisir une catégorie'),
          content: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Catégorie 1');
                },
                child: Text('Catégorie 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Catégorie 2');
                },
                child: Text('Catégorie 2'),
              ),
              // Ajoutez d'autres catégories au besoin
            ],
          ),
        );
      },
    );

    if (selectedCategory != null) {
      setState(() {
        _selectedCategory = selectedCategory;
      });
    }
  }
}
