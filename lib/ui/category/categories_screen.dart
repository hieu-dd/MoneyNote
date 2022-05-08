import 'package:flutter/material.dart';
import 'package:money_note/models/category/category.dart';
import 'package:money_note/providers/category/categories.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  Function(Category) selectCategory;

  CategoriesScreen({required this.selectCategory});

  void _onSelect(BuildContext context, Category category) {
    selectCategory(category);
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
                        final category = categories[index];
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
                      itemCount: categories.length,
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
