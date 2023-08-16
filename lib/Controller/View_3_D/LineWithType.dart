
import 'dart:ui';

import 'package:auto_cam/Model/Main_Models/Faces_model.dart';


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