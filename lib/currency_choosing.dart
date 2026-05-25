import 'package:flutter/material.dart';
import 'package:currency_converter/location_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class currency_choser extends StatefulWidget {
  const currency_choser({super.key});

  @override
  State<currency_choser> createState() => _currency_choserState();
}

class _currency_choserState extends State<currency_choser> {
  int exchange_rate = 1;
  List<location_rate> locations = [
    location_rate(flag: 'bangladesh.png', location: 'Bangladesh'),
    location_rate(flag: 'india.png', location: 'India'),
    location_rate(flag: 'france.png', location: 'France'),
    location_rate(flag: 'turkey.png', location: 'Turkey'),
    location_rate(flag: 'japan.png', location: 'Japan'),
    location_rate(flag: 'australia.png', location: 'Australia'),
    location_rate(flag: 'canada.png', location: 'Canada'),
    location_rate(flag: 'singapore.png', location: 'Singapore'),
    location_rate(flag: 'uae.png', location: 'UAE')
  ];

  // ignore: non_constant_identifier_names
  void rate_of_exchange(index) async {
    location_rate instances = locations[index];
    await instances.rate_decider(instances.location);
    Navigator.pop(context, {
      'location': instances.location,
      'rate': instances.rate,
      'currency': instances.currency,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[900],
          title: Text(
            'Choose Location',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          centerTitle: true),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Card(
              child: ListTile(
                onTap: () {
                  rate_of_exchange(index);
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                tileColor: Colors.black,
                title: Text(
                  locations[index].location,
                  style: GoogleFonts.poppins(
                    fontSize: 28.0,
                    letterSpacing: 3.0,
                    color: Colors.white,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
