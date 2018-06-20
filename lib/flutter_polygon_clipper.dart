import 'dart:math';

import 'package:flutter/material.dart';

class ClipPolygon extends StatelessWidget {
  final Widget child;
  final int vertices;
  final double rotate;
  final double borderRadius;

  ClipPolygon({
    @required this.child,
    @required this.vertices,
    this.rotate: 0.0,
    this.borderRadius: 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: 1.0,
      child: new ClipPath(
        clipper: new Polygon(
          vertices: vertices < 3 ? 3 : vertices,
          rotate: rotate,
          borderRadiusAngle: borderRadius,
        ),
        child: child,
      ),
    );
  }
}

class Polygon extends CustomClipper<Path> {
  final int vertices;
  final double rotate;
  final double borderRadiusAngle;
  final double halfBRAngle;

  Polygon({@required this.vertices, this.rotate, this.borderRadiusAngle})
      : halfBRAngle = borderRadiusAngle / 2;

  @override
  Path getClip(Size size) {
    final anglePerSide = 360 / vertices;

    final radius = (size.width - borderRadiusAngle) / 2;
    final arcLength = (radius * _angleToRadian(borderRadiusAngle)) + (vertices * 2);

    Path path = new Path();

    for (var i = 0; i <= vertices; i++) {
      double currentAngle = anglePerSide * i;
      bool isFirst = i == 0;

      if (borderRadiusAngle > 0) {
        _drawLineAndArc(path, currentAngle, radius, arcLength, isFirst);
      } else {
        _drawLine(path, currentAngle, radius, isFirst);
      }
    }

    return path;
  }

  _drawLine(Path path, double currentAngle, double radius, bool move) {
    Offset current = _getOffset(currentAngle, radius);

    if (move)
      path.moveTo(current.dx, current.dy);
    else
      path.lineTo(current.dx, current.dy);
  }

  _drawLineAndArc(Path path, double currentAngle, double radius, double arcLength, bool isFirst) {
    double prevAngle = currentAngle - halfBRAngle;
    double nextAngle = currentAngle + halfBRAngle;

    Offset previous = _getOffset(prevAngle, radius);
    Offset next = _getOffset(nextAngle, radius);

    if (isFirst) {
      path.moveTo(next.dx, next.dy);
    } else {
      path.lineTo(previous.dx, previous.dy);
      path.arcToPoint(next, radius: new Radius.circular(arcLength));
    }
  }

  double _angleToRadian(double angle) {
    return angle * (pi / 180);
  }

  Offset _getOffset(double angle, double radius) {
    final rotationAwareAngle = angle - 90 + rotate;

    final radian = _angleToRadian(rotationAwareAngle);
    final x = cos(radian) * radius + radius + halfBRAngle;
    final y = sin(radian) * radius + radius + halfBRAngle;

    return new Offset(x, y);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}