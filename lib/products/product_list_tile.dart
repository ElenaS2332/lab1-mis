import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.name,
    required this.onSelectTap,
  });
  final String name;
  final VoidCallback onSelectTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(fontSize: 20),
        ),
        onTap: onSelectTap,
        tileColor: Colors.purple.shade300,
      ),
    );
  }
}
