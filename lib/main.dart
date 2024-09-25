import 'package:flutter/material.dart';
import 'package:cw2/homescreen.dart';
import 'package:cw2/favorites_screen.dart';
import 'package:cw2/recipe.dart';
import 'package:cw2/details.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatefulWidget {
  const RecipeBookApp({super.key});

  @override
  State<RecipeBookApp> createState() => _RecipeBookAppState();
}

class _RecipeBookAppState extends State<RecipeBookApp> {
  final List<Recipe> favoriteRecipes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black54), // Updated from bodyText2 to bodyMedium
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(onFavoriteTapped: _handleFavoriteTapped),
        '/details': (context) => DetailsScreen(
            onFavoriteTapped: _handleFavoriteTapped,
            favorites: favoriteRecipes),
        '/favorites': (context) => FavoritesScreen(favorites: favoriteRecipes),
      },
    );
  }

  void _handleFavoriteTapped(Recipe recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }
}