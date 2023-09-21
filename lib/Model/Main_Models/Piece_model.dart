
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';

class Piece_model{


  late int          piece_id;
  late String       piece_name;
  late String       piece_direction;
  late String       material_name;
  late double       piece_width;
  late double       piece_height;
  late double       piece_thickness;
  late Point_model  piece_origin;
  late Faces_model   piece_faces;

  bool              is_changed=false;
  bool              piece_inable=true;


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

      p_1=Point_model(x0, y0, z0);
      p_2=Point_model(x0+piece_thickness, y0, z0);
      p_3=Point_model(x0+piece_thickness, y0+piece_height, z0);
      p_4=Point_model(x0, y0+piece_height, z0);

      p_5=Point_model(x0, y0, z0+piece_width);
      p_6=Point_model(x0+piece_thickness, y0, z0+piece_width);
      p_7=Point_model(x0+piece_thickness, y0+piece_height, z0+piece_width);
      p_8=Point_model(x0, y0+piece_height, z0+piece_width);

    }
    else if(piece_direction=='H'){

      p_1=Point_model(x0, y0, z0);
      p_2=Point_model(x0+piece_height, y0, z0);
      p_3=Point_model(x0+piece_height, y0+piece_thickness, z0);
      p_4=Point_model(x0, y0+piece_thickness, z0);

      p_5=Point_model(x0, y0, z0+piece_width);
      p_6=Point_model(x0+piece_height, y0, z0+piece_width);
      p_7=Point_model(x0+piece_height, y0+piece_thickness, z0+piece_width);
      p_8=Point_model(x0, y0+piece_thickness, z0+piece_width);

    }
    else if(piece_direction=='F'){

      p_1=Point_model(x0, y0, z0);
      p_2=Point_model(x0+piece_width, y0, z0);
      p_3=Point_model(x0+piece_width, y0+piece_height, z0);
      p_4=Point_model(x0, y0+piece_height, z0);

      p_5=Point_model(x0, y0, z0+piece_thickness);
      p_6=Point_model(x0+piece_width, y0, z0+piece_thickness);
      p_7=Point_model(x0+piece_width, y0+piece_height, z0+piece_thickness);
      p_8=Point_model(x0, y0+piece_height, z0+piece_thickness);

    }

    List<Single_Face> faces= [
      Single_Face(1,[p_4,p_3,p_7,p_8], [], []),
      Single_Face(2,[p_2,p_6,p_7,p_3], [], []),
      Single_Face(3,[p_1,p_2,p_6,p_5], [], []),
      Single_Face(4,[p_1,p_5,p_8,p_4], [], []),
      Single_Face(5,[p_1,p_2,p_3,p_4], [], []),
      Single_Face(6,[p_5,p_6,p_7,p_8], [], []),
    ] ;

    piece_faces=Faces_model(faces);


  }

}