import 'package:dio/dio.dart';
import 'package:foodfinder/models/deliveryBoyModel.dart';

class BoyLocationApi {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8081/'));

  Future<DeliveryBoyModel> getCurrentLocation() async {
    final response = await _dio.get('');
    return DeliveryBoyModel.fromJson(response.data);
  }
}
