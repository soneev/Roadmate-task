import 'package:flutter/material.dart';

// class CircleTabBarIndicator extends Decoration {
//   final Color color;
//   double radius;
//   CircleTabBarIndicator({required this.color, required this.radius});

//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _CirclePainter(radius: radius, color: color);
//   }
// }

// class _CirclePainter extends BoxPainter {
//   final double radius;
//   late Color color;

//   _CirclePainter({required this.radius, required this.color});
//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
//     late Paint _paint;
//     _paint = Paint()..color = color;
//     final Offset circleOffset =
//         offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
//     canvas.drawCircle(circleOffset, radius, _paint);
//   }
// }

import 'package:flutter/material.dart';

class CircleTabIndicator extends Decoration {
  final double radius;
  final Color color;

  CircleTabIndicator({required this.radius, required this.color});

  @override
  _CirclePainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(radius: radius, color: color);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  final Color color;

  _CirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Paint paint = Paint()..color = color;
    final Rect rect = offset & cfg.size!;
    final double centerY = rect.center.dy;
    final double indicatorY = rect.bottom - radius;

    canvas.drawCircle(
      Offset(rect.center.dx, indicatorY),
      radius,
      paint,
    );
  }
}
