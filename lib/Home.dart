import 'package:currency_converter/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//hachi hochche
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  String actualCurrency = '';
  double result = 0;
  Map<String, dynamic> currencyData = {};

  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currencyData = currencyData.isEmpty
        ? ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>
        : currencyData;

    if (currencyData['currency'] == null) currencyData['currency'] = 'BDT';

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Currency Converter',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          currencyData['location'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${result.toStringAsFixed(4)} ${currencyData['currency']}',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: controller,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter amount",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                    prefixIcon: const Icon(
                      Icons.monetization_on_rounded,
                      color: Colors.white70,
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: _switchCurrency,
                        icon: const Icon(
                          Icons.autorenew_outlined,
                          color: Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _convertCurrency,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Icon(
                          Icons.currency_exchange,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/location');
          if (result != null) {
            setState(() {
              currencyData = result as Map<String, dynamic>;
              this.result = 0;
              controller.clear();
              count = 0;
              actualCurrency = '';
            });
          }
        },
        child: const Icon(
          Icons.edit_location_alt_outlined,
          size: 24,
        ),
      ),
    );
  }

  void _switchCurrency() {
    setState(() {
      result = 0;
      currencyData['rate'] = 1 / currencyData['rate'];
      if (count == 0) {
        actualCurrency = currencyData['currency'];
        currencyData['currency'] = 'USD';
        count = 1;
      } else {
        currencyData['currency'] = actualCurrency;
        count = 0;
      }
    });
  }

  void _convertCurrency() {
    if (controller.text.isEmpty) return;

    setState(() {
      result = (double.tryParse(controller.text) ?? 0) * currencyData['rate'];
    });
  }
}
