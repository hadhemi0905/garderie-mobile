// Importe la bibliothèque Material (tous les widgets de base :
// Scaffold, Text, Column, Image, etc.).
import 'package:flutter/material.dart';

// Liste STATIQUE des activités, déclarée directement dans le code
// (le TP interdit backend et base de données).
final List<Map<String, dynamic>> activites = [
  {
    "id": 1, // numéro de l'activité
    "titre": "Dessin et coloriage", // nom affiché en gras
    "description": "Développement de la créativité", // texte secondaire
    "icone": "🎨", // emoji affiché à gauche
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

// ---------------------------------------------------------------
// ÉCRAN DE DÉMARRAGE (Splash Screen)
// ---------------------------------------------------------------

// StatefulWidget car on a besoin de initState (code exécuté une fois
// au démarrage de l'écran).
class SplashScreen extends StatefulWidget {
  // Constructeur de SplashScreen.
  const SplashScreen({super.key});

  // Crée l'objet "état" qui contient la logique de l'écran.
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Classe d'état : elle contient le code et la construction de l'écran.
class _SplashScreenState extends State<SplashScreen> {
  // initState() s'exécute UNE SEULE FOIS, quand l'écran est créé.
  @override
  void initState() {
    // Obligatoire : appelle d'abord l'initialisation de la classe parente.
    super.initState();

    // Attend 3 secondes, puis exécute le code.
    Future.delayed(const Duration(seconds: 3), () {
      // Sécurité : si l'écran n'existe plus, on s'arrête.
      if (!mounted) return;

      // pushReplacement = va vers HomePage ET supprime le splash
      // de l'historique (le bouton retour ne revient pas au splash).
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  // build() décrit ce qui s'affiche à l'écran.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Couleur de fond : blanc.
      backgroundColor: Colors.white,
      body: Center(
        // Column = empile ses enfants verticalement.
        child: Column(
          // Centre les enfants dans la hauteur de l'écran.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affiche l'image depuis le dossier assets.
            Image.asset('assets/images/garderie.png', width: 250),

            // Espace vide de 20 pixels de hauteur.
            const SizedBox(height: 20),

            // Le nom de l'application.
            const Text(
              'Ma Garderie',
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

// ---------------------------------------------------------------
// PAGE PRINCIPALE (avec interactions)
// ---------------------------------------------------------------

// StatefulWidget : la page doit se redessiner quand on choisit
// une entrée du menu (pour la surligner).
class HomePage extends StatefulWidget {
  // Constructeur de HomePage.
  const HomePage({super.key});

  // Crée l'objet "état" de la page.
  @override
  State<HomePage> createState() => _HomePageState();
}

// Classe d'état de la page principale.
class _HomePageState extends State<HomePage> {
  // Mémorise l'entrée du menu sélectionnée :
  // 0 = Accueil, 1 = Activités, 2 = À propos.
  int _menuSelectionne = 0;

  // Fonction qui affiche un message (SnackBar) en bas de l'écran.
  // "String texte" = le message à afficher, donné quand on l'appelle.
  void _afficherMessage(String texte) {
    // ScaffoldMessenger = gestionnaire qui affiche les SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar = petit message temporaire en bas de l'écran.
      SnackBar(
        // content = le contenu du message.
        content: Text(texte),
        // duration = durée d'affichage : 2 secondes.
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Fonction appelée quand on clique sur une entrée du Drawer.
  // index = numéro de l'entrée (0, 1 ou 2), nom = son texte.
  void _choisirMenu(int index, String nom) {
    // setState = dit à Flutter de redessiner l'écran avec la
    // nouvelle valeur (ici, pour surligner l'entrée choisie).
    setState(() {
      _menuSelectionne = index;
    });

    // Navigator.pop = ferme le Drawer.
    Navigator.pop(context);

    // Affiche un message qui confirme le choix.
    _afficherMessage('Menu : $nom');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ----- 1. LA BARRE DU HAUT (AppBar) -----
      appBar: AppBar(
        title: const Text('Ma Garderie'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // ----- 2. LE MENU LATÉRAL (Drawer) -----
      drawer: Drawer(
        child: ListView(
          children: [
            // En-tête du menu.
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Ma Garderie',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // Entrée 1 : Accueil.
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              // selected = true surligne l'entrée si elle est choisie.
              selected: _menuSelectionne == 0,
              // Au clic, on appelle _choisirMenu avec 0 et "Accueil".
              onTap: () => _choisirMenu(0, 'Accueil'),
            ),

            // Entrée 2 : Activités.
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Activités'),
              selected: _menuSelectionne == 1,
              onTap: () => _choisirMenu(1, 'Activités'),
            ),

            // Entrée 3 : À propos.
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              selected: _menuSelectionne == 2,
              onTap: () => _choisirMenu(2, 'À propos'),
            ),
          ],
        ),
      ),

      // ----- 3. LE BOUTON FLOTTANT (+) -----
      floatingActionButton: FloatingActionButton(
        // Au clic : affiche le message "Nouvelle activité".
        onPressed: () => _afficherMessage('Nouvelle activité'),
        // L'icône affichée dans le bouton : le signe +.
        child: const Icon(Icons.add),
      ),

      // ----- 4. LA LISTE DES ACTIVITÉS -----
      body: ListView.builder(
        // Marge de 10 pixels autour de la liste.
        padding: const EdgeInsets.all(10),
        // Nombre d'éléments à afficher (5).
        itemCount: activites.length,
        // Fonction appelée une fois par élément.
        itemBuilder: (context, index) {
          // On récupère l'activité à cette position.
          final activite = activites[index];

          return Card(
            child: ListTile(
              // L'emoji à gauche.
              leading: Text(
                activite['icone'],
                style: const TextStyle(fontSize: 32),
              ),
              // Le titre en gras.
              title: Text(
                activite['titre'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // La description sous le titre.
              subtitle: Text(activite['description']),
              // Au clic sur la carte : affiche le titre dans un SnackBar.
              onTap: () => _afficherMessage(activite['titre']),
            ),
          );
        },
      ),
    );
  }
}