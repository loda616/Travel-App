import 'package:flutter/material.dart';
import '../screens/trip_detail_screen.dart';
import '../models/trip.dart';

class TripItem extends StatelessWidget {
  final String   id;
  final String   title;
  final String   imageUrl;
  final int      duration;
  final TripType tripType;
  final Season   season;

  TripItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.tripType,
    required this.season,
  });

  String get seasonText {
    switch (season) {
      case Season.Winter:
        return 'شتاء';
      case Season.Spring:
        return 'ربيع';
      case Season.Summer:
        return 'صيف';
      case Season.Autumn:
        return 'خريف';
      default:
        return "غير معروف";
    }
  }

  String get tripTypeText {
    switch (tripType) {
      case TripType.Exploration:
        return "استكشاف";
      case TripType.Recovery:
        return "نقاهة";
      case TripType.Activities:
        return "أنشطة";
      case TripType.Therapy:
        return "معالجة";
      default:
        return "غير معروف";
    }
  }

  void selectTrip(BuildContext context) {
    Navigator.of(context)
        .pushNamed(TripDetailScreen.screenRoute,
        arguments: id).then((result){
          if(result != null){
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectTrip(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: const [0.6, 1],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      const SizedBox(width: 6),
                      Text('$duration أيام'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      const SizedBox(width: 6),
                      Text(seasonText),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.family_restroom,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      const SizedBox(width: 6),
                      Text(tripTypeText),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
