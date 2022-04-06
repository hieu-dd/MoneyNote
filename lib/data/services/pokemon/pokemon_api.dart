import 'package:base_flutter_project/data/network/dio_client.dart';
import 'package:base_flutter_project/data/services/pokemon/endpoints.dart';

class PokemonApi {
  final DioClient _dioClient;

  PokemonApi(this._dioClient){
    _dioClient.setBaseUrl(Endpoints.BASE_URL);
  }
  Future<String> getPokemons() async {
    try{
      final res = _dioClient.get(Endpoints.END_POINT_POKEMON);
      return res.toString();
    }catch(e){
      return "";
    }
  }


}
