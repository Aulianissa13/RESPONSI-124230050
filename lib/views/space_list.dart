// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controllers/api_controller.dart';
// import 'detail_screen.dart';

// class MealsPage extends StatefulWidget {
//   final String category;
//   const MealsPage({super.key, required this.category});

//   @override
//   State<MealsPage> createState() => _MealsPageState();
// }

// class _MealsPageState extends State<MealsPage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<SpaceController>(context, listen: false)
//           .fetchSpaceByCategory(widget.category);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("${widget.category} Meals")),
//       body: Consumer<SpaceController>(
//         builder: (context, controller, child) {
//           if (controller.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (controller.Space.isEmpty) {
//             return const Center(child: Text("No found"));
//           }

//           // Grid View 2 Kolom
//           return GridView.builder(
//             padding: const EdgeInsets.all(10),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.8,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//             ),
//             itemCount: controller.space.length,
//             itemBuilder: (context, index) {
//               final meal = controller.space[index];
//               return Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => DetailPage(SpaceId: space.id),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//                           child: Image.network(meal.thumbnail, fit: BoxFit.cover, width: double.infinity),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           meal.name,
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }