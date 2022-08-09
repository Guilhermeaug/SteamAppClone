import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  final String description;

  const SectionDivider({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).dividerColor,
      height: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          description,
          style: const TextStyle(
            color: Colors.blueGrey,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
