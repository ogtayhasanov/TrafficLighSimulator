import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(TrafficLightApp());
}

class TrafficLightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Light Simulation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrafficLightScreen(),
    );
  }
}

class TrafficLightScreen extends StatefulWidget {
  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  int _currentLightIndex = 0;
  final List<Color> _lightColors = [Colors.red, Colors.yellow, Colors.green];
  final List<int> _durations = [5000, 2000, 5000]; // Durations in milliseconds

  @override
  void initState() {
    super.initState();
    _startTrafficLightCycle();
  }

  void _startTrafficLightCycle() {
    Timer.periodic(Duration(milliseconds: _durations[_currentLightIndex]),
        (Timer timer) {
      setState(() {
        _currentLightIndex = (_currentLightIndex + 1) % _lightColors.length;
      });
      timer.cancel(); // Cancel the current timer
      Future.delayed(Duration(milliseconds: _durations[_currentLightIndex]),
          () {
        _startTrafficLightCycle(); // Start the next cycle
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traffic Light Simulation'),
      ),
      body: Center(
        child: Container(
          width: 100,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentLightIndex == index
                      ? _lightColors[index]
                      : Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
