import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi_app/views/main_screen.dart';
import '../controllers/auth_controller.dart';
import 'register_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fastfood, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              const Text(
                "Food Recipe App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () async {
                    final user = _usernameController.text;
                    final pass = _passwordController.text;

                    if (user.isNotEmpty && pass.isNotEmpty) {
                      // Login dengan validasi data register
                      bool success = await Provider.of<AuthController>(context, listen: false)
                          .login(user, pass);

                      if (success && mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainScreen()),
                        );
                      } else if (mounted) {
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Failed! Check Username/Password or Register first.")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields!")),
                      );
                    }
                  },
                  child: const Text("LOGIN", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 15),
              // Tombol menuju halaman Register
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: const Text("Don't have an account? Register here"),
              )
            ],
          ),
        ),
      ),
    );
  }
}