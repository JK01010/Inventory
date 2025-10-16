import 'package:flutter/material.dart';

class AppDottedBorderContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius borderRadius;
  final Color color;
  final double strokeWidth;
  final double gap;
  final BoxDecoration? childDecoration;
  final EdgeInsetsGeometry? childPadding;
  const AppDottedBorderContainer({
    super.key,
    this.width,
    this.height,
    this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.color = Colors.grey,
    this.strokeWidth = 1.5,
    this.gap = 5.0,
    this.childDecoration,
    this.childPadding,
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        gap: gap,
        borderRadius: borderRadius,
      ),
      child: Container(
        width: width,
        height: height,
        padding: childPadding,
        decoration: childDecoration,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final BorderRadius borderRadius;
  _DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.borderRadius,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;
    final path = Path()..addRRect(borderRadius.toRRect(rect));
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + gap);
        canvas.drawPath(extractPath, paint);
        distance += gap * 2;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
