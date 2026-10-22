import 'package:flutter/material.dart';

class DiscountRibbon extends StatelessWidget {
  final String topText;
  final String bottomText;

  const DiscountRibbon({
    super.key,
    required this.topText,
    required this.bottomText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RibbonPainter(),
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              topText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              bottomText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFFFD700), // yellow
                fontSize: 16,
                fontWeight: FontWeight.w800,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RibbonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFE50914); // red background
    final path = Path();

    // Top rectangle with inward V-cut bottom
    path.moveTo(0, 0); // top-left
    path.lineTo(size.width, 0); // top-right
    path.lineTo(size.width, size.height); // bottom-right
    path.lineTo(size.width / 2 + 10, size.height - 15); // right of center notch
    path.lineTo(size.width / 2 - 10, size.height - 15); // left of center notch
    path.lineTo(0, size.height); // bottom-left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
