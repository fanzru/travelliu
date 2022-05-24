import 'dart:convert';
import "../model/tikum.dart";
import 'package:http/http.dart' as http;

Future<List<Tikum>> getAllTikum() async {
  var response =
      await http.get(Uri.parse('https://travelliu.yaudahlah.my.id/api/tikum'));
  if (response.statusCode == 200) {
    List decoded = jsonDecode(response.body);
    List<Tikum> tikums = [];
    for (var tikum in decoded) {
      tikums.add(Tikum.fromJson(tikum));
    }
    return tikums;
  } else {
    throw Exception('Failed to load all reviews');
  }
}
