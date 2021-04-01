import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

/// A border that fits a polygon-shaped border with its number of sides equal to [sides], rotated by [rotate] degrees
/// within the rectangle of the widget it is applied to.
///
/// To round the edges of the polygon, pass the desired angle to [borderRadius].
/// There is a known issue where adding a [borderRadius] will reduce the size of the polygon.
///
/// See also:
///
///  * [BorderSide], which is used to describe the border of the polygon.
class PolygonBorder extends OutlinedBorder {
  final int sides;
  final double rotate;
  final double borderRadius;

  /// Create a PolygonBorder number of sides equal to [sides], rotated by [rotate] degrees.
  ///
  /// Provide a [borderRadius] to set the radius of the corners.
  ///
  /// Use [side] to define the outline's color and weight.
  /// If [side] is [BorderSide.none], which is the default, an outline is not drawn.
  /// Otherwise the outline is centered over the shape's boundary.
  ///
  /// [sides] should be at least 3.
  ///
  /// All variables must not be null.
  const PolygonBorder({
    required this.sides,
    this.rotate = 0.0,
    this.borderRadius = 0.0,
    BorderSide side = BorderSide.none,
  })  : assert(sides >= 2),
        super(side: side);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  Path _getPath(Rect rect, double radius) {
    var specs = PolygonPathSpecs(
      sides: sides < 3 ? 3 : sides,
      rotate: rotate,
      borderRadiusAngle: borderRadius,
    );

    return PolygonPathDrawer(size: Size.fromRadius(radius), specs: specs)
        .draw()
        .shift(Offset(rect.center.dx - radius, rect.center.dy - radius));
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is PolygonBorder && a.sides == sides) {
      return PolygonBorder(
        sides: sides,
        rotate: lerpDouble(a.rotate, rotate, t)!,
        borderRadius: lerpDouble(a.borderRadius, borderRadius, t)!,
        side: BorderSide.lerp(a.side, side, t),
      );
    } else {
      return super.lerpFrom(a, t);
    }
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is PolygonBorder && b.sides == sides) {
      return PolygonBorder(
        sides: sides,
        rotate: lerpDouble(rotate, b.rotate, t)!,
        borderRadius: lerpDouble(borderRadius, b.borderRadius, t)!,
        side: BorderSide.lerp(side, b.side, t),
      );
    } else {
      return super.lerpTo(b, t);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
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
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, math.max(0.0, rect.shortestSide / 2.0 - side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, math.max(0.0, rect.shortestSide / 2.0));
  }

  @override
  ShapeBorder scale(double t) {
    return PolygonBorder(
        sides: sides,
        rotate: rotate,
        borderRadius: borderRadius * t,
        side: side.scale(t));
  }

  @override
  int get hashCode {
    return sides.hashCode ^
        rotate.hashCode ^
        borderRadius.hashCode ^
        side.hashCode;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PolygonBorder &&
              runtimeType == other.runtimeType &&
              sides == other.sides &&
              side == other.side &&
              rotate == other.rotate &&
              borderRadius == other.borderRadius;

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    if (side == null) return this;
    return PolygonBorder(
      sides: sides,
      side: side,
      rotate: rotate,
      borderRadius: borderRadius,
    );
  }
}
