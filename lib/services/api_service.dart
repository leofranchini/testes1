import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project.dart';
import '../models/artist.dart';

class ApiService {
  static const String baseUrl = 'assets/data.json';

  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();


  Future<List<Project>> fetchProjects() async {
    final response = await client.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar projetos');
    }
  }

  
  Future<List<Artist>> fetchArtists() async {
    final response = await client.get(Uri.parse('$baseUrl/artists'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Artist.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar artistas');
    }
  }

 
  Future<void> createProject(Project project) async {
    final response = await client.post(
      Uri.parse('$baseUrl/projects'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(project.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar projeto');
    }
  }

 
  Future<void> updateProject(Project project) async {
    final response = await client.put(
      Uri.parse('$baseUrl/projects/${project.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(project.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar projeto');
    }
  }

 
  Future<void> deleteProject(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl/projects/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar projeto');
    }
  }

  Future<void> createArtist(Artist artist) async {
    final response = await client.post(
      Uri.parse('$baseUrl/artists'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(artist.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar artista');
    }
  }
}
