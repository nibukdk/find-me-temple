// import 'dart:async';

// import 'package:church/provider/search_places_provider.dart';
// import 'package:church/screens/search/local_widget/search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class SearchPageScreen extends StatefulWidget {
//   const SearchPageScreen({Key? key}) : super(key: key);

//   @override
//   _SearchPageScreenState createState() => _SearchPageScreenState();
// }

// class _SearchPageScreenState extends State<SearchPageScreen> {
//   late TextEditingController _searchFormController;

//   late FocusNode _searchFormFocusNode;

//   @override
//   void initState() {
//     super.initState();
//     _searchFormController = TextEditingController();
//     _searchFormFocusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     _searchFormController.dispose();
//     _searchFormFocusNode.dispose();
//   }

//   void onSearchFormChange(
//     String val,
//   ) {
//     if (val.isNotEmpty) {
//       // Timer(const Duration(seconds: 2), () => autoCompleteSearch(val));
//       // autoCompleteSearch(val);
//       print(val);
//     }
//   }

//   void nearByTemples(
//       String val, SearchPlacesProvider searchPlacesProvider) async {
//     if (val.isNotEmpty) {
//       Timer(Duration(seconds: 2),
//           () => searchPlacesProvider.getNearyByPlaces(27.680990, 84.394840));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final SearchPlacesProvider searchPlacesProvider =
//         Provider.of<SearchPlacesProvider>(context);
//     return Listener(
//       onPointerDown: (PointerDownEvent event) =>
//           FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => GoRouter.of(context).pop(),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: SerachBar(
//                   _searchFormController, _searchFormFocusNode, nearByTemples),
//             ),
//             const SizedBox(
//               width: 20,
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: const [
//               Center(
//                 child: Text("Search Page"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
