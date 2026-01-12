import 'package:flutter/material.dart';
import 'package:learningapp/pages/videoPlayBack.dart';
import 'package:learningapp/widgets/customAppBar.dart';

class UnitsPage extends StatelessWidget {
  final String unitName;
  const UnitsPage({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    final List<RoadmapUnit> units = [
      RoadmapUnit("Chapter 1", UnitStatus.completed, const Color(0xFF58CC02)),
      RoadmapUnit("Chapter 2", UnitStatus.completed, const Color(0xFF58CC02)),
      RoadmapUnit("Chapter 3", UnitStatus.current, const Color(0xFFFFC800)),
      RoadmapUnit("Chapter 4", UnitStatus.locked, const Color(0xFF8B7355)),
      RoadmapUnit("Chapter 5", UnitStatus.locked, const Color(0xFF8B7355)),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: Customappbar(title: unitName),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return PathNode(
                  unit: units[index],
                  isLeft: index % 2 == 0,
                  isFirst: index == 0,
                  isLast: index == units.length - 1,
                );
              }, childCount: units.length),
            ),
          ),
        ],
      ),
    );
  }
}

enum UnitStatus { completed, current, locked }

class RoadmapUnit {
  final String title;
  final UnitStatus status;
  final Color themeColor;

  RoadmapUnit(this.title, this.status, this.themeColor);
}

class PathNode extends StatelessWidget {
  final RoadmapUnit unit;
  final bool isLeft;
  final bool isFirst;
  final bool isLast;

  const PathNode({
    super.key,
    required this.unit,
    required this.isLeft,
    required this.isFirst,
    required this.isLast,
  });

  Color get primaryColor {
    if (unit.status == UnitStatus.locked) {
      return const Color(0xFF5A5A6E);
    }
    return unit.themeColor;
  }

  Color get borderColor {
    if (unit.status == UnitStatus.locked) {
      return const Color(0xFF3A3A48);
    }
    return unit.themeColor;
  }

  IconData get icon {
    switch (unit.status) {
      case UnitStatus.completed:
        return Icons.emoji_events;
      case UnitStatus.current:
        return Icons.play_arrow;
      case UnitStatus.locked:
        return Icons.lock;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: isLast ? 200 : 220,
      child: CustomPaint(
        size: Size(screenWidth, isLast ? 200 : 220),
        painter: PathPainter(
          isLeft: isLeft,
          isFirst: isFirst,
          isLast: isLast,
          pathColor: unit.status == UnitStatus.locked
              ? const Color(0xFF3A3A48)
              : const Color(0xFF4A4A5E),
        ),
        child: Stack(
          children: [
            Positioned(
              left: isLeft ? 40 : screenWidth - 120,
              top: 40,
              child: GestureDetector(
                onTap: unit.status == UnitStatus.locked
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return Videoplayback();
                            },
                          ),
                        );
                      },
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor, width: 6),
                        boxShadow: unit.status != UnitStatus.locked
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(icon, color: Colors.white, size: 36),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 120,
                      child: Text(
                        unit.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: unit.status == UnitStatus.locked
                              ? const Color(0xFF5A5A6E)
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final bool isLeft;
  final bool isFirst;
  final bool isLast;
  final Color pathColor;

  PathPainter({
    required this.isLeft,
    required this.isFirst,
    required this.isLast,
    required this.pathColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = pathColor
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Starting point (center of current node)
    final startX = isLeft ? 80.0 : size.width - 80;
    final startY = 80.0;

    if (!isLast) {
      // Ending point (center of next node)
      final endX = isLeft ? size.width - 80 : 80.0;
      final endY = 300.0;

      // Calculate control points for smooth S-curve
      final midY = (startY + endY) / 2;

      path.moveTo(startX, startY);
      path.cubicTo(startX, startY + 60, endX, endY - 80, endX, endY);

      canvas.drawPath(path, paint);

      // Draw dots along the path for style
      final dotPaint = Paint()
        ..color = pathColor.withOpacity(0.4)
        ..style = PaintingStyle.fill;

      for (double t = 0.2; t < 1.0; t += 0.15) {
        final point = _getPointOnCubicBezier(
          startX,
          startY,
          startX,
          startY + 60,
          endX,
          endY - 80,
          endX,
          endY,
          t,
        );
        canvas.drawCircle(point, 4, dotPaint);
      }
    }
  }

  Offset _getPointOnCubicBezier(
    double x0,
    double y0,
    double x1,
    double y1,
    double x2,
    double y2,
    double x3,
    double y3,
    double t,
  ) {
    final u = 1 - t;
    final tt = t * t;
    final uu = u * u;
    final uuu = uu * u;
    final ttt = tt * t;

    final x = uuu * x0 + 3 * uu * t * x1 + 3 * u * tt * x2 + ttt * x3;
    final y = uuu * y0 + 3 * uu * t * y1 + 3 * u * tt * y2 + ttt * y3;

    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
