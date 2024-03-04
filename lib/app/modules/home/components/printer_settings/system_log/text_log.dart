import 'package:flutter/material.dart';
import 'package:flutter_printer/app/data/models/log_model.dart';

class TextLog extends StatelessWidget {
  final LogModel data;
  const TextLog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Color color = data.title == 'INFO'
        ? Colors.blue
        : data.title == 'IN_PROGRESS'
            ? Colors.orange
            : data.title == 'SUCCESS'
                ? Colors.green
                : Colors.red;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '[${data.title}] : ${data.status}',
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
