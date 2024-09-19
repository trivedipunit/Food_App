import 'package:flutter/material.dart';
import 'package:food_app/data/dummy_data.dart';

import 'package:food_app/screens/categories.dart';
import 'package:food_app/screens/filters.dart';
import 'package:food_app/screens/meals.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/main_drawer.dart';

//global variable
const kInitialFilters = {
  Filter.glutenFree : false,
    Filter.lactoseFree : false,
    Filter.vegetarian : false,
    Filter.vegan : false

};

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  
  }

}
//state class that belongs to TabsScreen
class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),),);
  }

  void _toggleMealFavoriteStatus(Meal meal){//add a meal to the list or remove the meal
    final isExisting = _favoriteMeals.contains(meal);

    if(isExisting){
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a Favorite');
      _favoriteMeals.remove(meal);
    } else{
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Meal is marked as a Favorite');
      }); 
    }   
  }

  void _selectPage(int index){
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if(identifier == 'filters'){
     final result = await Navigator.of(context).push<Map<Filter,bool>>(// pushReplacement = filter screen is not pushed as a new screen onto the stack of screens, instead tabs screen will be replaced as a filter screen
        MaterialPageRoute(builder: (ctx)=> FiltersScreen(currentFilters: _selectedFilters,), // keys are filter type, values are bool type
      ),
      );
    setState(() {
      _selectedFilters = result ?? kInitialFilters;
    });
    }

  }

  @override
  Widget build(BuildContext context) {
    final  availableMeals = dummyMeals.where((meal){
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
       if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
       if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
       if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;

    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,

    );
    var activePageTitle = 'Categories';

    if(_selectPageIndex == 1){
      activePage = MealsScreen(meals: _favoriteMeals,
      onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your favourities';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer:MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap:_selectPage,
        currentIndex: _selectPageIndex,
        items: const [   
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories',),
          BottomNavigationBarItem(icon:Icon(Icons.star), label: 'Favourite',),   //for category screen
        ],
        ),//for favourite Screen],
    );
   
  }

}
