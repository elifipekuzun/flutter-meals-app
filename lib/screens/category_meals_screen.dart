import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> meals;
  const CategoryMealsScreen({super.key, required this.meals});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryId;
  late String categoryTitle;
  late List<Meal> categoryMeals;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryId = routeArgs['id'] as String;
    categoryTitle = routeArgs['title'] as String;
    categoryMeals = widget.meals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
  }

  // void _removeMealItem(String id) {
  //   setState(() {
  //     categoryMeals.removeWhere((meal) => meal.id == id);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!)),
      body: ListView.builder(
        itemBuilder: ((_, index) {
          return MealItem(categoryMeals[index]);
        }),
        itemCount: categoryMeals.length,
      ),
    );
  }
}
