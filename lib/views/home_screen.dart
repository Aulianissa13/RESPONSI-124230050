// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:responsi_app/models/space.dart';
// import '../../controllers/api_controller.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<SpaceController>(context, listen: false).fetchspaceList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(' List'),
//         centerTitle: true,
//       ),
//       body: Consumer<SpaceController>(
//         builder: (context, controller, child) {
          
//           // 1. Cek Loading
//           if (controller.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // 2. Cek Error
//           if (controller.errorMessage.isNotEmpty) {
//             return Center(child: Text(controller.errorMessage));
//           }

//           // 3. Cek Data Kosong
//           if (controller.space.isEmpty) {
//             return const Center(child: Text("Tidak ada data ditemukan"));
//           }

//           // 4. Tampilkan Data
//           return ListView.builder(
//             itemCount: controller.space.length,
//             itemBuilder: (context, index) {
//               return Space(space: controller.space[index]);
//             },
//           );
//         },
//       ),
//     );
//   }
// }