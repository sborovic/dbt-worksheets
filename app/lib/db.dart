class SkillNode {
  int id;
  String title;
  String description;
  bool isLeaf;

  SkillNode(
      {required this.id,
      required this.title,
      required this.description,
      required this.isLeaf});
}

List<SkillNode> getChildrenOf(int parentId) {
  if (parentId == 1) {
    return [
      SkillNode(
          description: 'materijal', title: 'Posmatranje', id: 2, isLeaf: false)
    ];
  }
  if (parentId == 2) {
    return [
      SkillNode(
          id: 10,
          description: "Posmatranje očima",
          title: 'titl',
          isLeaf: false),
      SkillNode(
          id: 20,
          title: "titl",
          description: "Posmatranje zvukova",
          isLeaf: false),
    ];
  }
  if (parentId == 10) {
    return [
      SkillNode(
          id: 11,
          description: "Lezite na zemlju/travu i posmatrajte oblake na nebu",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 12,
          description:
              "Write out a nonjudgmental blow-by-blow account of a particularly important episode in your day.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 13,
          description:
              "Sedite napolju. Posmatrajte ko i šta prolazi ispred vas, bez da pokretima glave ili pogledom pratite njihovo kretanje.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 14,
          description: "Lezite na zemlju/travu i posmatrajte oblake na nebu",
          title: 'titl',
          isLeaf: false),
      SkillNode(
          id: 15,
          description:
              "Hodajte sporije, zaustavite se negde gde imate pogled, posmatrajte cveće, drveće i prirodu.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 16,
          description:
              "Sedite napolju. Posmatrajte ko i šta prolazi ispred vas, bez da pokretima glave ili pogledom pratite njihovo kretanje.",
          title: 'titl',
          isLeaf: true),
    ];
  }
  if (parentId == 14) {
    return [
      SkillNode(
          id: 17,
          description:
              "UNUTAR> Hodajte sporije, zaustavite se negde gde imate pogled, posmatrajte cveće, drveće i prirodu.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 18,
          description:
              "UNUTAR> Sedite napolju. Posmatrajte ko i šta prolazi ispred vas, bez da pokretima glave ili pogledom pratite njihovo kretanje.",
          title: 'titl',
          isLeaf: true),
    ];
  }
  if (parentId == 20) {
    return [
      SkillNode(
          id: 21,
          description:
              "Zaustavite se na momenat i osluškujte. Slušajte teksturu i oblik zvukova oko vas. Pokušajte da čujete tišinu između zvukova.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 12,
          description:
              "Dok neko priča, slušajte visinu glasa, mekoću ili grubost zvukova, jasnoću i razgovetnost govora, pauze između pojedinih reči.",
          title: 'titl',
          isLeaf: true),
    ];
  }
  return [];
}
