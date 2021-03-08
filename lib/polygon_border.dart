
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'polygon_path_drawer.dart';

class PolygonBorder extends OutlinedBorder {

  const PolygonBorder({
    @required this.sides,
    this.rotate = 0.0,
    this.borderRadius = 0.0,
    BorderSide border = BorderSide.none,
  }) : assert(sides != null),
       assert(rotate != null),
       assert(borderRadius != null),
       assert(border != null),
       super(side: border);

  final int sides;
  final double rotate;
  final double borderRadius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

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
        border: BorderSide.lerp(a.side, side, t),
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
        border: BorderSide.lerp(side, b.side, t),
      );
    } else {
      return super.lerpTo(b, t);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        var radius = (rect.shortestSide - side.width) / 2.0;
        var path = _getPath(rect, radius);
        canvas.drawPath(path, side.toPaint());
        break;
    }
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return _getPath(rect, math.max(0.0, rect.shortestSide / 2.0 - side.width));
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
        border: side.scale(t));
  }

  @override
  int get hashCode {
    return sides.hashCode ^ rotate.hashCode ^ borderRadius.hashCode ^ side.hashCode;
  }

  @override
  bool operator ==(other) {
    if (runtimeType != other.runtimeType) {
      return false;
    }

    final PolygonBorder typedOther = other;
    return sides == typedOther.sides && rotate == typedOther.rotate &&
        borderRadius == typedOther.borderRadius && side == typedOther.side;
  }

  @override
  OutlinedBorder copyWith({BorderSide side}) {
    if (side == null) return this;
    return PolygonBorder(
      sides: sides,
      border: side,
      rotate: rotate,
      borderRadius: borderRadius,
    );
  }
}