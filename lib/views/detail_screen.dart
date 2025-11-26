import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/api_controller.dart';
import '../../models/space.dart';
import '../../controllers/favorite_controller.dart';


class DetailPage extends StatefulWidget {
  final String mealId;
  const DetailPage({super.key, required this.SpaceId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SpaceController>(context, listen: false)
          .fetchSpaceDetail(widget.SpaceId);
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Cannot launch URL")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
        actions: [
          Consumer<SpaceController>(
            builder: (context, controller, _) {
              final space = controller.detailSpace;
              if (space == null) return const SizedBox();
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Share.share(
                      " ${Space.url}! Read more..: ${Space.url}");
                },
              );
            },
          )
        ],
      ),
      body: Consumer<SpaceController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final space = controller.detailSpace;
          if (space == null)
            return const Center(child: Text("Detail not found"));

          return SingleChildScrollView(
            padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 80), // Bottom padding extra untuk FAB
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Animation
                Hero(
                  tag: widget.mealId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      space.imageUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  Space.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${space.news_site} | ${space.publishedAt}",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const Divider(height: 30),
                const Text(
                  "Deskripsi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  space.instructions ?? "",
                  style: const TextStyle(height: 1.5),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                if (space.url != null && space.url!.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12)),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Read More.."),
                      onPressed: () => _launchUrl(space.url!),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
