import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  final bool isTask1;
  final Function(bool) onToggle;

  const ToggleSwitch({
    super.key,
    required this.isTask1,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Task 2"),
        Switch(
          value: isTask1,
          onChanged: onToggle,
          activeColor: Colors.blue,
          inactiveThumbColor: const Color.fromARGB(255, 255, 255, 255),
          inactiveTrackColor: const Color.fromARGB(255, 156, 9, 39),
        ),
        const Text("Task 1"),
      ],
    );
  }
}
