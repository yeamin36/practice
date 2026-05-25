import 'package:currency_converter/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading_screen extends StatefulWidget {
  const loading_screen({super.key});
  @override
  State<loading_screen> createState() => _loading_screenState();
}

class _loading_screenState extends State<loading_screen> {
  void setworldtime() async {
    try {
      location_rate instances =
          location_rate(location: 'Bangladesh', flag: 'bangladesh.png');
      await instances.rate_decider(instances.location);

      if (!mounted) return; // Check if widget is still mounted

      Map<String, dynamic> data = {
        'location': instances.location,
        'flag': instances.flag,
        'rate': instances.rate,
        'currency': instances.currency,
      };

      await Future.delayed(const Duration(seconds: 3));

      Navigator.pushReplacementNamed(context, '/home', arguments: data);
    } catch (e) {
      print('Error in loading screen: $e');
      // Provide default values if there's an error
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          'location': 'Bangladesh',
          'flag': 'bangladesh.png',
          'rate': 1.0,
          'currency': 'BDT',
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setworldtime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 130.0,
        ),
      ),
    );
  }
}
