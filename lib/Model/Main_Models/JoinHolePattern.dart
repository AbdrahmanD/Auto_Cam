class JoinHolePattern {
  late String name;
  late double min_length;
  late double max_length;
  late List<Bore_unit> bores;

  JoinHolePattern(this.name, this.min_length, this.max_length, this.bores);

  List<Bore_unit> apply_pattern(double length) {

    List<Bore_unit> applied_bores = [];
    for (Bore_unit bore_unit in bores) {
      if(bore_unit.center==true){
        Bore_unit center_bore_unit = Bore_unit(
            length/2,
            bore_unit.side_bore,
            bore_unit.have_face_bore,
            bore_unit.face_bore_distence,
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
              bore_unit.have_face_bore,
              bore_unit.face_bore_distence,
              bore_unit.face_bore,
              bore_unit.center,
              bore_unit.mirror);
          Bore_unit mirror_bore_unit_2 = Bore_unit(
              length - pre_dis,
              bore_unit.side_bore,
              bore_unit.have_face_bore,
              bore_unit.face_bore_distence,
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
  late bool have_face_bore;
  late double face_bore_distence;
  late Bore_model face_bore;

  late bool center;
  late bool mirror;


  Bore_unit(this.pre_distence, this.side_bore, this.have_face_bore,
      this.face_bore_distence, this.face_bore, this.center, this.mirror);

  Bore_unit.fromJson(Map<String, dynamic> json) {
    pre_distence = json['pre_distence'];
    side_bore = json['side_bore'] = Bore_model.fromJson(json['side_bore']);
    have_face_bore = json['have_face_bore'];
    face_bore_distence = json['face_bore_distence'];
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
    data["have_face_bore"] = this.have_face_bore;
    data["face_bore_distence"] = this.face_bore_distence;
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


}

