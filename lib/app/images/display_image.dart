// import 'package:flutter/material.dart';
//
// import '../../redundant/articles/articles_helper_methods/firebase_methods.dart';
//
// import '../custom_widgets/loading_error/custom_progress_indicator.dart';
//
// class DisplayImage extends StatefulWidget {
//   const DisplayImage(
//     this.image, {
//     this.padding,
//     super.key,
//   });
//
//   final String image;
//   final double? padding;
//
//   @override
//   State<DisplayImage> createState() => _DisplayImageState();
// }
//
// class _DisplayImageState extends State<DisplayImage> {
//   late final Future<String?> _imageFuture;
//
//   @override
//   void initState() {
//     _imageFuture = getImage(widget.image);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return FutureBuilder<String?>(
//         future: _imageFuture,
//         builder: (context, snapshot) {
//           final url = snapshot.data;
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//               return Padding(
//                   padding: widget.padding != null
//                       ? EdgeInsets.all(size.width * widget.padding!)
//                       : EdgeInsets.zero,
//                   child: Image.network(
//                     url.toString(),
//                     loadingBuilder: (context, child, progress) {
//                       if (progress == null) {
//                         return child;
//                       }
//                       return SizedBox(
//                         width: size.width,
//                         height: size.width,
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             value: progress.cumulativeBytesLoaded /
//                                 progress.expectedTotalBytes!,
//                           ),
//                         ),
//                       );
//                     },
//                   ));
//             } else {
//               return Image.asset('assets/images/image_not_found.png');
//             }
//           }
//           return const CustomProgressIndicator();
//         });
//   }
// }
