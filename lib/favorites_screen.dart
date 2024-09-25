import 'package:flutter/material.dart';
import 'package:cw2/recipe.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final recipe = favorites[index];
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                recipe.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(recipe.ingredients),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: {'recipe': recipe},
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}