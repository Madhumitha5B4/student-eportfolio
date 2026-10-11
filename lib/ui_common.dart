import 'package:flutter/material.dart';

/// Rounded shape used by every card so the whole app looks consistent.
const RoundedRectangleBorder kCardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(18)),
);

/// Keeps page content in a centred column so it looks right on wide screens
/// (browser / desktop) as well as on phones.
class CenteredPage extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const CenteredPage({super.key, required this.child, this.maxWidth = 700});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

/// Soft gradient background with decorative circles, shared by all pages.
class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8EAF6), Color(0xFFEDE7F6), Color(0xFFE1F5FE)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: CustomPaint(painter: _BgPainter())),
          child,
        ],
      ),
    );
  }
}

class _BgPainter extends CustomPainter {
  const _BgPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    void circle(double dx, double dy, double r, Color c) {
      p.color = c;
      canvas.drawCircle(Offset(size.width * dx, size.height * dy), r, p);
    }

    circle(0.05, 0.06, 120, const Color(0x223F51B5));
    circle(0.95, 0.12, 80, const Color(0x229C27B0));
    circle(0.88, 0.55, 140, const Color(0x1A00ACC1));
    circle(0.08, 0.72, 100, const Color(0x1AE91E63));
    circle(0.70, 0.95, 120, const Color(0x223F51B5));
    circle(0.30, 0.40, 40, const Color(0x143F51B5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
