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
          borderRadius: borderRadius,
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
    final insideAngles = 360 / vertices;
    final outsideAngles = 180 - insideAngles;
    Offset offsetCut = _getBorderRadiusCut(borderRadius, outsideAngles);

    final radius = size.width / 2;

    Path path = new Path();

    for (var i = 0; i <= vertices; i++) {
      double fullAngle = insideAngles * i;
      int quadrant = _getQuadrant(fullAngle);
      Offset offset = _getOffset(fullAngle, rotate, radius);

      Offset forward = _getOffsetForward(offset, offsetCut, quadrant);
      Offset backward = _getOffsetBackward(offset, offsetCut, quadrant);

      if (i == 0) {
        path.moveTo(forward.dx, forward.dy);
      } else {
        path.lineTo(backward.dx, backward.dy);
        path.arcToPoint(forward, radius: new Radius.circular(10.0));
      }
    }

    return path;
  }

  Offset _getOffsetForward(Offset offset, Offset cut, int quadrant) {
    double dx = offset.dx, dy = offset.dy;

    dx += quadrant == 1 || quadrant == 2 ? -cut.dx : cut.dx;
    dy += quadrant == 2 || quadrant == 3 ? cut.dy : -cut.dy;

    return new Offset(dx, dy);
  }

  Offset _getOffsetBackward(Offset offset, Offset cut, int quadrant) {
    double dx = offset.dx, dy = offset.dy;

    dx += quadrant == 1 || quadrant == 2 ? cut.dx : -cut.dx;
    dy += quadrant == 2 || quadrant == 3 ? -cut.dy : cut.dy;

    return new Offset(dx, dy);
  }

  int _getQuadrant(double angle) {
    if (angle >= 0 && angle <= 90) return 1;
    else if (angle > 90 && angle <= 180) return 2;
    else if (angle > 180 && angle <= 270) return 3;
    else return 4;
  }

  Offset _getBorderRadiusCut(double borderRadius, double outsideAngles) {
    if (borderRadius == 0) {
      return const Offset(0.0, 0.0);
    }

    double halfOutsideAngle = outsideAngles / 2;
    double dx = borderRadius * cos(_angleToRadian(halfOutsideAngle));
    double dy = borderRadius * sin(_angleToRadian(halfOutsideAngle));

    return new Offset(dx, dy);
  }

  double _angleToRadian(double angle) {
    return angle * (pi / 180);
  }

  Offset _getOffset(double angle, double rotation, double radius) {
    final rotationAwareAngle = angle - 90 + rotation;

    final radian = _angleToRadian(rotationAwareAngle);
    final x = radius + cos(radian) * radius;
    final y = radius + sin(radian) * radius;

    return new Offset(x, y);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}