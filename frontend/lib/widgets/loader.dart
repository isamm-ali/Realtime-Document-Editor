import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Text('Please wait!'),
          SizedBox(height: 5,),
          CircularProgressIndicator(),
        ],
      )
    );
  }
}