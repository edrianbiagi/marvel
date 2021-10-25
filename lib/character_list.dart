import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:marvel/character_detail.dart';
import 'package:marvel/services/characters_api.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data;
  var superheros_length;
  CharactersApi charactersApi = CharactersApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    charactersApi.getCharacters();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=2e99bb20149dec2f4d399a878442505a&hash=4f6c0d65b4782022691221eceef05ca6"));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        superheros_length = jsonDecode(data)['data']
            ['results']; //get all the data from json string superheros
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marvel"),
      ),
      body: ListView.builder(
        itemCount: superheros_length == null ? 0 : superheros_length.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
                leading: Image.network(
                  jsonDecode(data)['data']['results'][index]['thumbnail']
                              ['path']
                          .toString() +
                      '.' +
                      jsonDecode(data)['data']['results'][index]['thumbnail']
                              ['extension']
                          .toString(),
                  fit: BoxFit.fill,
                  width: 100,
                  height: 500,
                  alignment: Alignment.center,
                ),
                title: Text(superheros_length[index]['name']),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CharacterDetail(
                              name: jsonDecode(data)['data']['results'][index]
                                  ['name'],
                              description: jsonDecode(data)['data']['results']
                                  [index]['description'],
                              path: jsonDecode(data)['data']['results'][index]
                                      ['thumbnail']['path']
                                  .toString(),
                              extension: jsonDecode(data)['data']['results']
                                      [index]['thumbnail']['extension']
                                  .toString(),
                              available: jsonDecode(data)['data']['results']
                                  [index]['comics']['available'])));
                }),
          );
        },
      ),
    );
  }
}
