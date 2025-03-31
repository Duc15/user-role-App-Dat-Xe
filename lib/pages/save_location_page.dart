// import 'package:flutter/material.dart';
// import 'package:users_app/models/prediction_model.dart';

// class PredictionPlaceUI extends StatelessWidget {
//   final PredictionModel predictedPlaceData;
//   final VoidCallback? onSelect;

//   const PredictionPlaceUI({
//     Key? key,
//     required this.predictedPlaceData,
//     this.onSelect,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: const Icon(
//         Icons.location_on,
//         color: Colors.blue,
//       ),
//       title: Text(
//         predictedPlaceData.placeId,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//         overflow: TextOverflow.ellipsis,
//       ),
//       subtitle: Text(
//         predictedPlaceData.placeName,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Colors.grey,
//         ),
//         overflow: TextOverflow.ellipsis,
//       ),
//       onTap: onSelect,
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// // class SavedPlacesPage extends StatelessWidget {
// //   final List<Map<String, dynamic>> savedPlaces;

// //   const SavedPlacesPage({super.key, required this.savedPlaces});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Địa Chỉ Đã Lưu"),
// //       ),
// //       body: savedPlaces.isEmpty
// //           ? const Center(child: Text("Không có địa chỉ nào đã lưu"))
// //           : ListView.builder(
// //               itemCount: savedPlaces.length,
// //               itemBuilder: (context, index) {
// //                 return ListTile(
// //                   title: Text(savedPlaces[index]['placeName']),
// //                   subtitle: Text(savedPlaces[index]['placeAddress']),
// //                   onTap: () {
// //                     // Trả về địa điểm đã chọn
// //                     Navigator.pop(context, savedPlaces[index]['placeName']);
// //                   },
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }
