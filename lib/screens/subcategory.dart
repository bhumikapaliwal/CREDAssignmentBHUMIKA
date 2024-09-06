import 'package:flutter/material.dart';

import '../Services/category_services.dart';

class SubCategoryDetails extends StatelessWidget {
  final CategoryDetails categoryDetails;

  const SubCategoryDetails({Key? key, required this.categoryDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryDetails.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            categoryDetails.icon,
            const SizedBox(height: 20),
            Text(
              categoryDetails.heading,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              categoryDetails.subheading,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
