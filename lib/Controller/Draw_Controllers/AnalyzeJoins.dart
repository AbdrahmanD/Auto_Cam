import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';

class AnalyzeJoins {
  late Box_model box_model;

  AnalyzeJoins(this.box_model) {
    clean_faces();
    all_face_check();
  }

  clean_faces() {
    for (int p = 0; p < box_model.box_pieces.length; p++) {
      Piece_model piece = box_model.box_pieces[p];
      for (int f = 0; f < piece.piece_faces.faces.length; f++) {
        box_model.box_pieces[p].piece_faces.faces[f].joines=[];
      }
    }
  }

  /// for all pieces loop
  all_face_check() {
    for (int mp = 0; mp < box_model.box_pieces.length; mp++) {
      Piece_model mpiece = box_model.box_pieces[mp];

      if (mpiece.piece_name=="inner") {
        continue;
      }

      // print('name : ${mpiece.piece_name} , id : ${mpiece.piece_id}');

      for (int mf = 0; mf < mpiece.piece_faces.faces.length; mf++) {
        Single_Face mface = mpiece.piece_faces.faces[mf];

        for (int sp = 0; sp < box_model.box_pieces.length; sp++) {
          Piece_model spiece = box_model.box_pieces[sp];

          if (spiece.piece_id == mpiece.piece_id || spiece.piece_name=="inner") {
            continue;
          }
          for (int sf = 0; sf < spiece.piece_faces.faces.length; sf++) {
            Single_Face sface = spiece.piece_faces.faces[sf];


            if (check_face_in_face((mface), (sface))) {
              /// ==================

              // print('mp: ${mpiece.piece_name}/${mpiece.piece_id}-mf:${mface.name} && sp: ${spiece.piece_name}-sf:${sface.name}');

              Join_Line join_line=find_center_line(sface,spiece.piece_thickness);
              sface.joines.add(join_line);
              mface.joines.add(join_line);



              /// ==================
            }
          }
        }
      }
    }
  }

  Join_Line find_center_line(Single_Face face , double thickness) {

    Point_model corner_1 = face.corners[0];
    Point_model corner_3 = face.corners[2];

    Point_model sp=Point_model(0, 0, 0);
    Point_model ep=Point_model(0, 0, 0);

    if(face.name==1 || face.name==3){
      if((corner_3.x_coordinate-corner_1.x_coordinate)==thickness){

        sp.x_coordinate=face.corners[0].x_coordinate+thickness/2;
        sp.y_coordinate=face.corners[0].y_coordinate;
        sp.z_coordinate=face.corners[0].z_coordinate;

        ep.x_coordinate=face.corners[2].x_coordinate-thickness/2;
        ep.y_coordinate=face.corners[2].y_coordinate;
        ep.z_coordinate=face.corners[2].z_coordinate;

      }else{

        sp.x_coordinate=face.corners[0].x_coordinate;
        sp.y_coordinate=face.corners[0].y_coordinate;
        sp.z_coordinate=face.corners[0].z_coordinate+thickness/2;

        ep.x_coordinate=face.corners[2].x_coordinate;
        ep.y_coordinate=face.corners[2].y_coordinate;
        ep.z_coordinate=face.corners[2].z_coordinate-thickness/2;

      }
    }
    else if (face.name==2||face.name==4){


      if((corner_3.z_coordinate-corner_1.z_coordinate)==thickness){

        sp.x_coordinate=face.corners[0].x_coordinate;
        sp.y_coordinate=face.corners[0].y_coordinate;
        sp.z_coordinate=face.corners[0].z_coordinate+thickness/2;

        ep.x_coordinate=face.corners[2].x_coordinate;
        ep.y_coordinate=face.corners[2].y_coordinate;
        ep.z_coordinate=face.corners[2].z_coordinate-thickness/2;

      }else{

        sp.x_coordinate=face.corners[0].x_coordinate;
        sp.y_coordinate=face.corners[0].y_coordinate+thickness/2;
        sp.z_coordinate=face.corners[0].z_coordinate;

        ep.x_coordinate=face.corners[2].x_coordinate;
        ep.y_coordinate=face.corners[2].y_coordinate-thickness/2;
        ep.z_coordinate=face.corners[2].z_coordinate;

      }


    }

    else if (face.name==5||face.name==6){


      if((corner_3.x_coordinate-corner_1.x_coordinate)==thickness)
      {

        sp.x_coordinate=face.corners[0].x_coordinate+(corner_3.x_coordinate-corner_1.x_coordinate)/2;
        sp.y_coordinate=face.corners[0].y_coordinate;
        sp.z_coordinate=face.corners[0].z_coordinate;

        ep.x_coordinate=face.corners[2].x_coordinate-(corner_3.x_coordinate-corner_1.x_coordinate)/2;
        ep.y_coordinate=face.corners[2].y_coordinate;
        ep.z_coordinate=face.corners[2].z_coordinate;

      }else{

        sp.x_coordinate=face.corners[0].x_coordinate;
        sp.y_coordinate=face.corners[0].y_coordinate+(corner_3.y_coordinate-corner_1.y_coordinate)/2;
        sp.z_coordinate=face.corners[0].z_coordinate;

        ep.x_coordinate=face.corners[2].x_coordinate;
        ep.y_coordinate=face.corners[2].y_coordinate-(corner_3.y_coordinate-corner_1.y_coordinate)/2;
        ep.z_coordinate=face.corners[2].z_coordinate;

      }


    }


    Join_Line join_line = Join_Line(sp, ep,"DRILL");

    return join_line;
  }

  /// find center of face
  Point_model face_center(Single_Face face) {
    Point_model face_center = Point_model(0, 0, 0);

    Point_model p1 = face.corners[0];
    Point_model p3 = face.corners[2];

    /// the face in the YZ plane
    if (p1.x_coordinate == p3.x_coordinate) {
      face_center.x_coordinate = p1.x_coordinate;
      face_center.y_coordinate = (p1.y_coordinate + p3.y_coordinate) / 2;
      face_center.z_coordinate = (p1.z_coordinate + p3.z_coordinate) / 2;
    } else

    /// the face in the XZ plane
    if (p1.y_coordinate == p3.y_coordinate) {
      face_center.y_coordinate = p1.y_coordinate;
      face_center.x_coordinate = (p1.x_coordinate + p3.x_coordinate) / 2;
      face_center.z_coordinate = (p1.z_coordinate + p3.z_coordinate) / 2;
    } else

    /// the face in the XY plane
    if (p1.z_coordinate == p3.z_coordinate) {
      face_center.z_coordinate = p1.z_coordinate;
      face_center.y_coordinate = (p1.y_coordinate + p3.y_coordinate) / 2;
      face_center.x_coordinate = (p1.x_coordinate + p3.x_coordinate) / 2;
    }

    return face_center;
  }

  /// if the center of face in the second face
  bool check_face_in_face(Single_Face mface, Single_Face sface) {
    bool in_face = false;

    if (check_if_same_plane(mface, sface)) {
      Point_model mp0 = mface.corners[0];
      Point_model mp2 = mface.corners[2];

      Point_model sp0 = sface.corners[0];
      Point_model sp2 = sface.corners[2];

      if (face_plane(mface) == 'XY') {
        bool compare_X = (mp0.x_coordinate <= sp0.x_coordinate) &&
            (mp2.x_coordinate >= sp2.x_coordinate);
        bool compare_Y = (mp0.y_coordinate <= sp0.y_coordinate) &&
            (mp2.y_coordinate >= sp2.y_coordinate);
        bool compare_Z = (mp0.z_coordinate <= sp0.z_coordinate) &&
            (mp2.z_coordinate >= sp2.z_coordinate);

        if (compare_X && compare_Y) {
          in_face = true;
        }
      } else if (face_plane(mface) == 'XZ') {
        bool compare_X = (mp0.x_coordinate <= sp0.x_coordinate) &&
            (mp2.x_coordinate >= sp2.x_coordinate);
        bool compare_Y = (mp0.y_coordinate <= sp0.y_coordinate) &&
            (mp2.y_coordinate >= sp2.y_coordinate);
        bool compare_Z = (mp0.z_coordinate <= sp0.z_coordinate) &&
            (mp2.z_coordinate >= sp2.z_coordinate);

        if (compare_X && compare_Z) {
          in_face = true;
        }
      } else if (face_plane(mface) == 'YZ') {
        bool compare_X = (mp0.x_coordinate <= sp0.x_coordinate) &&
            (mp2.x_coordinate >= sp2.x_coordinate);
        bool compare_Y = (mp0.y_coordinate <= sp0.y_coordinate) &&
            (mp2.y_coordinate >= sp2.y_coordinate);
        bool compare_Z = (mp0.z_coordinate <= sp0.z_coordinate) &&
            (mp2.z_coordinate >= sp2.z_coordinate);

        if (compare_Z && compare_Y) {
          in_face = true;
        }
      }
    }

    return in_face;
  }

  ///is_point_in_face
  bool is_point_in_face(Single_Face face, Point_model p) {
    bool in_face = false;

    /// xy plane
    if (face_plane(face) == 'XY') {
      Point_model mp0 = face.corners[0];
      Point_model mp2 = face.corners[2];

      bool compair_x = (mp0.x_coordinate <= p.x_coordinate) &&
          (mp2.x_coordinate >= p.x_coordinate);
      bool compair_y = (mp0.y_coordinate <= p.y_coordinate) &&
          (mp2.y_coordinate >= p.y_coordinate);
      bool compair_z = (mp0.z_coordinate <= p.z_coordinate) &&
          (mp2.z_coordinate >= p.z_coordinate);

      if (compair_x && compair_y) {
        in_face = true;
      }
    }

    /// xz plane
    else if (face_plane(face) == 'XZ') {
      Point_model mp0 = face.corners[0];
      Point_model mp2 = face.corners[2];

      bool compair_x = (mp0.x_coordinate <= p.x_coordinate) &&
          (mp2.x_coordinate >= p.x_coordinate);
      bool compair_y = (mp0.y_coordinate <= p.y_coordinate) &&
          (mp2.y_coordinate >= p.y_coordinate);
      bool compair_z = (mp0.z_coordinate <= p.z_coordinate) &&
          (mp2.z_coordinate >= p.z_coordinate);

      if (compair_x && compair_z) {
        in_face = true;
      }
    }

    /// yz plane
    else if (face_plane(face) == 'YZ') {
      Point_model mp0 = face.corners[0];
      Point_model mp2 = face.corners[2];

      bool compair_x = (mp0.x_coordinate <= p.x_coordinate) &&
          (mp2.x_coordinate >= p.x_coordinate);
      bool compair_y = (mp0.y_coordinate <= p.y_coordinate) &&
          (mp2.y_coordinate >= p.y_coordinate);
      bool compair_z = (mp0.z_coordinate <= p.z_coordinate) &&
          (mp2.z_coordinate >= p.z_coordinate);

      if (compair_y && compair_z) {
        in_face = true;
      }
    }

    return in_face;
  }

  /// detect face plane
  String face_plane(Single_Face face) {
    late String plane;

    Point_model p1 = face.corners[0];
    Point_model p3 = face.corners[2];

    /// the face in the YZ plane
    if (p1.x_coordinate == p3.x_coordinate) {
      plane = 'YZ';
    } else

    /// the face in the XZ plane
    if (p1.y_coordinate == p3.y_coordinate) {
      plane = "XZ";
    } else

    /// the face in the XY plane
    if (p1.z_coordinate == p3.z_coordinate) {
      plane = 'XY';
    }

    return plane;
  }

  /// check if it in same plane
  bool check_if_same_plane(Single_Face main_face, Single_Face secondary) {
    bool same_plane = false;
    String main_plane = face_plane(main_face);
    String secondary_plane = face_plane(secondary);

    if (main_plane == secondary_plane) {
      if (main_plane == 'XY') {
        if (face_center(main_face).z_coordinate ==
            face_center(secondary).z_coordinate) {
          same_plane = true;
        }
      } else if (main_plane == 'XZ') {
        if (face_center(main_face).y_coordinate ==
            face_center(secondary).y_coordinate) {
          same_plane = true;
        }
      } else if (main_plane == 'YZ') {
        if (face_center(main_face).x_coordinate ==
            face_center(secondary).x_coordinate) {
          same_plane = true;
        }
      } else {
        same_plane = false;
      }
    }

    return same_plane;
  }
}
