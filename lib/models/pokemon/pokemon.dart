class Pokemon {
  String name;
  String url;

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
      );
}
