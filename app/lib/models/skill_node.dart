class SkillNode {
  static const columnId = 'id';
  static const columnParentId = 'parent_id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsLeaf = 'is_leaf';
  static const columnIsDeleted = 'is_deleted';
  int id;
  int parentId;
  String title;
  String description;
  bool isLeaf;
  bool isDeleted;

  SkillNode({
    required this.id,
    required this.parentId,
    required this.title,
    required this.description,
    required this.isLeaf,
    required this.isDeleted,
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnParentId: parentId,
      columnTitle: title,
      columnDescription: description,
      columnIsLeaf: isLeaf == true ? 1 : 0,
      columnIsDeleted: isDeleted == true ? 1 : 0,
    };
  }

  SkillNode.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        parentId = map[columnParentId] ?? -1,
        title = map[columnTitle] ?? '',
        description = map[columnDescription] ?? '',
        isDeleted = map[columnIsDeleted] == 1,
        isLeaf = map[columnIsLeaf] == 1;

  @override
  String toString() {
    return 'SkillNode{id: $id, parentId: $parentId, title: $title, description: $description, isLeaf: $isLeaf}, isDeleted: $isDeleted';
  }
}
