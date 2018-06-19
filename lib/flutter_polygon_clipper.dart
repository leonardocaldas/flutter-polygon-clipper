import 'dart:math';

import 'package:flutter/material.dart';

class ClipPolygon extends StatelessWidget {
  final Widget child;
  final int vertices;
  final double rotate;
  final double borderRadius;

  ClipPolygon({@required this.child, @required this.vertices, this.rotate, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: 1.0,
      child: new ClipPath(
        clipper: new Polygon(
          vertices: vertices < 3 ? 3 : vertices,
          rotate: rotate == null ? 0.0 : rotate,
          borderRadius: borderRadius == null ? 0.0 : borderRadius,
        ),
        child: child,
      ),
    );
  }
}

class Polygon extends CustomClipper<Path> {
  final int vertices;
  final double rotate;
  final double borderRadius;

  Polygon({@required this.vertices, this.rotate, this.borderRadius});

  @override
  Path getClip(Size size) {
    final anglePerSide = 360 / vertices;
    final radius = size.width / 2;

    Path path = new Path();

    for (var i = 0; i <= vertices; i++) {
      final angle = anglePerSide * i - 90 + rotate;
      final radian = angle * (pi / 180);
      final x = roundOffset(radius + cos(radian) * radius);
      final y = roundOffset(radius + sin(radian) * radius);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

double roundOffset(double value) {
  return double.parse(value.toStringAsFixed(3));
}
