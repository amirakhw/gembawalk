import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/theme.dart';
import '../gemba_walk/nouvelle_visite_screen.dart';
import '../action-plan/action_plan_agency_list_screen.dart';
import 'HistoriqueVisitesScreen.dart'; // Import the new screen

class VisitorHomeScreen extends StatelessWidget {
  const VisitorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/attijariLogo.png", height: 30),
            const SizedBox(width: 8.0),
            const Text(
              'Gemba Walk',
              style: TextStyle(
                color: attijariWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 600) {
                  // Web layout: Buttons in a row
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildHomeButton(
                        context: context,
                        text: 'nouvelle visite',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const NouvelleVisiteScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20.0),
                      _buildHomeButton(
                        context: context,
                        text: 'historique des visites',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoriqueVisitesScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20.0),
                      _buildHomeButton(
                        context: context,
                        text: 'suivre les plans d\'action',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const ActionPlanAgencyListScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  // Mobile layout: Buttons in a column
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHomeButton(
                        context: context,
                        text: 'nouvelle visite',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const NouvelleVisiteScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildHomeButton(
                        context: context,
                        text: 'historique des visites',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoriqueVisitesScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildHomeButton(
                        context: context,
                        text: 'suivre les plans d\'action',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const ActionPlanAgencyListScreen(),
                            ),
                          );
                        },
                      ),

                      //----------------LOG OUT BUTTON
                      /*                     ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamedAndRemoveUntil('/', (route) => false);
                        },
                        child: const Text('LOG OUT'),
                      ), */
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamedAndRemoveUntil('/', (route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF8F0E3),
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 24.0,
                              ),
                              textStyle: const TextStyle(fontSize: 16.0),
                              fixedSize: const Size(200, 40),
                            ),
                            child: const Text('LOG OUT'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: attijariWhite,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(fontSize: 18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        side: const BorderSide(color: attijariPrimary, width: 1.5),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: attijariPrimary),
      ),
    );
  }
}
