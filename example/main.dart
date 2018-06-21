import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

void main() => runApp(new ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Center(
        child: new ClipPolygon(
          child: new Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red[200],
                    Colors.red[800],
                  ],
                ),
              ),
              child: new Center(
                child: new Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 150.0,
                  textDirection: TextDirection.ltr,
                ),
              )
          ),
          boxShadows: [
            new PolygonBoxShadow(color: Colors.black, elevation: 5.0),
          ],
          sides: 6,
          borderRadius: 5.0,
        ),
      ),
    );
  }
}