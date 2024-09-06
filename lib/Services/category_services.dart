import 'dart:convert';
import 'package:credassignment/model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String apiUrl = 'https://api.mocklets.com/p6839/explore-cred';

  Future<ExploreCred> fetchExploreCred() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ExploreCred.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class CategoryDetails {
  final String heading;
  final String subheading;
  final Widget icon;

  CategoryDetails({
    required this.heading,
    required this.subheading,
    required this.icon,
  });
}

Future<void> fetchData() async {
  final response = await http.get(Uri.parse('https://api.mocklets.com/p6839/explore-cred'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final exploreCred = ExploreCred.fromJson(jsonData);

    // Use the `exploreCred` object as needed
  } else {
    // Handle error
  }
}