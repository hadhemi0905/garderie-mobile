import 'package:flutter/material.dart';

void main() {
  // run : lance l'app
  runApp(const MyApp());
}

// MyApp = widgt principe d'app
// StatelessWidget widget fixe qui n'a pas des donnees a changer
class MyApp extends StatelessWidget {
  // Constructeur : permet de créer un MyApp.
  // "super.key" est une identification interne 
  const MyApp({super.key});

  // @override = on remplace la méthode build de la classe parente.
  @override
  // build() décrit CE QU'ON AFFICHE à l'écran.
  // "context" = information sur la position du widget dans l'application.
  Widget build(BuildContext context) {
    // MaterialApp = l'application complète avec le style Material (Android).
    return MaterialApp(
      // Nom d'app
      title: 'Ma Garderie',
      // annuler la bonde rouge de debugation
      debugShowCheckedModeBanner: false,
      // home = le premier interface affiché.
      home: const Scaffold(
        // Scaffold = le squelette d'une page (il a un body, une appBar, etc.).
        // body = le contenu principal de la page.
        body: Center(
          // Center = place son enfant au milieu de l'écran.
          // Text = affiche un texte.
          child: Text('Ma Garderie'),
        ),
      ),
    );
  }
}