
# Polygon Clipper  
  
A Flutter plugin to create views using regular polygon shapes (e.g. Pentagons and Hexagons).  
  
[[https://github.com/leonardocaldas/flutter-polygon-clipper/blob/master/img/screenshot1.png]]
[[https://github.com/leonardocaldas/flutter-polygon-clipper/blob/master/img/screenshot2.png]]
[[https://github.com/leonardocaldas/flutter-polygon-clipper/blob/master/img/screenshot2.png]]  
  
## Installation  
To use this plugin, add `polygon_clipper` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).  
  
### Usage  
  
``` dart  
// Import package  
import 'package:polygon_clipper/polygon_clipper.dart';  
  
new ClipPolygon(  
 sides: 6, 
 borderRadius: 5.0, 
 boxShadows: [  
  new PolygonBoxShadow(color: Colors.black, elevation: 1.0),
  new PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
 ],
 child: new Container( color: Colors.black, ),
 );
```  
  
### Parameters  

##### ClipPolygon
| Param | Type | Description |
 |---|---|---|  
| sides | int | The number of sides to draw the polygon |
| borderRadius | double | This value is used in degrees.
| child | Widget | The widget that will be rendered inside the polygon.
| boxShadows | PolygonBoxShadow[] |A list of box shadows.

##### PolygonBoxShadow

| Param | Type | Description |
 |---|---|---|  
| color | Color | The color of the box shadow.
| elevation | double | The distance of the shadow.