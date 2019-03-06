
# Polygon Clipper  
  
A Flutter plugin to create views using regular polygon shapes (e.g. Pentagons and Hexagons).  

[![pub package](https://img.shields.io/pub/v/polygon_clipper.svg)](https://pub.dartlang.org/packages/polygon_clipper)
  
![Example1](https://raw.githubusercontent.com/leonardocaldas/flutter-polygon-clipper/assets/imgs/screenshot1.png)
![Example2](https://raw.githubusercontent.com/leonardocaldas/flutter-polygon-clipper/assets/imgs/screenshot2.png)
![Example3](https://raw.githubusercontent.com/leonardocaldas/flutter-polygon-clipper/assets/imgs/screenshot3.png)
  
## Installation  
Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  polygon_clipper: ^1.0.1
```
  
## Usage  
  
Import Package
``` dart
import 'package:polygon_clipper/polygon_clipper.dart';  
```
  
Using ClipPolygon widget
``` dart
ClipPolygon(  
 sides: 6, 
 borderRadius: 5.0, // Default 0.0 degrees
 rotate: 90.0, // Default 0.0 degrees
 boxShadows: [  
  PolygonBoxShadow(color: Colors.black, elevation: 1.0),
  PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
 ],
 child: Container(color: Colors.black),
);
```  

Using PolygonBorder shape
``` dart
FloatingActionButton(
  shape: PolygonBorder(
    sides: 5,
    borderRadius: 5.0, // Default 0.0 degrees
    rotate: 90.0, // Default 0.0 degrees
    border: BorderSide.none, // Default BorderSide.none
  ),
  onPressed: runAction,
  child: Icon(Icons.star),
),
```
  
## Parameters  

##### ClipPolygon
| Param | Type | Description |
 |---|---|---|  
| sides | int | The number of sides to draw the polygon
| borderRadius | double | The length of the border radius in degrees.
| rotate | double | The initial polygon rotation in degrees.
| child | Widget | The widget that will be rendered inside the polygon.
| boxShadows | PolygonBoxShadow[] |A list of box shadows.

##### PolygonBoxShadow

| Param | Type | Description |
 |---|---|---|  
| color | Color | The color of the box shadow.
| elevation | double | The distance of the shadow.

##### PolygonBorder
| Param | Type | Description |
 |---|---|---|  
| sides | int | The number of sides to draw the polygon
| borderRadius | double | The length of the border radius in degrees.
| rotate | double | The initial polygon rotation in degrees.
| border | BorderSide | The style of the border (when `PolygonBorder` is used in `Container`, etc.

## Contributing

If you wish to contribute to this project, I encourage you to open a pull request.