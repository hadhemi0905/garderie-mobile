// Importe la bibliothèque Material (tous les widgets de base).
import 'package:flutter/material.dart';

// Liste STATIQUE des activités, déclarée directement dans le code.
final List<Map<String, dynamic>> activites = [
  {
    "id": 1,
    "titre": "Dessin et coloriage",
    "description": "Développement de la créativité",
    "icone": "🎨",
  },
  {
    "id": 2,
    "titre": "Jeux éducatifs",
    "description": "Apprentissage par le jeu",
    "icone": "🧩",
  },
  {
    "id": 3,
    "titre": "Musique et chansons",
    "description": "Éveil musical des enfants",
    "icone": "🎵",
  },
  {
    "id": 4,
    "titre": "Lecture de contes",
    "description": "Découverte des histoires",
    "icone": "📚",
  },
  {
    "id": 5,
    "titre": "Activités sportives",
    "description": "Développement de la motricité",
    "icone": "⚽",
  },
];

// Première fonction exécutée au démarrage.
void main() {
  runApp(const MyApp());
}

// Widget racine de l'application (fixe).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma Garderie',
      debugShowCheckedModeBanner: false,
      // theme = le style global de l'application.
      // colorSchemeSeed : Flutter génère toute une palette de couleurs
      // harmonieuses à partir d'un bleu (boutons, sélection, etc.).
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// ---------------------------------------------------------------
// ÉCRAN DE DÉMARRAGE (Splash Screen) - image en PLEIN ÉCRAN
// ---------------------------------------------------------------

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Exécuté une seule fois au démarrage de l'écran.
  @override
  void initState() {
    super.initState();

    // Après 3 secondes, on va à la page principale.
    Future.delayed(const Duration(seconds: 3), () {
      // Sécurité : si l'écran n'existe plus, on s'arrête.
      if (!mounted) return;
      // pushReplacement : remplace le splash (pas de retour possible).
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Couleur crème = couleur du fond de l'image (au cas où).
      backgroundColor: const Color(0xFFFFFBF0),
      // Stack = empile ses enfants les uns SUR les autres.
      // StackFit.expand = les enfants prennent tout l'écran.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Couche 1 : l'image en plein écran.
          // BoxFit.cover = l'image remplit tout l'écran (elle peut être
          // légèrement rognée sur les bords, sans être déformée).
          Image.asset(
            'assets/images/garderie.png',
            fit: BoxFit.cover,
          ),

          // Couche 2 : le titre, placé en bas de l'écran.
          // Positioned = place le widget à un endroit précis du Stack.
          Positioned(
            left: 30,
            right: 30,
            bottom: 60,
            // Container = boîte avec fond et coins arrondis,
            // pour que le texte reste lisible sur l'image.
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                // Blanc légèrement transparent (opacité 85 %).
                color: const Color.fromRGBO(255, 255, 255, 0.85),
                // Coins arrondis.
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                // La colonne prend seulement la hauteur nécessaire.
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text.rich = un texte avec plusieurs couleurs.
                  const Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        // "Ma " en bleu.
                        TextSpan(
                          text: 'Ma ',
                          style: TextStyle(color: Colors.blue),
                        ),
                        // "Garderie" en orange.
                        TextSpan(
                          text: 'Garderie',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Petit message de bienvenue.
                  const Text(
                    'Bienvenue',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------
// PAGE PRINCIPALE (avec interactions)
// ---------------------------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Entrée du menu sélectionnée : 0 = Accueil, 1 = Activités, 2 = À propos.
  int _menuSelectionne = 0;

  // Affiche un message (SnackBar) en bas de l'écran.
  void _afficherMessage(String texte) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texte),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Appelée quand on clique sur une entrée du Drawer.
  void _choisirMenu(int index, String nom) {
    // setState : redessine l'écran avec la nouvelle sélection.
    setState(() {
      _menuSelectionne = index;
    });
    // Ferme le Drawer.
    Navigator.pop(context);
    // Confirme le choix par un message.
    _afficherMessage('Menu : $nom');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond bleu très clair pour toute la page.
      backgroundColor: const Color(0xFFF3F8FF),

      // ----- 1. APPBAR -----
      appBar: AppBar(
        // centerTitle = titre centré.
        centerTitle: true,
        title: const Text(
          'Ma Garderie',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // ----- 2. DRAWER -----
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Ma Garderie',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              selected: _menuSelectionne == 0,
              onTap: () => _choisirMenu(0, 'Accueil'),
            ),
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Activités'),
              selected: _menuSelectionne == 1,
              onTap: () => _choisirMenu(1, 'Activités'),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              selected: _menuSelectionne == 2,
              onTap: () => _choisirMenu(2, 'À propos'),
            ),
          ],
        ),
      ),

      // ----- 3. BOUTON FLOTTANT (+) -----
      floatingActionButton: FloatingActionButton(
        // Fond bleu et icône blanche.
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () => _afficherMessage('Nouvelle activité'),
        child: const Icon(Icons.add),
      ),

      // ----- 4. CONTENU -----
      // Column = empile : d'abord le message de bienvenue, puis la liste.
      body: Column(
        children: [
          // Bandeau de bienvenue.
          Container(
            // width: double.infinity = toute la largeur disponible.
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              // Aligne le texte à gauche.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BONJOUR !',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blueGrey,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Quelle activité aujourd’hui ? ☀️',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Expanded = la liste prend tout l'espace restant sous le bandeau.
          // (Sans Expanded, une ListView dans une Column provoque une erreur.)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: activites.length,
              itemBuilder: (context, index) {
                final activite = activites[index];

                return Card(
                  // Carte blanche, ombre légère, coins arrondis.
                  color: Colors.white,
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    // L'emoji dans un carré arrondi coloré.
                    leading: Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0E0),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        activite['icone'],
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                    title: Text(
                      activite['titre'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(activite['description']),
                    // trailing = à droite : une petite flèche.
                    trailing: const Icon(Icons.chevron_right),
                    // Au clic : affiche le titre dans un SnackBar.
                    onTap: () => _afficherMessage(activite['titre']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}