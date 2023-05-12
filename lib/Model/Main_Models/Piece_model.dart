
import 'package:auto_cam/Model/Main_Models/Coordinate_3D.dart';
import 'package:auto_cam/Model/Main_Models/Face_model.dart';
import 'package:auto_cam/Model/Main_Models/Point_model.dart';

class Piece_model{

  late int    piece_id;
  late String piece_name;
  late String piece_direction;
  late String material_name;

  late double Piece_width;
  late double Piece_height;
  late double Piece_thickness;
  late Cordinate_3D cordinate_3d;

  late Point_model      piece_origin;
  late Point_model      piece_center;
  late Face_model piece_faces;

  Piece_model(

      this.piece_id,
      this.piece_name,
      this.piece_direction,
      this.material_name,
      this.Piece_width,
      this.Piece_height,
      this.Piece_thickness,
      this.piece_origin,
      this.piece_faces

      )
  {
    late Point_model p0_1;
    late Point_model p0_2;
    late Point_model p0_3;
    late Point_model p0_4;
    late Point_model pz_1;
    late Point_model pz_2;
    late Point_model pz_3;
    late Point_model pz_4;

    if(piece_direction=='V'){
      p0_1=Point_model(0              +piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, 0);
      p0_2=Point_model(0              +piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_height, 0);
      p0_3=Point_model(Piece_thickness+piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_height, 0);
      p0_4=Point_model(Piece_thickness+piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, 0);

      pz_1=Point_model(0              +piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, Piece_width);
      pz_2=Point_model(0              +piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_height, Piece_width);
      pz_3=Point_model(Piece_thickness+piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_height, Piece_width);
      pz_4=Point_model(Piece_thickness+piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, Piece_width);
    }
    else if(piece_direction=='H'){
      p0_1=Point_model(0           +piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, 0);
      p0_2=Point_model(0           +piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_thickness, 0);
      p0_3=Point_model(Piece_height+piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_thickness, 0);
      p0_4=Point_model(Piece_height+piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, 0);

      pz_1=Point_model(0           +piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, Piece_width);
      pz_2=Point_model(0           +piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_thickness, Piece_width);
      pz_3=Point_model(Piece_height+piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_thickness, Piece_width);
      pz_4=Point_model(Piece_height+piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, Piece_width);
    }
    else if(piece_direction=='F'){
      p0_1=Point_model(0           +piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, 0);
      p0_2=Point_model(0           +piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_height, 0);
      p0_3=Point_model(Piece_width +piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_height, 0);
      p0_4=Point_model(Piece_width +piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, 0);

      pz_1=Point_model(0           +piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, Piece_thickness);
      pz_2=Point_model(0           +piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_height , Piece_thickness);
      pz_3=Point_model(Piece_width +piece_origin.x_coordinate,piece_origin.y_coordinate+ Piece_height , Piece_thickness);
      pz_4=Point_model(Piece_width +piece_origin.x_coordinate,piece_origin.y_coordinate+ 0, Piece_thickness);
    }

    piece_center=Point_model((p0_1.x_coordinate+pz_3.x_coordinate)/2,
        (p0_1.y_coordinate+p0_3.y_coordinate)/2, p0_1.z_coordinate);
    List<Point_model> xy_0_plane=[p0_1,p0_2,p0_3,p0_4];
    List<Point_model> xy_z_plane=[pz_1,pz_2,pz_3,pz_4];

    cordinate_3d=Cordinate_3D(xy_0_plane, xy_z_plane);
  }

}