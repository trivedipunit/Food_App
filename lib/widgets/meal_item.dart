import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart'; //ktransparentImage

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function( Meal meal) onSelectMeal;

  //getter which return string, name give u acces to enum value
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() + //1st word is uppercase
        meal.complexity.name.substring(1); //rset word is in lowercase
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() + //1st word is uppercase
        meal.affordability.name.substring(1); //rset word is in lowercase
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip
          .hardEdge, //clip hardedges of child widget which goes outside of the shape boundaries
      elevation:
          2, //add slight drop shadow behind card and give some elevation and 3d effect
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          //it is not the stack of screens(it is used to set an image on a background and text on it)
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit
                  .cover, //image never distorted but instead cut off and zoomed in a bit if it is not fit
              height: 200,
              width: double
                  .infinity, //used entire width as much it can get horizontally(all available space)
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center, //present in center
                        softWrap: true, //it should wrap in a good looking way
                        overflow: TextOverflow
                            .ellipsis, //very long text then it ends with (.....)
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                          height: 12), //difference between etxt and meta data
                      Row(
                          //metadata which shown below the image title
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MealItemTrait(
                                icon: Icons.schedule,
                                label: '${meal.duration} min'),
                            const SizedBox(
                              width: 12,
                            ),
                            MealItemTrait(
                                icon: Icons.schedule, label: complexityText),
                            const SizedBox(
                              width: 12,
                            ),
                            MealItemTrait(
                                icon: Icons.schedule, label: affordabilityText),
                          ]),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
