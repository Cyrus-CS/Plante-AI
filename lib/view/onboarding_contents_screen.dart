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
    image: "assets/images/10.jpg",
    desc: "Le processus de scan de la plante est simple et intuitif. Lorsque l'utilisateur choisit d'utiliser la fonction de scan, l'application active la caméra de son téléphone. À l'aide de la caméra, l'utilisateur prend une photo de la plante qu'il souhaite analyser.",
  ),
  OnboardingContents(
    title: "Téléverser une Image de Plante",
    image: "assets/images/4.png",
    desc:
        "Une fois que l'utilisateur a pris une photo de la plante ou s'il préfère  utiliser une image déjà existante, il peut téléverser l'image depuis sa galerie.",
  ),
  OnboardingContents(
    title: "Résultats Prédits",
    image: "assets/images/resultats.png",
    desc:
        "Après avoir capturé ou téléchargé une image, l'application effectue une analyse approfondie pour détecter toute anomalie ou maladie sur la plante.",
  ),
];
