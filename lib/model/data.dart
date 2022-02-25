import 'dart:convert';
import 'package:russian_gold/components/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Person> persons = [];

Future setData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final data = jsonEncode(persons);
  prefs.setString('persons', data);
  prefs.reload();
}

Future getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringData = prefs.getString('persons');
  final parsedData = await jsonDecode(stringData!) as List<dynamic>?;
  final data = parsedData!.map((item) => Person.fromJson(item)).toList();

  persons = data;
  prefs.reload();
}
