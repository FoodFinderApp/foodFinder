import 'package:flutter/material.dart';
import 'package:foodfinder/models/directions_model.dart';

class DisDuration extends StatelessWidget {
  const DisDuration({
    Key? key,
    required Directions? info,
  })  : _info = info,
        super(key: key);

  final Directions? _info;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            )
          ],
        ),
        child: Text(
          '${_info!.totalDistance}, ${_info!.totalDuration}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
