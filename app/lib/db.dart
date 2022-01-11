class SkillsNode {
  int id;
  String title;
  bool isLeaf;

  SkillsNode({required this.id, required this.title, required this.isLeaf});
}

List<SkillsNode> getChildrenOf(int parentId) {
  if (parentId == 2) {
    return [
      SkillsNode(id: 10, title: "Posmatranje očima", isLeaf: false),
      SkillsNode(id: 20, title: "Posmatranje zvukova", isLeaf: false),
    ];
  }
  if (parentId == 10) {
    return [
      SkillsNode(
          id: 11,
          title: "Lezite na zemlju/travu i posmatrajte oblake na nebu",
          isLeaf: true),
      SkillsNode(
          id: 12,
          title:
              "Hodajte sporije, zaustavite se negde gde imate pogled, posmatrajte cveće, drveće i prirodu.",
          isLeaf: true),
      SkillsNode(
          id: 13,
          title:
              "Sedite napolju. Posmatrajte ko i šta prolazi ispred vas, bez da pokretima glave ili pogledom pratite njihovo kretanje.",
          isLeaf: true),
    ];
  }
  if (parentId == 20) {
        return [
      SkillsNode(
          id: 21,
          title: "Zaustavite se na momenat i osluškujte. Slušajte teksturu i oblik zvukova oko vas. Pokušajte da čujete tišinu između zvukova.",
          isLeaf: true),
      SkillsNode(
          id: 12,
          title:
              "Dok neko priča, slušajte visinu glasa, mekoću ili grubost zvukova, jasnoću i razgovetnost govora, pauze između pojedinih reči.",
          isLeaf: true),
    ];
  }
  return [];
}
