import 'package:flutter/material.dart';

class CommonListTile extends StatelessWidget {
  final String? title;
  final String? details;
  const CommonListTile({Key? key, this.title, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.3),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(
          title ?? '',
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          details ?? '',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
