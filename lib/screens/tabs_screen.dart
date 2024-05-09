import 'package:flutter/material.dart';
import 'package:travel_mobile/models/trip.dart';
import 'package:travel_mobile/screens/categoris_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/app_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Trip> favoriteTrips;
  static const screenRoute = '/tabs_screen';
  const TabsScreen(this.favoriteTrips, {Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  late List<Map<String, Object>> _screens;

  _TabsScreenState();

  @override
  void initState() {
    _screens = [
      {
        'Screen': CategoriesScreen(),
        'Title': 'تصنيفات',
      },
      {
        'Screen': FavoritesScreen(widget.favoriteTrips), // Pass favoriteTrips to FavoritesScreen
        'Title': 'الرحلات المفضلة',
      },
    ];
    super.initState();
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]['Title'] as String),
      ),
      drawer: const AppDrawer(),
      body: _screens[_selectedScreenIndex]['Screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).secondaryHeaderColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'التصنيفات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'التفضيلات',
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
