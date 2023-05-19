import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:note_app/pages/home_page.dart';
import '../composants/bouttonSignUp.dart';
import '../composants/bouttounLogo.dart';
import '../composants/champDeSaisie.dart';
import 'connexion.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final utilisateurControlleur = TextEditingController();
  final mdpControlleur = TextEditingController();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Connexion",
            style: TextStyle(
              fontSize: 35,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            "Continuer avec",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Center(child: Bouton(imagePath: 'lib/images/search.png')),
            ],
          ),
          SizedBox(height: 100),
          champDeSaisie(
            hintText: 'Nom d\'utilisateur',
            controlleur: utilisateurControlleur,
            obscureText: false,
          ),
          SizedBox(height: 20),
          champDeSaisie(
            hintText: 'Mot de passe',
            controlleur: mdpControlleur,
            obscureText: true,
          ),
          SizedBox(height: 50),
          buton(
            onTap: connexion,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                "Pas de compte?",
                style: TextStyle(fontSize: 16),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => Connexion()),
                      (route) => false);
                },
                child: Text(
                  "Inscrivez-vous",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Copyright@groupe7",
            style: TextStyle(
                fontSize: 12, color: const Color.fromARGB(255, 255, 255, 255)),
          )
        ]),
      )),
    );
  }

  void connexion() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: utilisateurControlleur.text,
        password: mdpControlleur.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => HomePage()),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      final snackbar =
          SnackBar(content: Text("Email ou Mot de passe incorrect"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
