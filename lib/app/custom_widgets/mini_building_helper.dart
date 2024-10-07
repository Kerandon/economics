
import 'package:flutter/material.dart';

import '../enums/firebase_status.dart';

class MiniBuilderHelper extends StatefulWidget {
  const MiniBuilderHelper(
      {super.key, required this.future, required this.onComplete});

  final Future<dynamic> future;
  final Function(FirebaseStatus) onComplete;

  @override
  State<MiniBuilderHelper> createState() => _MiniBuilderHelperState();
}

class _MiniBuilderHelperState extends State<MiniBuilderHelper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error == true) {
              widget.onComplete.call(FirebaseStatus.error);
              return const SizedBox.shrink();
            }
            if (snapshot.hasData) {
              widget.onComplete.call(FirebaseStatus.success);
              Navigator.pop(context);
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
