import 'dart:ui';

import 'package:auto_cam/Model/Main_Models/Groove_model.dart';
import 'package:auto_cam/Model/Main_Models/Join_model.dart';

class Faces_model{

  late Single_Face top_face;
  late Single_Face right_face;
  late Single_Face base_face;
  late Single_Face left_face;
  late Single_Face front_face;
  late Single_Face back_face;

  Faces_model(this.top_face, this.right_face, this.base_face, this.left_face,
      this.front_face, this.back_face);

}

class Single_Face {
  late List<Point_model> corners;
  late List<int> face_item;
  late List<Join_model> join_list;
  late List<Groove_model> groove_list;

  Single_Face(this.corners,this.face_item, this.join_list, this.groove_list);
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