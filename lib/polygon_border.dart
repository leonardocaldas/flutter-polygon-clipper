
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'polygon_path_drawer.dart';

class PolygonBorder extends ShapeBorder {

  const PolygonBorder({
    @required this.sides,
    this.rotate = 0.0,
    this.borderRadius = 0.0,
    this.border = BorderSide.none,
  }) : assert(sides != null),
       assert(rotate != null),
       assert(borderRadius != null),
       assert(border != null);

  final int sides;
  final double rotate;
  final double borderRadius;
  final BorderSide border;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(border.width);

  Path _getPath(Rect rect, double radius) {
    var specs = PolygonPathSpecs(
      sides: sides < 3 ? 3 : sides,
      rotate: rotate,
      borderRadiusAngle: borderRadius,
    );

    return PolygonPathDrawer(size: Size.fromRadius(radius), specs: specs).draw()
        .shift(Offset(rect.center.dx - radius, rect.center.dy - radius));
  }


  @override
  ShapeBorder lerpFrom(ShapeBorder a, double t) {
    if (a is PolygonBorder && a.sides == sides) {
      return PolygonBorder(
        sides: sides,
        rotate: lerpDouble(a.rotate, rotate, t),
        borderRadius: lerpDouble(a.borderRadius, borderRadius, t),
        border: BorderSide.lerp(a.border, border, t),
      );
    } else {
      return super.lerpFrom(a, t);
    }
  }


  @override
  ShapeBorder lerpTo(ShapeBorder b, double t) {
    if (b is PolygonBorder && b.sides == sides) {
      return PolygonBorder(
        sides: sides,
        rotate: lerpDouble(rotate, b.rotate, t),
        borderRadius: lerpDouble(borderRadius, b.borderRadius, t),
        border: BorderSide.lerp(border, b.border, t),
      );
    } else {
      return super.lerpTo(b, t);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    switch (border.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        var radius = (rect.shortestSide - border.width) / 2.0;
        var path = _getPath(rect, radius);
        canvas.drawPath(path, border.toPaint());
        break;
    }
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return _getPath(rect, math.max(0.0, rect.shortestSide / 2.0 - border.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return _getPath(rect, math.max(0.0, rect.shortestSide / 2.0));
  }

  @override
  ShapeBorder scale(double t) {
    return PolygonBorder(sides: sides,
        rotate : rotate,
        borderRadius: borderRadius * t,
        border: border.scale(t));
  }

  @override
  int get hashCode {
    return sides.hashCode ^ rotate.hashCode ^ borderRadius.hashCode ^ border.hashCode;
  }

  @override
  bool operator ==(other) {
    if (runtimeType != other.runtimeType) {
      return false;
    }

    final PolygonBorder typedOther = other;
    return sides == typedOther.sides && rotate == typedOther.rotate &&
        borderRadius == typedOther.borderRadius && border == typedOther.border;
  }
}