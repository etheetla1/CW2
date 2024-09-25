import 'package:flutter/material.dart';
import 'package:cw2/recipe.dart';

class HomeScreen extends StatelessWidget {
  final void Function(Recipe) onFavoriteTapped;

  const HomeScreen({super.key, required this.onFavoriteTapped});

  Future<List<Recipe>> _loadRecipes(BuildContext context) async {
    List<Map<String, dynamic>> recipes = [
      {
        'name': 'Vegan Buddha Bowl',
        'ingredients':
            '1. Quinoa\n2. Sweet potatoes\n3. Chickpeas\n4. Avocado\n5. Spinach\n6. Tahini dressing',
        'instructions':
            '1. Cook quinoa according to package instructions.\n2. Roast sweet potatoes in the oven.\n3. Add chickpeas, avocado, and spinach to a bowl.\n4. Top with quinoa and sweet potatoes.\n5. Drizzle with tahini dressing and serve.',
      },
      {
        'name': 'Chocolate Lava Cake',
        'ingredients':
            '1. Dark chocolate\n2. Butter\n3. Eggs\n4. Sugar\n5. Flour\n6. Cocoa powder',
        'instructions':
            '1. Preheat oven to 425°F.\n2. Melt chocolate and butter together.\n3. Mix in eggs, sugar, flour, and cocoa powder.\n4. Pour into greased ramekins.\n5. Bake for 12 minutes. Serve warm with ice cream.',
      },
      {
        'name': 'Caesar Salad',
        'ingredients':
            '1. Romaine lettuce\n2. Croutons\n3. Parmesan cheese\n4. Caesar dressing\n5. Lemon juice\n6. Black pepper',
        'instructions':
            '1. Chop romaine lettuce.\n2. Add croutons and parmesan cheese.\n3. Drizzle with Caesar dressing.\n4. Squeeze lemon juice over the top.\n5. Season with black pepper and toss to combine. Serve chilled.',
      },
      {
        'name': 'Spaghetti Carbonara',
        'ingredients':
            '1. Spaghetti\n2. Pancetta or bacon\n3. Eggs\n4. Parmesan cheese\n5. Black pepper\n6. Salt',
        'instructions':
            '1. Cook spaghetti according to package instructions.\n2. In a pan, cook pancetta or bacon until crispy.\n3. Beat eggs in a bowl, add grated Parmesan cheese, and mix well.\n4. Add cooked spaghetti to the pan with pancetta.\n5. Remove from heat and quickly stir in the egg mixture. Season with black pepper and salt. Serve immediately.',
      },
      {
        'name': 'Tom Yum Soup',
        'ingredients':
            '1. Lemongrass\n2. Galangal\n3. Kaffir lime leaves\n4. Shrimp\n5. Mushrooms\n6. Fish sauce\n7. Lime juice\n8. Chili paste',
        'instructions':
            '1. Bring water to a boil and add lemongrass, galangal, and kaffir lime leaves.\n2. Add shrimp and mushrooms, cook until shrimp turns pink.\n3. Season with fish sauce, lime juice, and chili paste. Serve hot with cilantro on top.',
      },
    ];

    return recipes
        .map((data) => Recipe(
              data['name'],
              data['ingredients'],
              data['instructions'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _loadRecipes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<Recipe> recipes = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
              ),
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: {'recipe': recipe},
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.food_bank,
                          size: 48.0,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipe.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No recipes available',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            );
          }
        },
      ),
    );
  }
}