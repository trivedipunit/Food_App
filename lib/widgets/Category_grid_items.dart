import 'package:flutter/material.dart';

import 'package:food_app/models/category.dart';

class CategorygridItems extends StatelessWidget{
  const CategorygridItems({super.key, required this.category,
  required this.onSelectCategory, 
  });

  final Category category;
  final void Function() onSelectCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(       //inkwell widget not only make child wiget tapable it can also be achieved by GestureDetector but inkwell also get nice visual feedback
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16), //round corners
      child: Container( //container = background color and decoration 2. make container tapable by wrap into other widget
      padding: const EdgeInsets.all(16),//add a padding of 16 pixels in all directions
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            )
        ), 
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    ); 
  }
}