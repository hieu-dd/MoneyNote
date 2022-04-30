import 'package:money_note/data/network/dio_client.dart';
import 'package:money_note/data/services/pokemon/endpoints.dart';
import 'package:money_note/models/pokemon/pokemon.dart';
import 'dart:convert';

class PokemonApi {
  final DioClient _dioClient;

  PokemonApi(this._dioClient) {
    _dioClient.setBaseUrl(Endpoints.BASE_URL);
  }

  Future<List<Pokemon>> getPokemons() async {
    try {
      final res = await _dioClient.get(Endpoints.END_POINT_POKEMON);
      return (res["results"] as List<dynamic>)
          .map((e) => Pokemon.fromMap(e))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
