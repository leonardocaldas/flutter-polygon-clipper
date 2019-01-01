import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class PolygonPathDrawer {
  final Path path;
  final Size size;
  final PolygonPathSpecs specs;

  PolygonPathDrawer({
    @required this.size,
    @required this.specs,
  }) : path = Path();

  Path draw() {
    final anglePerSide = 360 / specs.sides;

    final radius = (size.width - specs.borderRadiusAngle) / 2;
    final arcLength =
        (radius * _angleToRadian(specs.borderRadiusAngle)) + (specs.sides * 2);

    Path path = Path();

    for (var i = 0; i <= specs.sides; i++) {
      double currentAngle = anglePerSide * i;
      bool isFirst = i == 0;

      if (specs.borderRadiusAngle > 0) {
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

  _drawLineAndArc(Path path, double currentAngle, double radius,
      double arcLength, bool isFirst) {
    double prevAngle = currentAngle - specs.halfBorderRadiusAngle;
    double nextAngle = currentAngle + specs.halfBorderRadiusAngle;

    Offset previous = _getOffset(prevAngle, radius);
    Offset next = _getOffset(nextAngle, radius);

    if (isFirst) {
      path.moveTo(next.dx, next.dy);
    } else {
      path.lineTo(previous.dx, previous.dy);
      path.arcToPoint(next, radius: Radius.circular(arcLength));
    }
  }

  double _angleToRadian(double angle) {
    return angle * (pi / 180);
  }

  Offset _getOffset(double angle, double radius) {
    final rotationAwareAngle = angle - 90 + specs.rotate;

    final radian = _angleToRadian(rotationAwareAngle);
    final x = cos(radian) * radius + radius + specs.halfBorderRadiusAngle;
    final y = sin(radian) * radius + radius + specs.halfBorderRadiusAngle;

    return Offset(x, y);
  }
}

class PolygonPathSpecs {
  final int sides;
  final double rotate;
  final double borderRadiusAngle;
  final double halfBorderRadiusAngle;

  PolygonPathSpecs({
    @required this.sides,
    @required this.rotate,
    @required this.borderRadiusAngle,
  }) : halfBorderRadiusAngle = borderRadiusAngle / 2;
}
