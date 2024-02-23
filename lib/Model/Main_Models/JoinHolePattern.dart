import 'dart:ui';

import 'package:auto_cam/Model/Main_Models/Faces_model.dart';

class JoinHolePattern {
  late String name;
  late double min_length;
  late double max_length;


  late int quantity;
  late double main_pre_distance;


  late List<Bore_unit> bores;
  late bool pattern_enable ;


  JoinHolePattern(this.name, this.min_length, this.max_length,
      this.quantity, this.main_pre_distance,  this.bores, this.pattern_enable);

  List<Bore_unit> apply_pattern(double length) {

    List<Bore_unit> applied_bores = [];

    for (Bore_unit bore_unit in bores) {
      if(bore_unit.center==true){
        Bore_unit center_bore_unit = Bore_unit(
            length/2+bore_unit.correct_x,bore_unit.correct_x ,bore_unit.correct_y,
            bore_unit.side_bore,
            bore_unit.have_nut_bore,
            bore_unit.nut_bore_distence,
            bore_unit.nut_bore,
            bore_unit.face_bore,
            bore_unit.center,
            bore_unit.mirror
        );
        applied_bores.add(center_bore_unit);
      }
      else{
        if(bore_unit.mirror){
          double pre_dis = bore_unit.pre_distence;

          Bore_unit mirror_bore_unit_1 = Bore_unit(
              pre_dis+bore_unit.correct_x,bore_unit.correct_x,bore_unit.correct_y,
              bore_unit.side_bore,
              bore_unit.have_nut_bore,
              bore_unit.nut_bore_distence,
              bore_unit.nut_bore,
              bore_unit.face_bore,
              bore_unit.center,
              bore_unit.mirror
          );

          Bore_unit mirror_bore_unit_2 = Bore_unit(
              length -pre_dis-bore_unit.correct_x,bore_unit.correct_x,bore_unit.correct_y,
              bore_unit.side_bore,
              bore_unit.have_nut_bore,
              bore_unit.nut_bore_distence,
              bore_unit.nut_bore,
              bore_unit.face_bore,
              bore_unit.center,
              bore_unit.mirror
          );

          applied_bores.add(mirror_bore_unit_1);
          applied_bores.add(mirror_bore_unit_2);

        }
        else{
          applied_bores.add(bore_unit);
        }
      }
    }

    return applied_bores;
  }

  List<Bore_unit> apply_pattern_on_door(double length) {

    List<Bore_unit> applied_bores = [];

    double distance=(length-(2*main_pre_distance))/(quantity-1);

    double pre_distance=main_pre_distance;


    for (int i=0;i<quantity/2;i++) {


      Bore_unit bore_unit_main = Bore_unit(
          pre_distance,bores[0].correct_x,bores[0].correct_y,
          bores[0].side_bore,
          bores[0].have_nut_bore,
          bores[0].nut_bore_distence,
          bores[0].nut_bore,
          bores[0].face_bore,
          bores[0].center,
          bores[0].mirror
      );

      Bore_unit bore_unit_support_1 = Bore_unit(
          pre_distance+bores[1].correct_y,
          bores[1].correct_x,
          bores[1].correct_y,
          bores[1].side_bore,
          bores[1].have_nut_bore,
          bores[1].nut_bore_distence,
          bores[1].nut_bore,
          bores[1].face_bore,
          bores[1].center,
          bores[1].mirror
      );

      Bore_unit bore_unit_support_2 = Bore_unit(
          pre_distance-bores[2].correct_y,
          bores[2].correct_x,
          bores[2].correct_y,
          bores[2].side_bore,
          bores[2].have_nut_bore,
          bores[2].nut_bore_distence,
          bores[2].nut_bore,
          bores[2].face_bore,
          bores[2].center,
          bores[2].mirror
      );


      applied_bores.add(bore_unit_main);
      applied_bores.add(bore_unit_support_1);
      applied_bores.add(bore_unit_support_2);


      Bore_unit m_bore_unit_main = Bore_unit(
          length- pre_distance,bores[0].correct_x,bores[0].correct_y,
          bores[0].side_bore,
          bores[0].have_nut_bore,
          bores[0].nut_bore_distence,
          bores[0].nut_bore,
          bores[0].face_bore,
          bores[0].center,
          bores[0].mirror
      );

      Bore_unit m_bore_unit_support_1 = Bore_unit(
          length-(pre_distance+bores[1].correct_y),
          bores[1].correct_x,
          bores[1].correct_y,
          bores[1].side_bore,
          bores[1].have_nut_bore,
          bores[1].nut_bore_distence,
          bores[1].nut_bore,
          bores[1].face_bore,
          bores[1].center,
          bores[1].mirror
      );

      Bore_unit m_bore_unit_support_2 = Bore_unit(
          length-(pre_distance-bores[2].correct_y),
          bores[2].correct_x,
          bores[2].correct_y,
          bores[2].side_bore,
          bores[2].have_nut_bore,
          bores[2].nut_bore_distence,
          bores[2].nut_bore,
          bores[2].face_bore,
          bores[2].center,
          bores[2].mirror
      );


      applied_bores.add(m_bore_unit_main);
      applied_bores.add(m_bore_unit_support_1);
      applied_bores.add(m_bore_unit_support_2);

      if(quantity%2!=0){

        Bore_unit c_bore_unit_main = Bore_unit(
            length/2,bores[0].correct_x,bores[0].correct_y,
            bores[0].side_bore,
            bores[0].have_nut_bore,
            bores[0].nut_bore_distence,
            bores[0].nut_bore,
            bores[0].face_bore,
            bores[0].center,
            bores[0].mirror
        );

        Bore_unit c_bore_unit_support_1 = Bore_unit(
            length/2+bores[1].correct_y,
            bores[1].correct_x,
            bores[1].correct_y,
            bores[1].side_bore,
            bores[1].have_nut_bore,
            bores[1].nut_bore_distence,
            bores[1].nut_bore,
            bores[1].face_bore,
            bores[1].center,
            bores[1].mirror
        );

        Bore_unit c_bore_unit_support_2 = Bore_unit(
            length/2-bores[2].correct_y,
            bores[2].correct_x,
            bores[2].correct_y,
            bores[2].side_bore,
            bores[2].have_nut_bore,
            bores[2].nut_bore_distence,
            bores[2].nut_bore,
            bores[2].face_bore,
            bores[2].center,
            bores[2].mirror
        );


        applied_bores.add(c_bore_unit_main);
        applied_bores.add(c_bore_unit_support_1);
        applied_bores.add(c_bore_unit_support_2);

      }


      pre_distance+=distance;
    }



    return applied_bores;
  }
  List<Bore_unit> apply_pattern_on_side(double length) {

    List<Bore_unit> applied_bores = [];

    double distance=(length-(2*main_pre_distance))/(quantity-1);

    double pre_distance=main_pre_distance;

    for (int i=0;i<quantity/2;i++) {

      Bore_unit bore_unit_support_1 = Bore_unit(
          pre_distance-bores[0].correct_y,
          bores[0].correct_x,
          bores[0].correct_y,
          bores[0].side_bore,
          bores[0].have_nut_bore,
          bores[0].nut_bore_distence,
          bores[0].nut_bore,
          bores[0].face_bore,
          bores[0].center,
          bores[0].mirror
      );

      Bore_unit bore_unit_support_2 = Bore_unit(
          pre_distance+bores[1].correct_y,
          bores[1].correct_x,
          bores[1].correct_y,
          bores[1].side_bore,
          bores[1].have_nut_bore,
          bores[1].nut_bore_distence,
          bores[1].nut_bore,
          bores[1].face_bore,
          bores[1].center,
          bores[1].mirror
      );

      applied_bores.add(bore_unit_support_1);
      applied_bores.add(bore_unit_support_2);


      Bore_unit m_bore_unit_support_1 = Bore_unit(
          length-pre_distance+bores[0].correct_y,
          bores[0].correct_x,
          bores[0].correct_y,
          bores[0].side_bore,
          bores[0].have_nut_bore,
          bores[0].nut_bore_distence,
          bores[0].nut_bore,
          bores[0].face_bore,
          bores[0].center,
          bores[0].mirror
      );

      Bore_unit m_bore_unit_support_2 = Bore_unit(
          length-pre_distance-bores[1].correct_y,
          bores[1].correct_x,
          bores[1].correct_y,
          bores[1].side_bore,
          bores[1].have_nut_bore,
          bores[1].nut_bore_distence,
          bores[1].nut_bore,
          bores[1].face_bore,
          bores[1].center,
          bores[1].mirror
      );

      applied_bores.add(m_bore_unit_support_1);
      applied_bores.add(m_bore_unit_support_2);



      if(quantity%2!=0){

        Bore_unit c_bore_unit_support_1 = Bore_unit(
            length/2+bores[0].correct_y,
            bores[0].correct_x,
            bores[0].correct_y,
            bores[0].side_bore,
            bores[0].have_nut_bore,
            bores[0].nut_bore_distence,
            bores[0].nut_bore,
            bores[0].face_bore,
            bores[0].center,
            bores[0].mirror
        );

        Bore_unit c_bore_unit_support_2 = Bore_unit(
            length/2-bores[1].correct_y,
            bores[1].correct_x,
            bores[1].correct_y,
            bores[1].side_bore,
            bores[1].have_nut_bore,
            bores[1].nut_bore_distence,
            bores[1].nut_bore,
            bores[1].face_bore,
            bores[1].center,
            bores[1].mirror
        );

        applied_bores.add(c_bore_unit_support_1);
        applied_bores.add(c_bore_unit_support_2);



      }

      // print("side_bore_units from model = ${applied_bores.length}");


      pre_distance+=distance;



    }

    return applied_bores;
  }



  JoinHolePattern.fromJson(Map<String, dynamic> json) {
    // category = json['category'];
    name = json['name'];
    min_length = json['min_length'];
    max_length = json['max_length'];
    quantity = json['quantity'];
    main_pre_distance = json['main_pre_distance'];

    if (json['bores'] != null) {
      bores = <Bore_unit>[];
      json['bores'].forEach((v) {
        bores!.add(new Bore_unit.fromJson(v));
      });
    }
    pattern_enable=json["pattern_enable"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data["category"] = this.category;
    data["name"] = this.name;
    data["min_length"] = this.min_length;
    data["max_length"] = this.max_length;
    data["quantity"] = this.quantity;
    data["main_pre_distance"] = this.main_pre_distance;

    if (this.bores != null) {
      data["bores"] = this.bores!.map((v) => v.toJson()).toList();
    }
    data["pattern_enable"] = this.pattern_enable;

    return data;
  }

}


class Bore_unit {

  late double pre_distence;
  late double correct_x;
  late double correct_y;
  late Bore_model side_bore;
  late bool have_nut_bore;
  late double nut_bore_distence;
  late Bore_model nut_bore;
  late Bore_model face_bore;

  late bool center;
  late bool mirror;


  Bore_unit(
      this.pre_distence,
      this.correct_x,
      this.correct_y,
      this.side_bore,
      this.have_nut_bore,
      this.nut_bore_distence,
      this.nut_bore,
      this.face_bore,
      this.center,
      this.mirror);

  Bore_unit.fromJson(Map<String, dynamic> json) {
    pre_distence = json['pre_distence'];
    correct_x = json['correct_x'];
    correct_y = json['correct_y'];
    side_bore = json['side_bore'] = Bore_model.fromJson(json['side_bore']);
    have_nut_bore = json['have_nut_bore'];
    nut_bore_distence = json['nut_bore_distence'];
    nut_bore = json['nut_bore'] = Bore_model.fromJson(json['nut_bore']);
    face_bore = json['face_bore'] = Bore_model.fromJson(json['face_bore']);
    center = json['center'];
    mirror = json['mirror'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["pre_distence"] = this.pre_distence;
    data["correct_x"] = this.correct_x;
    data["correct_y"] = this.correct_y;
    if (this.side_bore != null) {
      data["side_bore"] = this.side_bore!.toJson();
    }
    data["have_nut_bore"] = this.have_nut_bore;
    data["nut_bore_distence"] = this.nut_bore_distence;
    if (this.nut_bore != null) {
      data["nut_bore"] = this.nut_bore!.toJson();
    }
    if (this.face_bore != null) {
      data["face_bore"] = this.face_bore!.toJson();
    }
    data["center"] = this.center;
    data["mirror"] = this.mirror;

    return data;
  }
}

class Bore_model {
  late  Point_model origin;
  late double diameter;
  late double depth;



  Bore_model(this.origin,this.diameter, this.depth);

  Bore_model.fromJson(Map<String, dynamic> json) {

    origin=Point_model.fromJson(json['origin']);
    diameter = json['diameter'];
    depth = json['depth'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["diameter"] = this.diameter;
    data["depth"] = this.depth;
    data["origin"] = this.origin!.toJson();

    return data;
  }
}

class Point_model{

  late double x_coordinate;
  late double y_coordinate;
  late double z_coordinate;

  Point_model(this.x_coordinate,this.y_coordinate,this.z_coordinate);

  Point_model.fromJson(Map<String, dynamic> json) {

    x_coordinate = json["x_coordinate"];
    y_coordinate = json["y_coordinate"];
    z_coordinate = json["z_coordinate"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["x_coordinate"] = this.x_coordinate;
    data["y_coordinate"] = this.y_coordinate;
    data["z_coordinate"] = this.z_coordinate;
    return data;
  }

  Point_model correct_cordinate( ){

    double new_X=double.parse(this.x_coordinate.toStringAsFixed(2));
    double new_Y=double.parse(this.y_coordinate.toStringAsFixed(2));
    double new_Z=double.parse(this.z_coordinate.toStringAsFixed(2));

    return Point_model(new_X, new_Y, new_Z);
  }


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
  late double line_width;

  Line(this.start_point, this.end_point,this.line_width);


}

class tow_D_Line{

  late Offset start_point;
  late Offset end_point;
  late String line_type;
  late double line_width;

  tow_D_Line(this.start_point, this.end_point,this.line_type,this.line_width);


}

class Join_Line{

  late Point_model start_point;
  late Point_model end_point;
  late String join_type;
  late double join_width;

  Join_Line(this.start_point, this.end_point, this.join_type,this.join_width);


  Join_Line.fromJson(Map<String, dynamic> json) {
    start_point =  Point_model.fromJson(json['start_point']) ;
    end_point = Point_model.fromJson(json['origend_pointin']) ;
    join_type = json['join_type'];
    join_width = json['join_width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.start_point != null) {
      data['start_point'] = this.start_point!.toJson();
    }
    if (this.end_point != null) {
      data['origend_pointin'] = this.end_point!.toJson();
    }
    data['join_type'] = this.join_type;
    data['join_width'] = this.join_width;
    return data;
  }


}


class TowFaceBoring{
  late List<Bore_model> H_bores;
  late List<Bore_model> V_bores;
  late List<Groove_model> Grooves;

  TowFaceBoring(this.H_bores, this.V_bores,this.Grooves);
}