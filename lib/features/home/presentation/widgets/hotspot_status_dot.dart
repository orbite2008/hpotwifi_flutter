import 'package:flutter/material.dart';

class HotspotStatusDot extends StatelessWidget {
  const HotspotStatusDot({super.key, required this.color, this.size = 14});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
