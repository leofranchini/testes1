class Project {
  int id;
  String title;  // Aqui é onde você define o título do projeto
  String description;
  String status;

  static int _idCounter = 1;

  Project({
    required this.title,
    required this.description,
    required this.status,
  }) : id = _idCounter++;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      description: json['description'],
      status: json['status'],
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }
}
