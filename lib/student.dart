import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));
String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    this.id,
    required this.contenu,
    required this.titre,
    // required this.marks,
  });

  String? id;
  late final double contenu;
  late final String? titre;
  // final num marks;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        contenu: json["contenu"],
        titre: json["titre"],
        // marks: json["marks"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contenu": contenu,
        "titre" : titre, 
        // "marks": marks,
      };
}
