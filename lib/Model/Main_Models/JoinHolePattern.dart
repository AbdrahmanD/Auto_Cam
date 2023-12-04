import 'dart:ui';

import 'package:auto_cam/Model/Main_Models/Faces_model.dart';

class JoinHolePattern {
  // late String category;
  late String name;
  late double min_length;
  late double max_length;
  late List<Bore_unit> bores;

  JoinHolePattern( this.name, this.min_length, this.max_length, this.bores);

  List<Bore_unit> apply_pattern(double length) {

    List<Bore_unit> applied_bores = [];

    for (Bore_unit bore_unit in bores) {
      if(bore_unit.center==true){
        Bore_unit center_bore_unit = Bore_unit(
            length/2,
            bore_unit.side_bore,
            bore_unit.have_nut_bore,
            bore_unit.nut_bore_distence,
            bore_unit.nut_bore,
            bore_unit.face_bore,
            bore_unit.center,
            bore_unit.mirror);
        applied_bores.add(center_bore_unit);
      }
      else{
        if(bore_unit.mirror){
          double pre_dis = bore_unit.pre_distence;

          Bore_unit mirror_bore_unit_1 = Bore_unit(
              pre_dis,
              bore_unit.side_bore,
              bore_unit.have_nut_bore,
              bore_unit.nut_bore_distence,
              bore_unit.nut_bore,
              bore_unit.face_bore,
              bore_unit.center,
              bore_unit.mirror);

          Bore_unit mirror_bore_unit_2 = Bore_unit(
              length - pre_dis,
              bore_unit.side_bore,
              bore_unit.have_nut_bore,
              bore_unit.nut_bore_distence,
              bore_unit.nut_bore,
              bore_unit.face_bore,
              bore_unit.center,
              bore_unit.mirror);

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

  JoinHolePattern.fromJson(Map<String, dynamic> json) {
    // category = json['category'];
    name = json['name'];
    min_length = json['min_length'];
    max_length = json['max_length'];
    if (json['bores'] != null) {
      bores = <Bore_unit>[];
      json['bores'].forEach((v) {
        bores!.add(new Bore_unit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data["category"] = this.category;
    data["name"] = this.name;
    data["min_length"] = this.min_length;
    data["max_length"] = this.max_length;
    if (this.bores != null) {
      data["bores"] = this.bores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bore_unit {
  late double pre_distence;
  late Bore_model side_bore;
  late bool have_nut_bore;
  late double nut_bore_distence;
  late Bore_model nut_bore;
  late Bore_model face_bore;

  late bool center;
  late bool mirror;


  Bore_unit(
      this.pre_distence,
      this.side_bore,
      this.have_nut_bore,
      this.nut_bore_distence,
      this.nut_bore,
      this.face_bore,
      this.center,
      this.mirror);

  Bore_unit.fromJson(Map<String, dynamic> json) {
    pre_distence = json['pre_distence'];
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

  Line(this.start_point, this.end_point);


}

class tow_D_Line{

  late Offset start_point;
  late Offset end_point;
  late String line_type;

  tow_D_Line(this.start_point, this.end_point,this.line_type);


}

class Join_Line{

  late Point_model start_point;
  late Point_model end_point;
  late String join_type;

  Join_Line(this.start_point, this.end_point, this.join_type);


  Join_Line.fromJson(Map<String, dynamic> json) {
    start_point =  Point_model.fromJson(json['start_point']) ;
    end_point = Point_model.fromJson(json['origend_pointin']) ;
    join_type = json['join_type'];
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
    return data;
  }


}


class TowFaceBoring{
  late List<Bore_model> H_bores;
  late List<Bore_model> V_bores;
  late List<Groove_model> Grooves;

  TowFaceBoring(this.H_bores, this.V_bores,this.Grooves);
}