import 'package:flutter/material.dart';


class CustomListTile extends StatelessWidget {
  final Widget child;
  const CustomListTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(),
        boxShadow: const [
          BoxShadow(
            offset: Offset(3, 3),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
