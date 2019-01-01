import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ClipPolygon(
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue[200],
                    Colors.blue[800],
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 150.0,
                  textDirection: TextDirection.ltr,
                ),
              )
          ),
          boxShadows: [
            PolygonBoxShadow(color: Colors.black, elevation: 5.0),
          ],
          sides: 6,
          borderRadius: 5.0,
        ),
      ),
    );
  }
}