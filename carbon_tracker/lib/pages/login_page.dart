import 'package:flutter/material.dart';
import 'welcome_page.dart';


// Login page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage(title: 'Welcome User!')),
                );
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to registration page
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}