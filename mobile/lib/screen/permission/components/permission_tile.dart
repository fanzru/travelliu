import 'package:flutter/material.dart';

class PermissionTile extends StatelessWidget {
  bool isActive = false;
  final String title, description;

  PermissionTile(
      {Key? key,
      required this.title,
      required this.description,
      this.isActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          isActive
              ? const Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Icon(
                  Icons.priority_high,
                  color: Colors.yellow[700],
                )
        ],
      ),
    );
  }
}
