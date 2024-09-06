import 'dart:ui'; // For BackdropFilter
import 'package:flutter/material.dart';
import '../Services/category_services.dart';
import '../model/category_model.dart';

import 'dart:ui'; // For BackdropFilter
import 'package:flutter/material.dart';
import '../Services/category_services.dart';
import '../model/category_model.dart';
import 'homepage.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool _isGridView = true;
  late Future<ExploreCred> _exploreCredFuture;

  @override
  void initState() {
    super.initState();
    _exploreCredFuture = ApiService().fetchExploreCred();
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  void _selectCategory(String category, String subcategory) {
    Navigator.pop(context, {'category': category, 'subcategory': subcategory});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories Page'),
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
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
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25),
          child: FutureBuilder<ExploreCred>(
            future: _exploreCredFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
              }

              final sections = snapshot.data!.sections;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Categories',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Grid View', style: TextStyle(color: Colors.white)),
                        Switch(
                          activeColor: Colors.white,
                          value: _isGridView,
                          onChanged: (value) => _toggleView(),
                        ),
                        Text('List View', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: _isGridView
                        ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemCount: sections.length,
                      itemBuilder: (context, index) {
                        final section = sections[index];
                        return CategoryCard(
                          section: section,
                          isGridView: true,
                          onTap: (item) => _selectCategory(item.displayData.name, item.displayData.name),
                        );
                      },
                    )
                        : ListView.builder(
                      itemCount: sections.length,
                      itemBuilder: (context, index) {
                        final section = sections[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 14.0),
                          child: CategoryCard(
                            section: section,
                            isGridView: false,
                            onTap: (item) => _selectCategory(item.displayData.name, item.displayData.name),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Section section;
  final bool isGridView;
  final ValueChanged<Item> onTap;

  CategoryCard({required this.section, required this.isGridView, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final header = section.templateProperties.header;
    final items = section.templateProperties.items;

    void _selectCategory(String category, String subcategory) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage( selectedCategory: category,
            selectedSubcategory: subcategory,), // Replace with the actual home page
        ),
      ).then((_) {
        Navigator.pop(context, {'category': category, 'subcategory': subcategory});
      });
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                header.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.maxFinite,
                                height: 200,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    final item = items[index];
                                    return ListTile(
                                      leading: Image.network(
                                        item.displayData.iconUrl,
                                        width: 40,
                                        height: 40,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Icon(Icons.error, color: Colors.white),
                                      ),
                                      title: Text(
                                        item.displayData.name,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        item.displayData.description,
                                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                                      ),
                                      onTap: () {
                                        _selectCategory(header.title, item.displayData.name);
                                      },
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Close',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    header.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



