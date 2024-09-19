import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key,
       required this.meal,
       required this.onToggleFavorite,});

  final Meal meal;
 final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [ //make a button to mark items as favourities(star button)
          IconButton(onPressed: (){
            onToggleFavorite(meal);
          }, 
             icon: const Icon(Icons.star),)

          ],
        ),
        body: SingleChildScrollView(
          child: Column( //scrollable also done by listView
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ), //space between image and next section
              Text(
                'Ingridients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith( //! teels dart that this will exist then i can call copy with on that title large text variant
                      color: Theme.of(context).colorScheme.primary,//primary makes it lookes different
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14,),
              for(final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith( //! teels dart that this will exist then i can call copy with on that title large text variant
                      color: Theme.of(context).colorScheme.onBackground,),
              ),
              const SizedBox(height: 24,),
               Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith( //! teels dart that this will exist then i can call copy with on that title large text variant
                      color: Theme.of(context).colorScheme.primary,//primary makes it lookes different
                      fontWeight: FontWeight.bold,
                    ),
                    
              ),
              const SizedBox(height: 14,),
               for(final step in meal.steps)
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,
                vertical: 8),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith( //! teels dart that this will exist then i can call copy with on that title large text variant
                        color: Theme.of(context).colorScheme.onBackground,),
                ),
              ),
            ],
          ),
        ));
  }
}
