import 'dart:convert';

import 'package:marvel/models/character.dart';
import 'package:http/http.dart' as http;

class CharactersApi {
  final String _baseUrl = 'https://gateway.marvel.com:443/v1/public/';
  final String publicKey = "82d370c41971065c5382d04b7569a384";
  final String privateKey = "bf3e7256ccc64c1d422c459bb36bd3b4d34bd5a3";

  Future<Results> getCharacters() async {
    final response = await http.get(Uri.parse(
        'https://gateway.marvel.com/v1/public/characters?ts=1&apikey=2e99bb20149dec2f4d399a878442505a&hash=4f6c0d65b4782022691221eceef05ca6'));

    if (response.statusCode == 200) {
      var data = response.body; //store response as string

      var superheros_length = jsonDecode(data)['data']
          ['results']; //get all the data from json string superheros
      print(superheros_length.length); // just printed length of data
      return superheros_length;
    } else {
      print(response.statusCode);
    }
  }
}
