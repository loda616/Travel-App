import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_mobile/app_data.dart';
import 'package:travel_mobile/models/trip.dart';
import 'package:travel_mobile/screens/filters_screen.dart';
import 'package:travel_mobile/screens/login_screen.dart';
import 'package:travel_mobile/screens/sign_up_screen.dart';
import './screens/tabs_screen.dart';
import './screens/trip_detail_screen.dart';
import './screens/category_trips_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void _manageFavorite(String tripId) {
    final existingIndex = _favoriteTrips.indexWhere((trip) => trip.id == tripId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteTrips.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteTrips.add(Trips_data.firstWhere((trip) => trip.id == tripId));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  void _changeFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableTrips = Trips_data.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }

        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }

        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  Map<String, bool> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = Trips_data;
  final List<Trip> _favoriteTrips = [];

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', 'value');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [],

      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.amber,
        fontFamily: 'ElMessiri',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline5: const TextStyle(
            color: Colors.blue,
            fontSize: 24,
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.bold,
          ),
          headline6: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        '/': (ctx) =>LoginScreen(_favoriteTrips),
        '/tabs_screen': (ctx) => TabsScreen(_favoriteTrips),
        LoginScreen.screenRoute: (ctx) => LoginScreen(_favoriteTrips),
        SignUpScreen.screenRoute: (ctx) => SignUpScreen(),
        categoryTripsScreen.screenRoute: (ctx) => categoryTripsScreen(_availableTrips),
        TripDetailScreen.screenRoute: (ctx) => TripDetailScreen(_manageFavorite, _isFavorite),
        FiltersScreen.screenRoute: (ctx) => FiltersScreen(_filters, _changeFilters)
      },
    );
  }
}
