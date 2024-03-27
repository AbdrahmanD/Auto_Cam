
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';


class Piece_model{


  late String          piece_id;
  late String       piece_name;
  late String       piece_direction;
  late String       material_name;
  late double       piece_width;
  late double       piece_height;
  late double       piece_thickness;
  late Point_model  piece_origin;
  late Faces_model   piece_faces;

  late double       back_distance;


  bool              piece_inable=true;

  List<Point_model> cutting_boarder=[];



  Piece_model(

      this.piece_id,
      this.piece_name,
      this.piece_direction,
      this.material_name,
      this.piece_width,
      this.piece_height,
      this.piece_thickness,
      this.piece_origin,
       )
  {
    late Point_model p_1;
    late Point_model p_2;
    late Point_model p_3;
    late Point_model p_4;
    late Point_model p_5;
    late Point_model p_6;
    late Point_model p_7;
    late Point_model p_8;

    double x0=piece_origin.x_coordinate;
    double y0=piece_origin.y_coordinate;
    double z0=piece_origin.z_coordinate;


    if(piece_direction=='V'){

      p_1=Point_model(x0, y0, z0).correct_cordinate();
      p_2=Point_model(x0+piece_thickness, y0, z0).correct_cordinate();
      p_3=Point_model(x0+piece_thickness, y0+piece_height, z0).correct_cordinate();
      p_4=Point_model(x0, y0+piece_height, z0).correct_cordinate();
      p_5=Point_model(x0, y0, z0+piece_width).correct_cordinate();
      p_6=Point_model(x0+piece_thickness, y0, z0+piece_width).correct_cordinate();
      p_7=Point_model(x0+piece_thickness, y0+piece_height, z0+piece_width).correct_cordinate();
      p_8=Point_model(x0, y0+piece_height, z0+piece_width).correct_cordinate();

    }
    else if(piece_direction=='H'){

      p_1=Point_model(x0, y0, z0).correct_cordinate();
      p_2=Point_model(x0+piece_height, y0, z0).correct_cordinate();
      p_3=Point_model(x0+piece_height, y0+piece_thickness, z0).correct_cordinate();
      p_4=Point_model(x0, y0+piece_thickness, z0).correct_cordinate();
      p_5=Point_model(x0, y0, z0+piece_width).correct_cordinate();
      p_6=Point_model(x0+piece_height, y0, z0+piece_width).correct_cordinate();
      p_7=Point_model(x0+piece_height, y0+piece_thickness, z0+piece_width).correct_cordinate();
      p_8=Point_model(x0, y0+piece_thickness, z0+piece_width).correct_cordinate();

    }
    else if(piece_direction=='F'){

      p_1=                   Point_model(x0, y0, z0).correct_cordinate();
      p_2=          Point_model(x0+piece_width, y0, z0).correct_cordinate();
      p_3=Point_model(x0+piece_width, y0+piece_height, z0).correct_cordinate();
      p_4=            Point_model(x0, y0+piece_height, z0).correct_cordinate();
      p_5=          Point_model(x0, y0, z0+piece_thickness).correct_cordinate();
      p_6=Point_model(x0+piece_width, y0, z0+piece_thickness).correct_cordinate();
      p_7=Point_model(x0+piece_width, y0+piece_height, z0+piece_thickness).correct_cordinate();
      p_8=             Point_model(x0, y0+piece_height, z0+piece_thickness).correct_cordinate();

    }

    List<Single_Face> faces= [
      Single_Face(1,[p_4,p_3,p_7,p_8], [], [], []),
      Single_Face(2,[p_2,p_6,p_7,p_3], [], [], []),
      Single_Face(3,[p_1,p_2,p_6,p_5], [], [], []),
      Single_Face(4,[p_1,p_5,p_8,p_4], [], [], []),
      Single_Face(5,[p_1,p_2,p_3,p_4], [], [], []),
      Single_Face(6,[p_5,p_6,p_7,p_8], [], [], []),
    ] ;

    piece_faces=Faces_model(faces);


  }


  Piece_model.fromJson(Map<String, dynamic> json) {
    piece_id = json['piece_id'];
    piece_name = json['piece_name'];
    piece_direction = json['piece_direction'];
    material_name = json['material_name'];
    piece_width = json['piece_width'];
    piece_height = json['piece_height'];
    piece_thickness = json['piece_thickness'];
    piece_origin = Point_model.fromJson(json['piece_origin']) ;
    piece_faces =Faces_model.fromJson(json['piece_faces']);
     piece_inable = json['piece_inable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['piece_id'] = this.piece_id;
    data['piece_name'] = this.piece_name;
    data['piece_direction'] = this.piece_direction;
    data['material_name'] = this.material_name;
    data['piece_width'] = this.piece_width;
    data['piece_height'] = this.piece_height;
    data['piece_thickness'] = this.piece_thickness;
    if (this.piece_origin != null) {
      data['piece_origin'] = this.piece_origin!.toJson();
    }
    if (this.piece_faces != null) {
      data['piece_faces'] = this.piece_faces!.toJson();
    }
     data['piece_inable'] = this.piece_inable;
    return data;
  }



}

