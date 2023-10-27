import 'dart:ui';

 import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';


class Faces_model{

  late List<Single_Face> faces;

  Faces_model(this.faces);

  Faces_model.fromJson(Map<String, dynamic> json) {
    if (json['faces'] != null) {
      faces = <Single_Face>[];
      json['faces'].forEach((v) { faces!.add(new Single_Face.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.faces != null) {
      data['faces'] = this.faces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
  late List<Bore_model> bores;
  late List<Join_Line> joines;


  Single_Face(this.name, this.corners,this.joines,this.bores);


  Single_Face.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['corners'] != null) {
      corners = <Point_model>[];
      json['corners'].forEach((v) { corners!.add(new Point_model.fromJson(v)); });
    }
    if (json['Bores_model'] != null) {
      bores = <Bore_model>[];
      json['Bores_model'].forEach((v) { bores!.add(new Bore_model.fromJson(v)); });
    }
    if (json['Joines_model'] != null) {
      joines = <Join_Line>[];
      json['Joines_model'].forEach((v) { joines!.add(new Join_Line.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.corners != null) {
      data['corners'] = this.corners!.map((v) => v.toJson()).toList();
    }
    if (this.bores != null) {
      data['Bores_model'] = this.bores!.map((v) => v.toJson()).toList();
    }
    if (this.joines != null) {
      data['Joines_model'] = this.joines!.map((v) => v.toJson()).toList();
    }
    return data;
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

  tow_D_Line(this.start_point, this.end_point);


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

  TowFaceBoring(this.H_bores, this.V_bores);
}