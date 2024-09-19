import 'package:flutter/material.dart';
class Category{
 //constructor function(used to initialse objects)
 const Category ({required this.id, required this.title, this.color = Colors.orange});


  final String id;
  final String title;
  final Color color;

}