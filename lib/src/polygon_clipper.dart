import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

/// A widget that clips its child using a polygon with its number of sides equal to [sides], rotated by [rotate] degrees.
///
/// To round the edges of the polygon, pass the desired angle to [borderRadius].
/// There is a known issue where adding a [borderRadius] will reduce the size of the polygon.
class ClipPolygon extends StatelessWidget {
  final Widget? child;
  final int sides;
  final double rotate;
  final double borderRadius;
  final List<PolygonBoxShadow> boxShadows;

  /// Creates a polygon shaped clip with [sides] sides rotated [rotate] degrees.
  ///
  /// Provide a [borderRadius] to set the radius of the corners.
  ///
  /// The [sides] argument must be at least 3.
  ClipPolygon(
      {required this.sides,
      this.rotate: 0.0,
      this.borderRadius: 0.0,
      this.boxShadows: const [],
      this.child})
      : assert(sides >= 3);

  @override
  Widget build(BuildContext context) {
    PolygonPathSpecs specs = PolygonPathSpecs(
      sides: sides < 3 ? 3 : sides,
      rotate: rotate,
      borderRadiusAngle: borderRadius,
    );

    return AspectRatio(
        aspectRatio: 1.0,
        child: CustomPaint(
            painter: PolygonBoxShadowPainter(specs, boxShadows),
            child: ClipPath(
              clipper: PolygonClipper(specs),
              child: child,
            )));
  }
}

/// Provides polygon shaped clips based on [PolygonPathSpecs]
class PolygonClipper extends CustomClipper<Path> {
  final PolygonPathSpecs specs;

  /// Create a polygon clipper with the provided specs.
  PolygonClipper(this.specs);

  @override
  Path getClip(Size size) {
    return PolygonPathDrawer(size: size, specs: specs).draw();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

/// A polygon shaped shadow
class PolygonBoxShadowPainter extends CustomPainter {
  final PolygonPathSpecs specs;
  final List<PolygonBoxShadow> boxShadows;

  /// Creates a polygon shaped shadow
  PolygonBoxShadowPainter(this.specs, this.boxShadows);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = PolygonPathDrawer(size: size, specs: specs).draw();

    boxShadows.forEach((PolygonBoxShadow shadow) {
      canvas.drawShadow(path, shadow.color, shadow.elevation, false);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// Specifications of a polygon box shadow
class PolygonBoxShadow {
  final Color color;
  final double elevation;

  /// Creates a polygon box shadow with the provided [color] and [elevation].
  PolygonBoxShadow({
    required this.color,
    required this.elevation,
  });
}
