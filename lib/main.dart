import 'package:flutter/material.dart';
import 'pages/artist_list_page.dart';
import 'pages/project_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Arte',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/artists': (context) => ArtistListPage(),
        '/projects': (context) => ProjectListPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciador de Arte')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/artists'),
              child: Text('Lista de Artistas'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/projects'),
              child: Text('Lista de Projetos'),
            ),
          ],
        ),
      ),
    );
  }
}
