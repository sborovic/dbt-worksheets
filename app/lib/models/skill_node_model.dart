class SkillNode {
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsLeaf = 'is_leaf';
  int id;
  String title;
  String description;
  bool isLeaf;

  SkillNode({
    required this.id,
    required this.title,
    required this.description,
    required this.isLeaf,
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnTitle: title,
      columnDescription: description,
      columnIsLeaf: isLeaf == true ? 1 : 0,
    };
  }

  SkillNode.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        title = map[columnTitle],
        description = map[columnDescription],
        isLeaf = map[columnIsLeaf] == 1;

  @override
  String toString() {
    return 'SkillNode{id: $id, title: $title, description: $description, isLeaf: $isLeaf}';
  }
}
