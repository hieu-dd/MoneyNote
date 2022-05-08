import 'package:flutter/material.dart';
import 'package:money_note/models/category/category.dart';
import 'package:money_note/providers/category/categories.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  Function(Category) selectCategory;

  CategoriesScreen({required this.selectCategory});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _searchText = "";
  final _searchController = TextEditingController();

  void _searchCategory(String text) {
    setState(() {
      _searchText = text;
    });
  }

  void _onSelect(BuildContext context, Category category) {
    widget.selectCategory(category);
    _onBack(context);
  }

  _onBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = context.watch<CategoriesProvider>();
    final theme = Theme.of(context);
    return FutureBuilder(
        future: categoriesProvider.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final categories = snapshot.data as List<Category>;
            final displayCategories = categories
                .where((element) => element.name.contains(_searchText))
                .toList();
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: theme.primaryColor,
                  ),
                  onPressed: () {
                    _onBack(context);
                  },
                ),
                backgroundColor: Colors.white,
                title: TextField(
                  controller: _searchController,
                  onChanged: _searchCategory,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type a category\'s name',
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final category = displayCategories[index];
                        return ListTile(
                          onTap: () {
                            _onSelect(context, category);
                          },
                          leading: Icon(
                            category.icon,
                            color: theme.primaryColor,
                          ),
                          title: Text(category.name),
                          shape: const Border(
                            bottom: BorderSide(width: 0.1),
                            top: BorderSide.none,
                          ),
                        );
                      },
                      itemCount: displayCategories.length,
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
