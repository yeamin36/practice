import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types
class location_rate {
  String flag = '';
  String location = '';
  double rate = 1.0;
  String currency = 'BDT'; // Changed to double for more accurate rates

  location_rate({
    required this.flag,
    required this.location,
    this.currency = 'BDT',
  });

  Future<void> rate_decider(String loc) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://v6.exchangerate-api.com/v6/bcfed61c5e342f27160cad7d/latest/USD'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10)); // Add timeout

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Map<String, dynamic> rates = data['conversion_rates'];

        Map<String, String> currencyCodes = {
          'Bangladesh': 'BDT',
          'India': 'INR',
          'France': 'EUR',
          'Turkey': 'TRY',
          'Japan': 'JPY',
          'Australia': 'AUD',
          'Canada': 'CAD',
          'Singapore': 'SGD',
          'UAE': 'AED'
        };

        String? currencyCode = currencyCodes[loc];
        currency = currencyCodes[loc] ?? 'BDT';
        if (currencyCode != null && rates.containsKey(currencyCode)) {
          // Properly handle the numeric conversion
          var rateValue = rates[currencyCode];
          rate =
              rateValue is int ? rateValue.toDouble() : (rateValue as double);
        } else {
          print('Currency code not found: $currencyCode');
          throw Exception('Currency code not found');
        }
      } else {
        print('API request failed with status: ${response.statusCode}');
        throw Exception('API request failed');
      }
    } catch (e) {
      print('Error fetching exchange rates: $e');
      // Only use fallback rates for specific errors or timeouts
      Map<String, double> fallbackRates = {
        'Bangladesh': 119.0,
        'India': 114.0,
        'France': 10.0,
        'Turkey': 58.0,
        'Japan': 148.0,
        'Australia': 1.48,
        'Canada': 1.34,
        'Singapore': 1.33,
        'UAE': 3.67
      };
      rate = fallbackRates[loc] ?? 1.0;
    }
  }
}
