import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class Gyroscope extends StatefulWidget {
  @override
  _GyroscopeState createState() => _GyroscopeState();
}

class _GyroscopeState extends State<Gyroscope> {

  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];

  double previousZ = 0;
  bool even = true;

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];

        even = !even;
        if (even) {
          previousZ = event.z;
        }
        

        if (event.z > 2) {
          print("LEFT z > 1");
        } else if (event.z < -2) {
          print("RIGHT z < -1");
        }
      });
    }));
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}