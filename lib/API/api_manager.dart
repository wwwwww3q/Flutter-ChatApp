import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import '../all_page.dart';

Future<List<User>> apiGetUser(String txtSearch) async {
  List<User> lst = [];
  try {
    final response = await http.get(Uri.parse("https://dummyjson.com/users"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonRaw = json.decode(response.body); //cho json ko bị lỗi font
      final List list = jsonRaw['users'];
      lst = list.map((data) => User.fromJson(data)).where((element) {
        final nameLower = element.firstName!.toLowerCase() + " " + element.lastName!.toLowerCase();
        final queryLower = txtSearch.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
    // ignore: empty_catches
  } catch (e) {}

  return lst;
}
