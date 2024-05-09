import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  static const screenRoute = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SharedPreferences _prefs;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> savePrefs() async {
    await _prefs.setString('name', _nameController.text);
    await _prefs.setString('email', _emailController.text);
    await _prefs.setString('password', _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle signUpStyle = ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor,
      shadowColor: Colors.amber,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('إنشاء حساب جديد'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'إنشاء حساب جديد',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person, color: Colors.amber),
                hintText: 'ماهوا اسمك',
                labelText: 'الإسم',
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email, color: Colors.amber),
                hintText: 'ماهو بريدك الإلكتروني',
                labelText: 'البريد الإلكتروني',
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
              style: signUpStyle,
              onPressed: () async {
                await savePrefs();
                Navigator.of(context).pushReplacementNamed('/tabs_screen');
              },
              child: const Text(
                'إنشاء الحساب',
                style: TextStyle(color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
