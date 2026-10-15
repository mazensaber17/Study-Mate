import 'package:flutter/material.dart';

class OnboardingNewsIcon extends StatelessWidget {
  const OnboardingNewsIcon({
    super.key,
    required this.color,
    this.size = 46,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _NewsIconPainter(color: color),
    );
  }
}

class _NewsIconPainter extends CustomPainter {
  const _NewsIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;

    // Outer rounded card
    final rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w / 2, h / 2),
        width: w * 0.82,
        height: h * 0.82,
      ),
      Radius.circular(w * 0.18),
    );
    canvas.drawRRect(rrect, strokePaint);

    // Inner horizontal news strips
    final lines = [0.38, 0.50, 0.62];
    for (final ratio in lines) {
      canvas.drawLine(
        Offset(w * 0.26, h * ratio),
        Offset(w * 0.74, h * ratio),
        strokePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _NewsIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class OnboardingSparkleIcon extends StatelessWidget {
  const OnboardingSparkleIcon({
    super.key,
    required this.color,
    this.size = 46,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SparkleIconPainter(color: color),
    );
  }
}

class _SparkleIconPainter extends CustomPainter {
  const _SparkleIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;
    final double cy = h / 2;

    final double top = h * 0.10;
    final double bottom = h * 0.90;
    final double left = w * 0.10;
    final double right = w * 0.90;

    // Four-point concave star
    final path = Path()
      ..moveTo(cx, top)
      ..quadraticBezierTo(cx, cy, right, cy)
      ..quadraticBezierTo(cx, cy, cx, bottom)
      ..quadraticBezierTo(cx, cy, left, cy)
      ..quadraticBezierTo(cx, cy, cx, top)
      ..close();

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _SparkleIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class OnboardingCheckIcon extends StatelessWidget {
  const OnboardingCheckIcon({
    super.key,
    required this.color,
    this.size = 46,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CheckIconPainter(color: color),
    );
  }
}

class _CheckIconPainter extends CustomPainter {
  const _CheckIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;

    final path = Path()
      ..moveTo(w * 0.28, h * 0.52)
      ..lineTo(w * 0.44, h * 0.68)
      ..lineTo(w * 0.74, h * 0.34);

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _CheckIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
