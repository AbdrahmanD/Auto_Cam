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
  late List<Groove_model> groves;
  late List<Join_Line> joines;


  Single_Face(this.name, this.corners,this.joines,this.groves,this.bores);


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
    if (json['groves'] != null) {
      groves = <Groove_model>[];
      json['groves'].forEach((v) { groves!.add(new Groove_model.fromJson(v)); });
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
    if (this.groves != null) {
      data['groves'] = this.groves!.map((v) => v.toJson()).toList();
    }
    if (this.joines != null) {
      data['Joines_model'] = this.joines!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}


class Rectangle_model{
late  List<Point_model> corners;
late double width;
late double height;

Rectangle_model(this.corners){
  width =corners[1].x_coordinate-corners[0].x_coordinate;
  height=corners[0].y_coordinate-corners[2].y_coordinate;
}



}


class Groove_model{

  late Point_model start_point;
  late Point_model end_point;
  late double groove_width;
  late double groove_depth;

  Groove_model( this.start_point, this.end_point, this.groove_width,this.groove_depth);

  Groove_model.fromJson(Map<String,dynamic> map){
    this.start_point=Point_model.fromJson(map["start_point"]);
    this.end_point=Point_model.fromJson(map["end_point"]);
    this.groove_width=map["groove_width"];
    this.groove_depth=map["groove_depth"];

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["start_point"]=this.start_point.toJson();
    data["end_point"]=this.end_point.toJson();
    data["groove_width"]=this.groove_width;
    data["groove_depth"]=this.groove_depth;

    return data;
  }

}


