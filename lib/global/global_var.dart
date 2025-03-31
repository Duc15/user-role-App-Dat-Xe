import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;
double countRatingStars = 0.0;
String titleStarsRating = "";
String googleMapKey = "AIzaSyDk4fssOnC_UtZ2bGu8LzWAPw3HT39-22M";
String serverKeyFCM =
    "key=AAAAenFnGus:APA91bFfsed3QVkaFEn8kbJZ18QcfvjUT0zWWH9eO8SGkwhaTRv0cUJAG708tIwrR1Qg9K2hJUJncQ7FeToRPbP9hNe0WxLo3fRDijkxw705vw-Hhbk7ZtWkr-_HQRHTX_fQkgj3te-5";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);
