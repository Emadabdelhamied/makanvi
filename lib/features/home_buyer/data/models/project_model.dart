import 'dart:convert';

import '../../../seller_pages/listining_seller/data/models/my_listing_model.dart';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

class ProjectModel {
  ProjectModel({
    required this.project,
  });

  Project project;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        project: Project.fromJson(json["project"]),
      );
}

class Project {
  Project({
    required this.id,
    required this.coverImagePath,
    required this.name,
    required this.description,
    required this.images,
    required this.agent,
    required this.properties,
  });

  int id;
  String coverImagePath;
  String name;
  String description;
  List<dynamic> images;
  PropertyUser agent;
  List<Property> properties;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        coverImagePath: json["cover_image_path"],
        name: json["name"],
        description: json["description"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        agent: PropertyUser.fromJson(json["agent"]),
        properties: List<Property>.from(
            json["properties"].map((x) => Property.fromJson(x))),
      );
}
