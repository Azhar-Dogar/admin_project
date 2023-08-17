class GenreModel{
  late List genre;
  GenreModel({
    required this.genre
});
  GenreModel.fromMap(Map<String, dynamic> data) {
    genre = data['genre'];
  }
}