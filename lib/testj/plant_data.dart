class PlantDiseaseInfo {
  final String name;
  final String description;
  final String solutions;

  PlantDiseaseInfo({
    required this.name,
    required this.description,
    required this.solutions,
  });
}

final Map<int, PlantDiseaseInfo> plantDiseaseData = {
  0: PlantDiseaseInfo(
    name: "Apple___Apple_scab",
    description: "La tavelure du pommier est une maladie fongique causant des lésions sombres sur les feuilles et les fruits, réduisant leur qualité.",
    solutions: "Retirez les feuilles affectées et éliminez-les correctement pour éviter leur propagation.",
  ),
  1: PlantDiseaseInfo(
    name: "Apple___Black_rot",
    description: "Maladie fongique causant des taches orange.",
    solutions: "Retirez les fruits et les feuilles infectés et traitez avec un fongicide.",
  ),
  2:PlantDiseaseInfo(
    name: "Apple___Cedar_apple_rust",
    description: "La rouille du cèdre-pommier est une maladie fongique nécessitant des cèdres pour compléter son cycle.",
    solutions: "Taillez les branches affectées et utilisez un fongicide."
    ),
  3:PlantDiseaseInfo(
    name: "Apple___healthy",
    description: "Ce pommier est en bonne santé, sans signe de maladie.",
    solutions: "Votre pommier a l'air en bonne santé ! Continuez à lui prodiguer de bons soins."
  ),
  4:PlantDiseaseInfo(
    name: "Blueberry___healthy",
    description: "Cette myrtille est en bonne santé.",
    solutions: "Votre bleuet est en bonne santé ! Assurez-lui un arrosage et un ensoleillement adéquats."
  ),
  5:PlantDiseaseInfo(
    name: "Cherry_(including_sour)___Powdery_mildey",
    description: "L'oïdium des cerises est une maladie fongique provoquant un dépôt poudreux blanc sur les feuilles.",
    solutions: "Traitez avec des fongicides et retirez les feuilles infectées."
  ),
  6:PlantDiseaseInfo(
    name: "Cherry_(including_sour)___healthy",
    description: "Ces cerises sont en bonne santé.",
    solutions: "Votre cerisier est en bonne santé ! Surveillez sa croissance."
  ),
  7:PlantDiseaseInfo(
    name: "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot",
    description: "Les taches foliaires à Cercospora affectent les feuilles du maïs, réduisant la photosynthèse et les rendements.",
    solutions: "Appliquez un fongicide et retirez les feuilles affectées feuilles."
  ),
  8:PlantDiseaseInfo(
    name: "Corn_(maize)___Common_rust",
    description: "La rouille commune du maïs est une maladie fongique causant des pustules rouges sur les feuilles.",
    solutions: "tilisez un fongicide et améliorez la circulation de l'air autour de la plante."
  ),
  9:PlantDiseaseInfo(
    name: "Corn_(maize)___Northern_Leaf_Blight",
    description: "La brûlure septentrionale des feuilles est une maladie causée par un champignon, affectant les feuilles de maïs.",
    solutions: "Retirez les feuilles infectées et appliquez des fongicides."
  ),
  10:PlantDiseaseInfo(
    name: "Corn_(maize)___healthy",
    description: " Ce maïs est en bonne santé.",
    solutions: "Votre maïs est en bonne santé ! Continuez l'irrigation et la gestion des ravageurs."
  ),
  11:PlantDiseaseInfo(
    name: "Grape___Black_rot",
    description: "La pourriture noire de la vigne cause des lésions brunes et des fruits pourris, réduisant la production.",
    solutions: "Taillez les vignes infectées et appliquez des fongicides."
  ),
  12:PlantDiseaseInfo(
    name: "Grape___Esca_(Black_Measles)",
    description: "L'Esca de la vigne provoque des taches noires sur les feuilles et des pertes de production.",
    solutions: "Retirez les vignes infectées et traitez avec des fongicides appropriés."
  ),
  13:PlantDiseaseInfo(
    name: "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)",
    description: "La brûlure des feuilles de vigne entraîne des taches brunes et la défoliation des plants.",
    solutions: "Retirez les feuilles infectées et appliquez des fongicides."
  ),
  14:PlantDiseaseInfo(
    name: "Grape___healthy",
    description: "Cette vigne est en bonne santé.",
    solutions: "Votre vigne est en bonne santé ! Assurez un ensoleillement et un arrosage adéquats."
  ),
  15:PlantDiseaseInfo(
    name: "Non_leaves",
    description: "L'image que vous avez sélectionné ne correspond peut-être à une feuilles.",
    solutions: "Réessayez en sélectionnant l'image à nouveau ou une autre."
  ),
  16:PlantDiseaseInfo(
    name: "Orange___Haunglongbing_(Citrus_greening)",
    description: "Le Huanglongbing est une maladie bactérienne grave provoquant le verdissement des agrumes et la chute des fruits.",
    solutions: "Il s'agit d'une maladie grave. Retirez les arbres affectés et désinfectez les outils."
  ),
  17:PlantDiseaseInfo(
    name: "Peach___Bacterial_spot",
    description: "La tache bactérienne du pêcher cause des lésions sur les fruits et les feuilles.",
    solutions: "Taillez les branches affectées et appliquez des fongicides à base de cuivre."
  ),
  18:PlantDiseaseInfo(
    name: "Peach___healthy",
    description: "Ce pêcher est en bonne santé.",
    solutions: "Votre pêcher est en bonne santé ! Continuez les soins réguliers."
  ),
  19:PlantDiseaseInfo(
    name: "Pepper,_bell___Bacterial_spot",
    description: "La tache bactérienne du poivron provoque des taches brunes sur les feuilles et les fruits.",
    solutions: "Retirez les feuilles infectées et utilisez des bactéricides."
  ),
  20:PlantDiseaseInfo(
    name: "Pepper,_bell___healthy",
    description: "Ce poivron est en bonne santé.",
    solutions: "Votre plant de poivron a l'air en bonne santé ! Gardez le sol bien drainé."
  ),
  21:PlantDiseaseInfo(
    name: "Potato___Early_blight",
    description: "L'alternariose de la pomme de terre provoque des taches brunes en cibles sur les feuilles.",
    solutions: "Appliquez des fongicides et retirez les feuilles infectées."
  ),
  22:PlantDiseaseInfo(
    name: "Potato___Late_blight",
    description: "Le mildiou de la pomme de terre est une maladie dévastatrice causant des lésions aqueuses sur les feuilles et les tubercules.",
    solutions: "Retirez les plantes infectées et appliquez un fongicide pour empêcher toute propagation ultérieure."
  ),
  23:PlantDiseaseInfo(
    name: "Potato___healthy",
    description: "Cette pomme de terre est en bonne santé.",
    solutions: "Vos plants de pommes de terre sont en bonne santé ! Assurez un bon drainage du sol."
  ),
  24:PlantDiseaseInfo(
    name: "Raspberry___healthy",
    description: "Cette framboise est en bonne santé.",
    solutions: "Votre plant de framboisier est en bonne santé ! Continuez les soins réguliers."
  ),
  25:PlantDiseaseInfo(
    name: "Soybean___healthy",
    description: "Ce soja est en bonne santé.",
    solutions: "Votre plant de soja est en bonne santé ! Assurez un espacement approprié pour la croissance."
  ),
  26:PlantDiseaseInfo(
    name: "Squash___Powdery_mildew",
    description: "L'oïdium de la courge provoque un dépôt blanc poudreux sur les feuilles.",
    solutions: "Traitez avec un fongicide et retirez les feuilles infectées."
  ),
  27:PlantDiseaseInfo(
    name: "Strawberry___Leaf_scorch",
    description: "La brûlure des feuilles de fraise entraîne un dessèchement et une décoloration des feuilles.",
    solutions: "Taillez les feuilles affectées et améliorez la gestion de l'eau."
  ),
  28:PlantDiseaseInfo(
    name: "Strawberry___healthy",
    description: "Cette fraise est en bonne santé.",
    solutions: "Votre plant de fraisier est en bonne santé ! Gardez le sol fertile."
  ),
  29:PlantDiseaseInfo(
    name: "Tomato___Bacterial_spot",
    description: "La tache bactérienne de la tomate cause des lésions brunes sur les feuilles et les fruits.",
    solutions: "Taillez les zones infectées et appliquez des fongicides à base de cuivre."
  ),
  30:PlantDiseaseInfo(
    name: "Tomato___Early_blight",
    description: "L'alternariose de la tomate provoque des taches circulaires brunes sur les feuilles et les fruits.",
    solutions: "Appliquez un fongicide et retirez les feuilles affectées."
  ),
  31:PlantDiseaseInfo(
    name: "Tomato___Late_blight",
    description: "Le mildiou de la tomate cause des lésions aqueuses sur les feuilles et les fruits.",
    solutions: "Retirez les plantes infectées et appliquez des fongicides."
  ),
  32:PlantDiseaseInfo(
    name: "Tomato___Leaf_Mold",
    description: "Le moisi des feuilles de tomate provoque des taches jaunes sur le dessus des feuilles.",
    solutions: "Améliorez la ventilation autour de la plante et traitez avec des fongicides."
  ),
  33:PlantDiseaseInfo(
    name: "Tomato___Septoria_leaf_spot",
    description: "La tache septorienne des feuilles de tomate cause des taches brunes avec un centre clair sur les feuilles.",
    solutions: "Retirez les feuilles affectées et appliquez des fongicides."
  ),
  34:PlantDiseaseInfo(
    name: "Tomato___Spider_mites",
    description: "Les acariens à deux points provoquent une décoloration et une chute des feuilles de tomate.",
    solutions: "Appliquez des acaricides et retirez les feuilles infestées."
  ),
  35:PlantDiseaseInfo(
    name: "Tomato___Target_Spot",
    description: "La tache cible de la tomate provoque des lésions nécrotiques sur les feuilles.",
    solutions: "Appliquez des fongicides et retirez les feuilles infectées."
  ),
  36:PlantDiseaseInfo(
    name: "Tomato___Tomato_Yellow_Leaf_Curl_Virus",
    description: "Ce virus provoque des feuilles jaunes enroulées et un ralentissement de la croissance.",
    solutions: "Retirez les feuilles infectées plantes et contrôlez les pucerons."
  ),
  37:PlantDiseaseInfo(
    name: "Tomato___Tomato_mosaic_virus",
    description: "Le virus de la mosaïque de la tomate cause des taches jaunes et une déformation des feuilles.",
    solutions: "Retirez les plantes infectées et désinfectez les outils."
  ),
  38:PlantDiseaseInfo(
    name: "Tomato___healthy",
    description: "Cette tomate est en bonne santé.",
    solutions: "Votre plante de tomates a l'air en bonne santé ! Continuez les soins réguliers."
  )
};
