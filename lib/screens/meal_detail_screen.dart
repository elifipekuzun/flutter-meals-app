import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function favoriteHandler;
  final Function isFavorite;
  const MealDetailScreen(
      {super.key, required this.favoriteHandler, required this.isFavorite});

  Widget buildSectionTitle(String text, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        height: 200,
        width: 300,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    final mealItem = routeArgs['meal'] as Meal;
    return Scaffold(
      appBar: AppBar(title: Text(mealItem.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                mealItem.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(
              ListView.builder(
                  itemCount: mealItem.ingredients.length,
                  itemBuilder: ((_, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(mealItem.ingredients[index])),
                    );
                  })),
            ),
            buildSectionTitle('Steps', context),
            buildContainer(ListView.builder(
                itemCount: mealItem.steps.length,
                itemBuilder: ((_, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(child: Text('# ${index + 1}')),
                        title: Text(mealItem.steps[index]),
                      ),
                      const Divider(),
                    ],
                  );
                })))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => favoriteHandler(mealItem.id)),
        child: isFavorite(mealItem.id)
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
      ),
    );
  }
}
