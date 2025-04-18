import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'nouvelle_visite_screen.dart';

class VisitorHomeScreen extends StatelessWidget {
  const VisitorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: Row(
          children: [
            Image.asset(
              "assets/images/attijariLogo.png",
              height: 30, // Adjust the height as needed
            ),
            const SizedBox(width: 8.0), // Add some spacing
            const Text(
              'Gemba Walk',
              style: TextStyle(color: attijariWhite, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: attijariWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: const BorderSide(color: attijariPrimary, width: 1.5),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NouvelleVisiteScreen()),
                  );
                },
                child: const Text('nouvelle visite', style: TextStyle(color: attijariPrimary)),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: attijariWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: const BorderSide(color: attijariPrimary, width: 1.5),
                ),
                onPressed: () {
                  // TODO: Implement Historique des visites action
                  print('historique des visites sélectionné');
                },
                child: const Text('historique des visites', style: TextStyle(color: attijariPrimary)),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: attijariWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: const BorderSide(color: attijariPrimary, width: 1.5),
                ),
                onPressed: () {
                  // TODO: Implement Suivre les plans d'action action
                  print('suivre les plans d\'action sélectionné');
                },
                child: const Text('suivre les plans d\'action', style: TextStyle(color: attijariPrimary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}