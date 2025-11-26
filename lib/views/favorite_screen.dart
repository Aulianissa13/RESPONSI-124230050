import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/favorite_controller.dart';
import '../../models/space.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: Consumer<FavoriteController>(
        builder: (context, favController, child) {
          final favorites = favController.favorites;

          if (favorites.isEmpty) {
            return const Center(child: Text("Belum ada Amiibo favorit"));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final space = favorites[index];
              final id = space.id;
              final title = space.title;
              return Dismissible (
                key: Key(Space (id: id, title: title).id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  favController.removeFavorite(space);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${space.title} dihapus dari favorit')),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}