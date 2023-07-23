import 'package:flutter/material.dart';
import 'package:gsg_quiz_1/Helpers/Nav_Helper.dart';
import 'package:gsg_quiz_1/Helpers/NetworkHelper.dart';
import 'package:gsg_quiz_1/Screens/Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with Nav_Helper, Network_Helper {
  @override
  void initState() {
    super.initState();
    intilize();
  }

  void intilize() async {
    var quote = await getQuote();
    var img = await getImage(quote.tags?.first ?? 'School');
    if (mounted) {
      jump(context, Home(url: img, quote: quote), replace: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/quotes.png', height: 128),
            const SizedBox(height: 16),
            const Text(
              'Quoty',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'FocusQuotes',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
