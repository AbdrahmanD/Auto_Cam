

import 'package:auto_cam/Model/Main_Models/Piece_model.dart';

class Group_model {

  late String group_name;
  List<Piece_model> pieces=[];
  late bool group_enable;


  Group_model(this.group_name, this.pieces, this.group_enable);

  Group_model.from_json(Map<String,dynamic> map){

    group_name = map['group_name'];
    group_enable = map['group_enable'];
    if (map['pieces'] != null) {
      pieces = <Piece_model>[];
      map['box_pieces'].forEach((v) { pieces!.add(new Piece_model.fromJson(v)); });
    }

  }

  Map <String,dynamic> toJson(){
    Map<String,dynamic> map =Map<String,dynamic>() ;

    map['group_name'] = this.group_name;
    map['group_enable'] = this.group_enable;

    if (this.pieces != null) {
      map['pieces'] = this.pieces!.map((v) => v.toJson()).toList();
    }
return map;
  }



}
