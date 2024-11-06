class Artist {
  int id;
  String name;
  String? bio;

  static int _idCounter = 1; // Contador para gerar IDs sequenciais

  // Alterei o construtor para garantir que o id seja gerado corretamente
  Artist({required this.name, this.bio, required id}) : id = _idCounter++;

  // Fábrica de criação do artista a partir de JSON
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'], // Agora é necessário passar o id no JSON
      name: json['name'],
      bio: json['bio'],
    );
  }

  // Método para converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
    };
  }
}
