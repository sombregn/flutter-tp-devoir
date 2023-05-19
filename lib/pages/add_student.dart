import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:note_app/student.dart';
import 'package:http/http.dart' as http;

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController contenuController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  String? _selectedSubject;
  int maxLength = 5;
  int selectedIndex = -1;
  double? _note;

  final _formKey = GlobalKey<FormState>(); // Clef de validation du formulaire

  bool blockKeys = false;

  Future<void> store() async {
    String url = 'http://10.0.2.2:8000/api/Ajouter';
    String titre = 'Example Title';
    double contenu = 3.14159;

    Map<String, dynamic> data = {
      'titre': _selectedSubject,
      'contenu': double.parse(contenuController.text),
    };

    // Convert the data to JSON
    String jsonData = jsonEncode(data);

    // Set the headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Send the POST request
    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonData,
    );

    print(response);

    // Check the response status code
    if (response.statusCode == 200) {
      print('Data sent successfully.');
    } else {
      print('Error sending data. Status code: ${response.statusCode}');
    }
  }

// Usage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Ajouter une note'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assignation de la clef de validation du formulaire
          child: Column(
            children: [
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                padding: const EdgeInsets.all(10.0),
                value: _selectedSubject,
                items: const [
                  DropdownMenuItem(value: 'Java', child: Text('Java')),
                  DropdownMenuItem(value: 'Laravel', child: Text('Laravel')),
                  DropdownMenuItem(value: 'Flutter', child: Text('Flutter')),
                ],
                hint: const Text('Choisissez un titre'),
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner un titre';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: contenuController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _note = double.parse(value);
                    });
                  },
                  maxLength: 5,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]+(\.[0-9]*)?')),
                    LengthLimitingTextInputFormatter(maxLength),
                  ],
                  minLines: 1,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer le contenu';
                    }
                    final double? parsedValue = double.tryParse(value);
                    if (parsedValue == null) {
                      return 'Veuillez entrer un nombre valide';
                    } else if (parsedValue < 0 || parsedValue > 20) {
                      return 'La note doit être comprise entre 0 et 20';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Entrer la note',
                    labelText: 'Note',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Student student = Student(
                          contenu: double.parse(contenuController.text.trim()),
                          titre: _selectedSubject!,
                        );
                        await store();
                        addStudentAndNavigateToHome(student, context);
                      }
                    },
                    child: const Text('Ajouter'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        contenuController.text = '';
                        _selectedSubject = null;
                      });
                      focusNode.requestFocus();
                    },
                    child: const Text('Effacer'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void addStudentAndNavigateToHome(Student student, BuildContext context) {
    final studentRef = FirebaseFirestore.instance.collection('students').doc();
    student.id = studentRef.id;
    final data = student.toJson();
    studentRef.set(data).whenComplete(() {
      log('User inserted.');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false,
      );
    });
  }
}
