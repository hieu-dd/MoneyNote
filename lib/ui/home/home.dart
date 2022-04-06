import 'package:base_flutter_project/data/services/pokemon/pokemon_api.dart';
import 'package:base_flutter_project/models/pokemon/pokemon.dart';
import 'package:base_flutter_project/widgets/home/pokemon_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../utils/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _getIt = GetIt.instance;
  List<Pokemon> pokemons = [];

  @override
  void initState() {
    loadPokemons();
    super.initState();
  }

  void loadPokemons() async {
    final pokemons = await _getIt.get<PokemonApi>().getPokemons();
    setState(() {
      this.pokemons = pokemons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: const Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.setting);
              },
            ),
          )
        ],
      ),
      body: Container(
        height: 700,
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: pokemons.map((e) => PokemonItem(e)).toList(),
        ),
      ),
    );
  }
}
