import 'package:flutter/material.dart';
import '../models/project.dart';
import '../services/api_service.dart';
import 'project_form_page.dart';

class ProjectListPage extends StatefulWidget {
  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  late Future<List<Project>> futureProjects;

  @override
  void initState() {
    super.initState();
    futureProjects = ApiService().fetchProjects();
  }

  void _refreshProjects() {
    setState(() {
      futureProjects = ApiService().fetchProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Projetos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectFormPage()),
              ).then((_) => _refreshProjects()); 
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Project>>(
        future: futureProjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar projetos: ${snapshot.error}'));
          } else {
            final projects = snapshot.data!;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(projects[index].title),
                  subtitle: Text(projects[index].description),
                );
              },
            );
          }
        },
      ),
    );
  }
}
