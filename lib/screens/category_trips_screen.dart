import 'package:flutter/material.dart';
import 'package:travel_mobile/widgets/trip_item.dart';
import '../app_data.dart';
import '../models/trip.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class categoryTripsScreen extends StatefulWidget {
  static const screenRoute = '/categroy-trips';
  final List<Trip> availableTrips;

  categoryTripsScreen(this.availableTrips);

  @override
  State<categoryTripsScreen> createState() => _categoryTripsScreenState();
}

class _categoryTripsScreenState extends State<categoryTripsScreen> {

  late String categoryTitle;
  late List<Trip>displayTrips;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgument =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgument['id'];
    categoryTitle = routeArgument['title'] ??"";
    displayTrips = widget.availableTrips.where((trip) {
      return trip.categories.contains(categoryId);
    }).toList(); // <-- Corrected here: Changed Widget to widget
    super.didChangeDependencies();
  }

  void _removeTrip(String tripID){
    setState(() {
      displayTrips.removeWhere((trip) => trip.id == tripID);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return TripItem(
            id: displayTrips[index].id,
            title: displayTrips[index].title,
            imageUrl: displayTrips[index].imageUrl,
            duration: displayTrips[index].duration,
            tripType: displayTrips[index].tripType,
            season: displayTrips[index].season,

          );
        },
        itemCount: displayTrips.length,
      ),
    );
  }
}
