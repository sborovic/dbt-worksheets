import 'dart:typed_data';

class SkillsGroups {
  final String title, subtitle;
  const SkillsGroups._(this.title, this.subtitle);

  static const mindfulness = [
      SkillsGroups._('Mudar um', 'Materijal mindfulness 3a'),
      SkillsGroups._('ŠTA: Posmatranje', 'Materijal mindfulness 4a'),
      SkillsGroups._('ŠTA: Opisivanje', 'Materijal mindfulness 4b'),
      SkillsGroups._('ŠTA: Učestvovanje', 'Materijal mindfulness 4b'),
      SkillsGroups._('KAKO: Neosuđujuće', 'Materijal mindfulness 5a'),
      SkillsGroups._('KAKO: Potpuno svesno', 'Materijal mindfulness 5b'),
      SkillsGroups._('KAKO: Učinkovito', 'Materijal mindfulness 5c'),
    ];
}
