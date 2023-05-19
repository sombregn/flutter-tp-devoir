import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/add_student.dart';
import 'package:note_app/student.dart';
import 'package:note_app/pages/update_student.dart';

class HomePage extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');

  HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Liste des notes'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _reference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Quelque chose s'est mal passé"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          QuerySnapshot querySnapshot = snapshot.data!;
          List<QueryDocumentSnapshot> documents = querySnapshot.docs;
          List<Student> students = documents
              .map(
                (e) => Student(
                  id: e.id,
                  contenu: e['contenu'],
                  titre: e['titre'],
                ),
              )
              .toList();
          return _getBody(context, students);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudent(),
            ),
          );
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getBody(context, students) {
    return students.isEmpty
        ? const Center(
            child: Text(
              "Aucune note n'a été repertorié \n Clique sur + pour en ajouté",
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text('${students[index].titre}'),
                subtitle: Text('${students[index].contenu}'),
                trailing: SizedBox(
                  width: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.edit,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateStudent(
                                student: students[index],
                              ),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        onTap: () {
                          _reference.doc(students[index].id).delete();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
