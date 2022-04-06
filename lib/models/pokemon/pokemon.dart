class Pokemon {
  String name;
  String url;
  late String imageUrl;

  Pokemon({required this.name, required this.url}) {
    imageUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${url.split("/")[6]}.png";
  }

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
      );
}
