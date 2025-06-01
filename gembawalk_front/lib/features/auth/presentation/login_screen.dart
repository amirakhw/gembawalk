import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../dashboard/dashboard_viewer_screen.dart';
import '../../home/technician_home_screen.dart';
import '../../home/visitor_home_screen.dart';
import 'package:gembawalk_front/config/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  bool _isObscure = true; // For password visibility

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar(
        'Veuillez saisir votre nom d\'utilisateur et votre mot de passe.',
      );
      return;
    }

    final Uri uri = Uri.parse(
      'http://' + dotenv.get('LOCALIP') + ':8080/api/auth/login',
    );
    //final Uri uri = Uri.parse('http://192.168.1.25:8080/api/auth/login');
    //print("***********************************************$uri");

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

      print(
        "**********************waiting LOGIN from  $uri   ******************************",
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        await _storage.write(key: 'jwt_token', value: token);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        String? role = decodedToken['role'];

        Widget nextPage;
        if (role == 'ROLE_VISITOR') {
          nextPage = const VisitorHomeScreen();
        } else if (role == 'ROLE_TECHNICIAN') {
          nextPage = const TechnicianHomeScreen();
        } else if (role == 'ROLE_DASHBOARD_VIEWER') {
          nextPage = DashboardScreen(
            userName: decodedToken['username'] ?? 'Responsable',
            userRole: "ROLE_DASHBOARD_VIEWER",
          );
        } else {
          _showSnackBar('Rôle utilisateur inconnu.');
          return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      } else {
        String errorMessage =
            'Échec de la connexion. Veuillez vérifier vos informations d\'identification.';
        try {
          final Map<String, dynamic> errorData = jsonDecode(response.body);
          if (errorData.containsKey('message')) {
            errorMessage = errorData['message'];
          }
        } catch (e) {
          //
        }
        _showSnackBar(errorMessage);
      }
    } catch (error) {
      _showSnackBar('Une erreur s\'est produite lors de la connexion.');
      print("AUTH ERROR -------------------------");
      print(error);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: attijariTheme.scaffoldBackgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
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
                  style: attijariTheme.textTheme.titleLarge,
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  style: attijariTheme.textTheme.bodyMedium,
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  style: attijariTheme.textTheme.bodyMedium,
                  controller: _passwordController,
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Se connecter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: attijariTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 🎨 Background dégradé subtil
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF7F7F7), Color(0xFFECECEC)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // 📦 Contenu principal avec Card stylée
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white.withOpacity(0.95),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // 🦸 Hero animation logo
                        Hero(
                          tag: 'attijariLogo',
                          child: const Image(
                            height: 80,
                            image: AssetImage("assets/images/attijariLogo.png"),
                          ),
                        ),
                        const SizedBox(height: 48.0),
                        Text(
                          'Bienvenue',
                          textAlign: TextAlign.center,
                          style: attijariTheme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 24.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          style: attijariTheme.textTheme.bodyMedium,
                          controller: _usernameController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          style: attijariTheme.textTheme.bodyMedium,
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 32.0),
                        // 🔘 Bouton amélioré
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: attijariWhite,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _login,
                          child: const Text('Se connecter'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
