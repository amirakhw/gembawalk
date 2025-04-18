import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'visitor_home_screen.dart';

const Color attijariPrimary = Color(0xFFE5563E);
const Color attijariSecondary = Color(0xFFFFC107);
const Color attijariTextPrimary = Color(0xFF212121);
const Color attijariTextSecondary = Color(0xFF616161);
const Color attijariBackground = Color(0xFFF5F5F5);
const Color attijariInputBackground = Colors.white;
const Color attijariInfo = Color(0xFF1976D2);
const Color attijariSuccess = Color(0xFF388E3C);
const Color attijariWarning = Color(0xFFFBC02D);
const Color attijariError = Color(0xFFD32F2F);
const Color attijariBlack = Color(0xFF000000);
const Color attijariGray1 = Color(0xFF424242);
const Color attijariGray2 = Color(0xFF616161);
const Color attijariGray3 = Color(0xFF9E9E9E);
const Color attijariWhite = Color(0xFFFFFFFF);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez saisir votre nom d\'utilisateur et votre mot de passe.',
          ),
        ),
      );
      return;
    }

    final Uri uri = Uri.parse('http://192.168.181.250:8080/api/auth/login');

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        print('Connexion réussie! Token: $token');
        await _storage.write(key: 'jwt_token', value: token);
        String? storedToken = await _storage.read(key: 'jwt_token');
        print('Token stored securely: $storedToken');
// Decode the JWT token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
// Extract the user's role
        String? role = decodedToken['role'];
        print('User Role: $role');

        if (role == 'ROLE_VISITOR') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VisitorHomeScreen()),
          );
        } else if (role == 'ROLE_TECHNICIAN') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Text('Technician Screen Placeholder')),
          );
        } else if (role == 'ROLE_DASHBOARD_VIEWER') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Text('Dashboard Viewer Screen Placeholder')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Rôle utilisateur inconnu.')),
          );
        }
      } else {
        print(
          'Échec de la connexion. Status code: ${response.statusCode}, body: ${response.body}',
        );
        String errorMessage =
            'Échec de la connexion. Veuillez vérifier vos informations d\'identification.';
        try {
          final Map<String, dynamic> errorData = jsonDecode(response.body);
          if (errorData.containsKey('message')) {
            errorMessage = errorData['message'];
          }
        } catch (e) {
          print('Erreur lors du décodage de la réponse d\'erreur: $e');
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (error) {
      print('Erreur lors de la connexion: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Une erreur s\'est produite lors de la connexion.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: attijariBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Image(
                height: 80,
                image: AssetImage("assets/images/attijariLogo.png"),
              ),
              const SizedBox(height: 48.0),
              Text(
                'Bienvenue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: attijariTextPrimary,
                ),
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: attijariTextSecondary,
                  ),
                  filled: true,
                  fillColor: attijariInputBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: attijariTextSecondary.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: attijariPrimary),
                  ),
                ),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: attijariTextPrimary,
                ),
                controller: _usernameController,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: attijariTextSecondary,
                  ),
                  filled: true,
                  fillColor: attijariInputBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: attijariTextSecondary.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: attijariPrimary),
                  ),
                ),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: attijariTextPrimary,
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: attijariPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _login,
                child: const Text(
                  'Se connecter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
