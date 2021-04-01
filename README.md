# flutter_polygon
  
A Flutter plugin to create views using regular polygon shapes (e.g. Pentagons and Hexagons).

Based on the [polygon_clipper](https://pub.dev/packages/polygon_clipper) package by [leonardocaldas](https://github.com/leonardocaldas). 

![Example1](https://raw.githubusercontent.com/wietsebuseyne/flutter_polygon/doc/screenshot1.png)
![Example2](https://raw.githubusercontent.com/wietsebuseyne/flutter_polygon/doc/screenshot2.png)
  
## Installation  
Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_polygon: ^0.1.0
```
  
## Usage

### Clipping

Use the `ClipPolygon` widget to clip a child widget.
``` dart
import 'package:flutter_polygon/flutter_polygon.dart';

ClipPolygon(  
 sides: 6, 
 borderRadius: 5.0,     // Defaults to 0.0 degrees
 rotate: 90.0,          // Defaults to 0.0 degrees
 boxShadows: [  
  PolygonBoxShadow(color: Colors.black, elevation: 1.0),
  PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
 ],
 child: Container(color: Colors.black),
);
```  

### Borders

Use the `PolygonBorder` shape with your favorites widgets! 
``` dart
import 'package:flutter_polygon/flutter_polygon.dart';

FloatingActionButton(
  shape: PolygonBorder(
    sides: 5,
    borderRadius: 5.0,                                      // Defaults to 0.0 degrees
    rotate: 90.0,                                           // Defaults to 0.0 degrees
    border: BorderSide(color: Colors.red, width: 2.0),      // Defaults to BorderSide.none
  ),
  onPressed: runAction,
  child: Icon(Icons.star),
),
```

## Contributing

If you find an issue with this package, please open an issue on [github](https://github.com/wietsebuseyne/flutter_polygon).

If you wish to contribute to this project, I encourage you to open a pull request.

## Credit

Based on the [polygon_clipper](https://pub.dev/packages/polygon_clipper) package by [leonardocaldas](https://github.com/leonardocaldas).