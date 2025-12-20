import 'package:flutter/material.dart';

class EvaluationWidget extends StatelessWidget {
  final String title;
  final List<String> advantages;
  final List<String> limitations;

  const EvaluationWidget({
    super.key,
    required this.title,
    required this.advantages,
    required this.limitations,
  });

  @override
  Widget build(BuildContext context) {
    // Find the max length to ensure even distribution
    int itemCount = advantages.length > limitations.length
        ? advantages.length
        : limitations.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        // We use a Stack so we can layer the "VS" circle on top of the Row
        Stack(
          alignment: Alignment.center, // This centers the badge perfectly
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Advantages Column
                Expanded(
                  child: _buildColumn(
                    title: 'Advantages',
                    items: advantages,
                    color: Colors.green.shade50,
                    accentColor: Colors.green.shade700,
                    icon: Icons.check_circle_outline,
                  ),
                ),
                const SizedBox(width: 12), // This gap is where the badge sits
                // Limitations Column
                Expanded(
                  child: _buildColumn(
                    title: 'Limitations',
                    items: limitations,
                    color: Colors.red.shade50,
                    accentColor: Colors.red.shade700,
                    icon: Icons.highlight_off,
                  ),
                ),
              ],
            ),

            // --- THE VS BADGE ---
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'VS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildColumn({
    required String title,
    required List<String> items,
    required Color color,
    required Color accentColor,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          // List Items
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: items.map((item) {
                if (item.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: accentColor, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
