

import 'package:auto_cam/Model/Main_Models/Faces_model.dart';

class Join_model {

  late Point_model hole_point;
  late double hole_diameter;
  late double hole_depth;
  late String Join_type;

  Join_model( this.hole_point, this.hole_diameter,this.hole_depth, this.Join_type);
}

class Join_model_2{
  late Point_model p1;
  late Point_model p2;

  List<hole_model> vertical_hole=[];
  List<hole_model> horizontal_hole=[];

  Join_model_2(this.p1,this.p2);




}

class Jion_line{
  late Point_model start_point;
  late Point_model end_point;

  Jion_line(this.start_point, this.end_point);
}

class hole_model{

  late Point_model hole_point;
  late double hole_diameter;
  late double hole_depth;

  hole_model( this.hole_point, this.hole_diameter,this.hole_depth);

}