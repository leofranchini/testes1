import 'package:flutter/material.dart';
import '../models/artist.dart';
import '../services/api_service.dart';
import 'artist_form_page.dart';

class ArtistListPage extends StatefulWidget {
  @override
  _ArtistListPageState createState() => _ArtistListPageState();
}

class _ArtistListPageState extends State<ArtistListPage> {
  late Future<List<Artist>> futureArtists;

  @override
  void initState() {
    super.initState();
    futureArtists = ApiService().fetchArtists();
  }

  void _refreshArtists() {
    setState(() {
      futureArtists = ApiService().fetchArtists();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Artistas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtistFormPage()),
              ).then((_) => _refreshArtists()); 
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Artist>>(
        future: futureArtists,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar artistas: ${snapshot.error}'));
          } else {
            final artists = snapshot.data!;
            return ListView.builder(
              itemCount: artists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(artists[index].name),
                  subtitle: Text(artists[index].bio ?? 'Sem biografia'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
