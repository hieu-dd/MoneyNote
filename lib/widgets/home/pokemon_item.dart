import 'package:flutter/material.dart';
import 'package:money_note/models/pokemon/pokemon.dart';

class PokemonItem extends StatelessWidget {
  final Pokemon _pokemon;

  PokemonItem(this._pokemon);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(10),
      child: GridTile(
        header: Text(
          _pokemon.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        child: Image.network(_pokemon.imageUrl),
      ),
    );
  }
}
