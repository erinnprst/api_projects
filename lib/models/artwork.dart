class Artwork {
  final int id;
  final String title;
  final String imageUrl;

  Artwork({required this.id, required this.title, required this.imageUrl});

  factory Artwork.fromJson(Map<String, dynamic> json) {
    return Artwork(
      id: json['id'],
      title: json['title'],
      imageUrl:
          'https://www.artic.edu/iiif/2/${json['image_id']}/full/843,/0/default.jpg',
    );
  }
}
