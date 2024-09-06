import 'package:credassignment/screens/secondpage.dart';
import 'package:flutter/material.dart';

import '../Services/category_services.dart';
import '../model/category_model.dart';

class HomePage extends StatefulWidget {
  final String selectedCategory;
  final String selectedSubcategory;
  HomePage({this.selectedCategory = "Select a category", this.selectedSubcategory = ""});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = "Select a category";
  String _selectedSubcategory = "";
  late Future<ExploreCred> _exploreCredFuture;

  @override
  void initState() {
    super.initState();
    _exploreCredFuture = ApiService().fetchExploreCred();
  }

  void _navigateToCategoriesPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriesPage()),
    );

    if (result != null && result is Map) {
      setState(() {
        _selectedCategory = result['category'] ?? _selectedCategory;
        _selectedSubcategory = result['subcategory'] ?? _selectedSubcategory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.black), // Text color
        ),
        backgroundColor: Colors.grey[300], // Background color
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.9),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.selectedCategory,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.selectedSubcategory,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToCategoriesPage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white, // Text color
                ),
                child: Text('Go to Categories'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



