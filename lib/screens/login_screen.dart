import 'package:flutter/material.dart';
import 'package:travel_mobile/screens/sign_up_screen.dart';
import 'package:travel_mobile/screens/tabs_screen.dart'; // Import the TabsScreen
import 'package:shared_preferences/shared_preferences.dart';

import '../models/trip.dart';

class LoginScreen extends StatefulWidget {
  static const screenRoute = '/Log_in';
  final List<Trip> favoriteTrips;
  bool logedin = false;
  LoginScreen(this.favoriteTrips, {Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences _prefs;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // Check if user is already logged in
    setState(() {
      widget.logedin = _prefs.getBool('logedin') ?? false;
    });
  }
  List<Trip> favoriteTrips = [];
  Future<void> savePrefs() async {
    await _prefs.setString('name', _nameController.text);
    await _prefs.setString('password', _passwordController.text);
    // Update the value of logedin to true
    await _prefs.setBool('logedin', true);
    setState(() {
      widget.logedin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle logInStyle = ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor,
      shadowColor: Colors.amber,
    );

    if (widget.logedin) {

      return TabsScreen(favoriteTrips); // Assuming TabsScreen is correctly implemented
    } else {
      // If user is not logged in, return the login screen
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('تسجيل الدخول'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person, color: Colors.amber),
                  hintText: 'ماهوا اسم شهرتك',
                  labelText: 'الإسم',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.amber),
                  hintText: 'ما هي كلمة السر الخاصة بك',
                  labelText: 'الرقم السري',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: logInStyle,
                onPressed: () async {
                  await savePrefs();
                  Navigator.of(context).pushReplacementNamed('/tabs_screen');
                },
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: logInStyle,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignUpScreen.screenRoute);
                },
                child: Text('     التسجيل     ',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
