import 'polygon_path_drawer.dart';
import 'package:flutter/material.dart';

class ClipPolygon extends StatelessWidget {
  final Widget child;
  final int sides;
  final double rotate;
  final double borderRadius;
  final List<PolygonBoxShadow> boxShadows;

  ClipPolygon(
      {@required this.child,
      @required this.sides,
      this.rotate: 0.0,
      this.borderRadius: 0.0,
      this.boxShadows: const []});

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
            painter: BoxShadowPainter(specs, boxShadows),
            child: ClipPath(
              clipper: Polygon(specs),
              child: child,
            )));
  }
}

class Polygon extends CustomClipper<Path> {
  final PolygonPathSpecs specs;

  Polygon(this.specs);

  @override
  Path getClip(Size size) {
    return PolygonPathDrawer(size: size, specs: specs).draw();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BoxShadowPainter extends CustomPainter {
  final PolygonPathSpecs specs;
  final List<PolygonBoxShadow> boxShadows;

  BoxShadowPainter(this.specs, this.boxShadows);

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

class PolygonBoxShadow {
  final Color color;
  final double elevation;

  PolygonBoxShadow({
    @required this.color,
    @required this.elevation,
  });
}
