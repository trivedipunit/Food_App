import 'package:flutter/material.dart';

import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/widgets/Category_grid_items.dart';
import 'package:food_app/screens/meals.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/models/meal.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key,required this.onToggleFavorite,
  required this.availableMeals});                //constructor function

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;


  void _selectCategory(BuildContext context, Category category){
    final filterdMeals = 
    availableMeals.where((meal) => meal.categories.contains(category.id)).toList();//contains(built in method in list) check whether it contails a particular element or not

    Navigator.of(context).push(MaterialPageRoute
    (builder: (ctx) => MealsScreen(
      title: category.title, 
      meals:filterdMeals,
      onToggleFavorite: onToggleFavorite,
    ),
    ),
    ); //Navigator.push(context,route) =  Navigator.of(context).push(route)
  }


  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      //body is main page content, builder constructor function whicgh allows you to build grid dynamically, if u have very ling list of grid items
    //  body: GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
    //it controls the layout of gridview items
    body:*/ GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // two columns next to each other
        childAspectRatio: 3/2, //size of gris view items
        crossAxisSpacing: 20, //spacing between columns
        mainAxisSpacing: 20 ),//spacing horizonatlly and vertically of 20 pixel items between my items
        children:  [//(alternative of for loop) availableCategories.map((category) => CategorygridItems(category: category)).toList()
          for(final category in availableCategories)
          CategorygridItems(category: category,
          onSelectCategory:(){
            _selectCategory(context,category);
          } ,)


        /*  Text('1', style: TextStyle(color: Colors.white)),
          Text('2', style: TextStyle(color: Colors.white)),
          Text('3', style: TextStyle(color: Colors.white)),
          Text('4', style: TextStyle(color: Colors.white)),
          Text('5', style: TextStyle(color: Colors.white)),
          Text('6', style: TextStyle(color: Colors.white)),*/
        ],
    );
  }
}