class ProjectModel {
  final String name;
  final String des;
  final List<ImageModel> images;
  final List<ChipModel> chips;

  ProjectModel({
    required this.name,
    required this.des,
    required this.chips,
    required this.images,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['projectName'] ?? '',
      des: json['des'] ?? '',
      chips:
          (json['chips'] as List<dynamic>?)
              ?.map((chip) => ChipModel.fromJson(chip))
              .toList() ??
          [],
      images:
          (json['images'] as List<dynamic>?)
              ?.map((img) => ImageModel.fromJson(img))
              .toList() ??
          [],
    );
  }
}

class ImageModel {
  final String name;

  ImageModel({required this.name});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(name: json['images'] ?? '');
  }
}

class ChipModel {
  final String name;

  ChipModel({required this.name});

  factory ChipModel.fromJson(Map<String, dynamic> json) {
    return ChipModel(name: json['chips'] ?? '');
  }
}
