// Importe la bibliothèque Material (tous les widgets de base :
// Scaffold, Text, Column, Image, etc.).
import 'package:flutter/material.dart';

// main() est la PREMIÈRE fonction exécutée au démarrage de l'application.
void main() {
  // runApp() lance l'application et affiche le widget MyApp.
  runApp(const MyApp());
}

// MyApp est le widget racine de l'application.
// StatelessWidget = widget FIXE (aucune donnée qui change).
class MyApp extends StatelessWidget {
  // Constructeur de MyApp.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp = l'application complète avec le style Material.
    return MaterialApp(
      // Nom de l'application.
      title: 'Ma Garderie',
      // Cache le bandeau rouge "DEBUG".
      debugShowCheckedModeBanner: false,
      // Le premier écran affiché est le SplashScreen.
      home: const SplashScreen(),
    );
  }
}

//screen splash : ecran de demarage

// StatefulWidget car on a besoin de initState (code exécuté une fois
// au démarrage de l'écran). Un StatelessWidget n'a pas initState.
class SplashScreen extends StatefulWidget {
  // Constructeur de SplashScreen.
  const SplashScreen({super.key});

  // Crée l'objet "état" qui contient la logique de l'écran.
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Classe d'état : elle contient le code et la construction de l'écran.
// Le "_" devant le nom = classe privée (utilisable seulement dans ce fichier).
class _SplashScreenState extends State<SplashScreen> {
  // initState() s'exécute UNE SEULE FOIS, quand l'écran est créé.
  @override
  void initState() {
    // Obligatoire : appelle d'abord l'initialisation de la classe parente.
    super.initState();

    // Future.delayed = "attends cette durée, puis exécute ce code".
    // Duration(seconds: 3) = attendre 3 secondes.
    Future.delayed(const Duration(seconds: 3), () {
      // Sécurité : si l'écran n'existe plus, on s'arrête.
      if (!mounted) return;

      // pushReplacement = va vers un nouvel écran ET supprime le splash
      // de l'historique (le bouton retour ne revient pas au splash).
      Navigator.pushReplacement(
        // context = position actuelle dans l'application.
        context,
        // MaterialPageRoute = la transition vers le nouvel écran.
        // builder construit l'écran de destination (HomePage).
        // "_" = paramètre qu'on n'utilise pas.
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  // build() décrit ce qui s'affiche à l'écran.
  @override
  Widget build(BuildContext context) {
    // Scaffold = squelette de la page.
    return Scaffold(
      // Couleur de fond : blanc.
      backgroundColor: Colors.white,
      // Center = centre son contenu au milieu de l'écran.
      body: Center(
        // Column = empile ses enfants verticalement.
        child: Column(
          // Centre les enfants dans la hauteur de l'écran.
          mainAxisAlignment: MainAxisAlignment.center,
          // La liste des widgets empilés, de haut en bas.
          children: [
            // Affiche l'image depuis le dossier assets.
            // width: 250 = largeur de 250 pixels (la hauteur s'adapte).
            Image.asset('assets/images/garderie.png', width: 250),

            // SizedBox = espace vide de 20 pixels de hauteur.
            const SizedBox(height: 20),

            // Le nom de l'application.
            const Text(
              'Ma Garderie',
              // style = apparence du texte.
              style: TextStyle(
                fontSize: 36, // taille de la police
                fontWeight: FontWeight.bold, // texte en gras
                color: Colors.blue, // couleur bleue
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ecran principale de l'app

// Widget fixe : pour l'instant la page ne change pas.
class HomePage extends StatelessWidget {
  // Constructeur de HomePage.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Page simple avec un texte au centre.
    return const Scaffold(
      body: Center(child: Text('Page principale')),
    );
  }
}