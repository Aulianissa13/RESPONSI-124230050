import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi_app/views/main_screen.dart';
import 'controllers/auth_controller.dart';
import 'controllers/api_controller.dart';
import 'views/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Load Auth Status saat aplikasi dimulai
        ChangeNotifierProvider(
            create: (_) => AuthController()..checkLoginStatus()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Responsi Space App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 1,
              centerTitle: true),
        ),
        // Logic menentukan halaman awal
        home: Consumer<AuthController>(
          builder: (context, auth, child) {
            // Jika sudah login -> CategoriesPage, Jika belum -> LoginPage
            return auth.isLoggedIn ? const MainScreen() : const LoginPage();
          },
        ),
      ),
    );
  }
}
