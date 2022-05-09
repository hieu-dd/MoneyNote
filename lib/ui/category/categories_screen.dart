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
  var _displayCategories = [];
  final _searchController = TextEditingController();

  @override
  void initState() {
    _searchCategories('');
    super.initState();
  }

  void _searchCategories(String text) async {
    final categoriesProvider = context.read<CategoriesProvider>();
    final displayCategories = await categoriesProvider.getCategories(text);
    setState(() {
      _displayCategories = displayCategories;
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
    final theme = Theme.of(context);
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
          onChanged: (text){
            _searchCategories(text);
          },
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
                final category = _displayCategories[index];
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
              itemCount: _displayCategories.length,
            ),
          )
        ],
      ),
    );
  }
}
