import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameSection extends StatelessWidget {
  final String url;
  final String name;
  final int playtimeForever;

  const GameSection(
      {Key? key,
      required this.url,
      required this.name,
      required this.playtimeForever})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat('#,##0');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Color(0xFF1F3748),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            url,
            width: 120,
            height: 60,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "${formatter.format(playtimeForever / 60)} horas registradas",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
