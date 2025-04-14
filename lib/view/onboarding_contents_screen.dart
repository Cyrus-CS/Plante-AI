class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Scan de la Plante",
    image: "assets/images/7.png",
    desc: "Le processus de scan de la plante est simple et intuitif. Lorsque l'utilisateur choisit d\'utiliser la fonction de scan, l'application active la caméra de son téléphone. À l\'aide de la caméra, l'utilisateur prend une photo de la plante qu'il souhaite analyser. L\'application utilise des algorithmes avancés pour identifier les caractéristiques de la plante et détecter d'éventuelles maladies",
  ),
  OnboardingContents(
    title: "Téléverser une Image de Plante",
    image: "assets/images/4.png",
    desc:
        "Une fois que l'utilisateur a pris une photo de la plante ou s'il préfère  utiliser une image déjà existante, il peut téléverser l'image depuis sa galerie.  En sélectionnant l'option Téléverser une image, il accède à la galerie de son  téléphone où il peut choisir une photo claire et bien cadrée de sa plante.  L'application analyse alors l'image téléchargée, tout en prenant en compte les détails comme la texture des feuilles, les couleurs et la forme des parties végétales pour effectuer une évaluation précise.",
  ),
  OnboardingContents(
    title: "Résultats Prédits",
    image: "assets/images/3.gif",
    desc:
        "Après avoir capturé ou téléchargé une image, l'application effectue une analyse approfondie pour détecter toute anomalie ou maladie sur la plante. En quelques secondes, l'utilisateur reçoit un retour détaillé concernant la santé de la plante. Ce retour peut indiquer si la plante est saine, si elle présente des signes de maladie, ou si elle nécessite des soins  particuliers. En fonction des résultats, l'application fournit des recommandations et des  conseils pour traiter la maladie.",
  ),
];
