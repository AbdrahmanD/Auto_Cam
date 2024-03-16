

import 'package:auto_cam/Model/Main_Models/Piece_model.dart';

class Group_model {

  List<Piece_model> pieces=[];

  Group_model(this.pieces);

  Group_model.from_json(Map<String,dynamic> map){
    if (map['pieces'] != null) {
      pieces = <Piece_model>[];
      map['box_pieces'].forEach((v) { pieces!.add(new Piece_model.fromJson(v)); });
    }

  }

  Map <String,dynamic> toJson(){
    Map<String,dynamic> map =Map<String,dynamic>() ;
    if (this.pieces != null) {
      map['pieces'] = this.pieces!.map((v) => v.toJson()).toList();
    }
return map;
  }



}
