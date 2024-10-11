import 'package:geocoding/geocoding.dart';
import 'package:hotel_flutter/data/model/hotel/room_model.dart';
import 'package:logging/logging.dart';

class HotelModel {
  final Logger _logger = Logger('HotelModel');
  final String id;
  final String name;
  final String location;
  final String openingHours;
  final String hotelImage;
  final double averageRating;
  final double averagePrice;
  final List<RoomModel> rooms;

  HotelModel({
    required this.id,
    required this.name,
    required this.location,
    required this.averageRating,
    required this.openingHours,
    required this.hotelImage,
    required this.rooms,
    required this.averagePrice,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['_id'] ?? 'Unknown ID',
      name: json['name'] ?? 'Unknown Hotel',
      location: json['location'] ?? 'Unknown Location',
      openingHours: json['openingHours'] ?? 'Unknown Hours',
      hotelImage: json['hotelImage'] ?? 'https://via.placeholder.com/150',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      averagePrice: (json['averagePrice'] ?? 0).toDouble(),
      rooms: (json['rooms'] != null && json['rooms'] is List)
          ? (json['rooms'] as List)
              .map((roomJson) => RoomModel.fromJson(roomJson))
              .toList()
          : <RoomModel>[], // Default to an empty list if rooms is null or not a List
    );
  }

  // Fetch coordinates based on the location string
  Future<List<double>> getCoordinates() async {
    try {
      List<Location> locations = await locationFromAddress(location);
      return [locations.first.latitude, locations.first.longitude];
    } catch (e) {
      print("Error fetching coordinates for $location: $e");
      return [0.0, 0.0]; // Return [0.0, 0.0] if there is an error
    }
  }
}
