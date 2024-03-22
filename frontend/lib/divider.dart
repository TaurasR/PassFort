import 'package:flutter/material.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.white,
              thickness: 2,
              endIndent: 10,
              indent: 35,
            ),
          ),
          Text(
            'Arba',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Expanded(
            child: Divider(
              color: Colors.white,
              thickness: 2,
              indent: 10,
              endIndent: 35,
            ),
          ),
        ],
      ),
    );
  }
}
