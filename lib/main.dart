import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi_app/views/main_screen.dart';
import 'controllers/api_controller.dart';
import 'controllers/favorite_controller.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Ganti Service menjadi Controller
        ChangeNotifierProvider(create: (_) => SpaceController()),
        ChangeNotifierProvider(create: (_) => FavoriteController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nintendo Amiibo App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          useMaterial3: false,
        ),
        home: const MainScreen(),
      ),
    );
  }
}