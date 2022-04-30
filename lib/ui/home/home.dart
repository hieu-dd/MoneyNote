import 'package:money_note/data/services/pokemon/pokemon_api.dart';
import 'package:money_note/models/pokemon/pokemon.dart';
import 'package:money_note/widgets/home/pokemon_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../utils/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
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
        title: Text('home.title'.tr()),
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
