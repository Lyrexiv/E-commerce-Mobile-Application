import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_mobile_application/services/auth_service.dart';
import 'package:ecommerce_mobile_application/Models/user.dart';
import 'package:ecommerce_mobile_application/Views/Login&Register/Register/Register.dart';

import '../../../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    User user = User(
      username: _usernameController.text,
      password: _passwordController.text,
    );

    try {
      AuthResponse response = await AuthAPI().login(user);

      if (response.success) {
        final prefs = await SharedPreferences.getInstance();
        if (response.userId != null) {
          await prefs.setInt('user_id', response.userId! as int);
        }


        prefs.setString('username', user.username);
        prefs.setBool('isLoggedIn', true);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter App')),
              (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter App')),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Welcome back!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Text('Đăng nhập'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
