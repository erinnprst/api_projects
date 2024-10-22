import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/artwork.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artworks',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArtworkListScreen(),
    );
  }
}

class ArtworkListScreen extends StatefulWidget {
  @override
  _ArtworkListScreenState createState() => _ArtworkListScreenState();
}

class _ArtworkListScreenState extends State<ArtworkListScreen> {
  late Future<List<Artwork>> futureArtworks;

  @override
  void initState() {
    super.initState();
    futureArtworks = ApiService().fetchArtworks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Artworks')),
      body: FutureBuilder<List<Artwork>>(
        future: futureArtworks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final artworks = snapshot.data!;
          return ListView.builder(
            itemCount: artworks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(artworks[index].title),
                leading: Image.network(artworks[index].imageUrl),
                subtitle: Text('ID: ${artworks[index].id}'),
                onTap: () {
                  // Navigasi ke layar detail ketika item ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArtworkDetailScreen(artwork: artworks[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ArtworkDetailScreen extends StatelessWidget {
  final Artwork artwork;

  ArtworkDetailScreen({required this.artwork});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(artwork.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(artwork.imageUrl),
            SizedBox(height: 16),
            Text(
              'Artwork ID: ${artwork.id}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Title: ${artwork.title}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
