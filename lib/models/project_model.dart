class ProjectModel {
  final String name;
  final String des;
  final List<String> chips;
  final List<String> screenshots;

  const ProjectModel({
    required this.name,
    required this.des,
    required this.chips,
    this.screenshots = const [],
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    final rawChips = json['chips'] as List<dynamic>? ?? [];
    final chips = rawChips.map((c) {
      if (c is String) return c;
      if (c is Map) return c['chips'] as String? ?? '';
      return c.toString();
    }).where((c) => c.isNotEmpty).toList();

    final rawScreenshots = json['images'] as List<dynamic>? ?? [];
    final screenshots = rawScreenshots
        .map((s) {
          if (s is String) return s;
          if (s is Map) return s['images'] as String? ?? '';
          return s.toString();
        })
        .where((s) => s.isNotEmpty)
        .toList();

    return ProjectModel(
      name: json['projectName'] as String? ?? '',
      des: json['des'] as String? ?? '',
      chips: chips,
      screenshots: screenshots,
    );
  }
}