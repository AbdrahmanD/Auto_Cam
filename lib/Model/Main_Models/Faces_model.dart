import 'dart:ui';


class Faces_model{

  late List<Single_Face> faces;

  Faces_model(this.faces);

}

/// top    = 1
/// right  = 2
/// base   = 3
/// left   = 4
/// front  = 5
/// back   = 6




class Single_Face {

  late int name;
  late List<Point_model> corners;
  // late List<Single_Face> face_item;
  late List<Join_Line> joines;


  Single_Face(this.name, this.corners,this.joines);
}

class Point_model{

  late double x_coordinate;
  late double y_coordinate;
  late double z_coordinate;

  Point_model(this.x_coordinate,this.y_coordinate,this.z_coordinate);

}

class LineWithType{
  late List<Line> lines;
  late String type;
  late Color color;

  LineWithType(this.lines, this.type,this.color);
}

class Line{

  late Point_model start_point;
  late Point_model end_point;

  Line(this.start_point, this.end_point);


}

class tow_D_Line{

  late Offset start_point;
  late Offset end_point;

  tow_D_Line(this.start_point, this.end_point);


}
class Join_Line{

  late Point_model start_point;
  late Point_model end_point;
  late String join_type;

  Join_Line(this.start_point, this.end_point, this.join_type);
}