main.dart
This file is the entry point of the Flutter application.

MyApp class:
It's a stateful widget.
It manages the state of the app.
Contains _changeFilters method to update the filters for available trips.
Defines _filters which holds the current filters for trips.
Defines _availableTrips which holds the list of available trips based on the applied filters.
MaterialApp:
The root widget of the application.
Sets the theme and routes for the app.
Home is set to TabsScreen, which is the main screen of the app.
Other routes include categoryTripsScreen, TripDetailScreen, and FiltersScreen.
tabs_screen.dart
This file defines the main screen of the app which contains tabs.

TabsScreen class:
Stateful widget.
Contains tabs for different categories of trips.
Each tab displays a list of trips based on the category.
category_trips_screen.dart
This file defines a screen for displaying trips of a specific category.

CategoryTripsScreen class:
Stateful widget.
Receives a list of trips for a specific category and displays them.
Navigates to TripDetailScreen when a trip is tapped.
trip_detail_screen.dart
This file defines the screen for displaying details of a trip.

TripDetailScreen class:
Stateless widget.
Displays details of a trip including image, title, and description.
filters_screen.dart
This file defines the screen for applying filters to trips.

FiltersScreen class:
Stateful widget.
Allows users to toggle filters for summer, winter, and family trips.
Passes the selected filters back to the main app using a callback.
Other Files
app_data.dart: Contains sample trip data.
models/trip.dart: Defines the Trip class.
widgets/app_drawer.dart: Contains a drawer widget for the app.



Overall, the app allows users to browse different categories of trips, view trip details, and apply filters to see specific types of trips.
