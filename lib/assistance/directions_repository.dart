import 'package:dio/dio.dart';
import 'package:foodfinder/models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': "AIzaSyBc2wb688YyzZ6o8Q2b2WoDPBcrE0FOf1g",
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      var dir = Directions.fromMap(response.data);
      if (dir.bounds == null &&
          dir.polylinePoints == null &&
          dir.totalDistance == null &&
          dir.totalDuration == null) {
        return null;
      } else
        return Directions.fromMap(response.data);
    }
    return null;
  }
}
