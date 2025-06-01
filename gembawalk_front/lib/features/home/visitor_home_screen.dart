import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/colors.dart';
import 'package:gembawalk_front/config/theme.dart';
import '../gemba_walk/nouvelle_visite_screen.dart';
import '../action-plan/visitor_action_plan_list_screen.dart';
import 'HistoriqueVisitesScreen.dart'; // Import the new screen

class VisitorHomeScreen extends StatelessWidget {
  const VisitorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Row(
          children: [
            Image.asset("assets/images/attijariLogo.png", height: 30),
            const SizedBox(width: 8),
            const Text(
              'Gemba Walk',
              style: TextStyle(
                color: attijariWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
            padding: const EdgeInsets.all(24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                final children = [
                  _buildHomeButton(
                    context: context,
                    text: 'nouvelle visite',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NouvelleVisiteScreen(),
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
                              (context) => const ActionPlanAgencyListScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0),
                  _buildLogoutButton(context),
                ];

                return isWide
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          children
                              .whereType<ElevatedButton>()
                              .toList(), // ignore SizedBox for row layout
                    )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children,
                    );
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
        foregroundColor: AppColors.primary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      onPressed: onPressed,
      child: Text(text.toUpperCase(), textAlign: TextAlign.center),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF8F0E3),
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          elevation: 2,
        ),
        child: const Text('Déconnexion'),
      ),
    );
  }
}
