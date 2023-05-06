import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/home_page.dart';
import 'package:note_app/student.dart';

class UpdateStudent extends StatefulWidget {
  final Student student;
  const UpdateStudent({Key? key, required this.student}) : super(key: key);
  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  late final Student student;
  final TextEditingController contenuController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String? _selectedSubject;
  final _formKey = GlobalKey<FormState>();
  final int maxLength = 5;

  @override
  void initState() {
    super.initState();
    student = widget.student;
    _selectedSubject = widget.student.titre;
    contenuController.text = '${student.contenu}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Modification de la note'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    return 'Veuillez sélectionner le titre';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: contenuController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]+(\.[0-9]*)?')),
                    LengthLimitingTextInputFormatter(maxLength),
                  ],
                  minLines: 2,
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
                    hintText: 'Entrer le contenu',
                    labelText: 'Contenu',
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Student updatedStudent = Student(
                          id: widget.student.id,
                          contenu: double.parse(contenuController.text),
                          titre: _selectedSubject,
                        );
                        final collectionReference =
                            FirebaseFirestore.instance.collection('students');
                        collectionReference
                            .doc(updatedStudent.id)
                            .update(updatedStudent.toJson())
                            .whenComplete(() {
                          log('Student Updated');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text('Modifier'),
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
}