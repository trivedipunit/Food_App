import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/meal_details.dart';
import 'package:food_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget{
  const MealsScreen({super.key,this.title, required this.meals, required this.onToggleFavorite});

  final String? title;//by using ? it can laso be null(we make it optional)
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

 void selectMeal(BuildContext context, Meal meal){
  //Navigator.of(context).pop();(manually goes to previous screen)
  Navigator.of(context).push(MaterialPageRoute(builder:(ctx) => MealDetailsScreen(meal: meal,
  onToggleFavorite: onToggleFavorite,),),);
 }

  @override
  Widget build (BuildContext context) {
    Widget content =  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [   //center at present
            Text('uh oh.....nothing here!',style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                   color: Theme.of(context).colorScheme.onBackground,
               ),
      ),
      const SizedBox(height: 16),
      Text( 'Try something a different category !',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      ),

      ],
      ),
      );
       
    if(meals.isNotEmpty){
      content = ListView.builder(
        itemCount: meals.length,//add later
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal){
            selectMeal(context, meal);

        },),//index gives us single meal value
      );
    }
    if(title == null){
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),// if we executed this then it is not null so we used !
      ),
     /* body: ListView.builder(
        itemBuilder: (ctx,index) => Text(       //Scrollable list view
      meals[index].title,
    
      ),
    ),*/
    body: content,);
  }
}