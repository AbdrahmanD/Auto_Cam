import 'dart:math';

import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:get/get.dart';

class AnalyzeJoins {
  late Box_model box_model;

  Draw_Controller draw_controller = Get.find();

  AnalyzeJoins(this.box_model) {
    clean_faces();
    all_face_check();
    test();
  }

  clean_faces() {
    for (int p = 0; p < box_model.box_pieces.length; p++) {
      Piece_model piece = box_model.box_pieces[p];
      for (int f = 0; f < piece.piece_faces.faces.length; f++) {
        box_model.box_pieces[p].piece_faces.faces[f].joines = [];
        box_model.box_pieces[p].piece_faces.faces[f].bores = [];
      }
    }
  }

  ///  all pieces for loop
  all_face_check() {
    for (int mp = 0; mp < box_model.box_pieces.length; mp++) {
      Piece_model mpiece = box_model.box_pieces[mp];

      if (mpiece.piece_name == "inner" || mpiece.piece_name == "HELPER") {
        continue;
      }

      for (int mf = 0; mf < mpiece.piece_faces.faces.length; mf++) {
        Single_Face mface = mpiece.piece_faces.faces[mf];

        for (int sp = 0; sp < box_model.box_pieces.length; sp++) {
          Piece_model spiece = box_model.box_pieces[sp];

          if (spiece.piece_id == mpiece.piece_id ||
              spiece.piece_name == "inner" ||
              spiece.piece_name == "HELPER") {
            continue;
          }
          for (int sf = 0; sf < spiece.piece_faces.faces.length; sf++) {
            Single_Face sface = spiece.piece_faces.faces[sf];

            bool mfd =
                detect_face_direction(mpiece.piece_direction, mface) == "V" ||
                    detect_face_direction(mpiece.piece_direction, mface) == "B";
            bool sfd =
                detect_face_direction(spiece.piece_direction, sface) == "V" ||
                    detect_face_direction(spiece.piece_direction, sface) == "B";
            if (mfd && sfd) {
              continue;
            }
            if (check_face_in_face((mface), (sface))) {
              /// ==================

              Join_Line join_line =
                  find_center_line(sface, spiece.piece_thickness);
              sface.joines.add(join_line);
              mface.joines.add(join_line);

              /// ==================
            } else {
              Join_Line join_line = check_tow_face_intersected(mface, sface);
              sface.joines.add(join_line);
              mface.joines.add(join_line);
            }
          }
        }
      }
    }
    add_drill_bores_to_faces();
  }

  Join_Line find_center_line(Single_Face face, double thickness) {
    Point_model corner_1 = face.corners[0];
    Point_model corner_3 = face.corners[2];

    Point_model sp = Point_model(0, 0, 0);
    Point_model ep = Point_model(0, 0, 0);

    if (face.name == 1 || face.name == 3) {
      if ((corner_3.x_coordinate - corner_1.x_coordinate) == thickness) {
        sp.x_coordinate = face.corners[0].x_coordinate + thickness / 2;
        sp.y_coordinate = face.corners[0].y_coordinate;
        sp.z_coordinate = face.corners[0].z_coordinate;

        ep.x_coordinate = face.corners[2].x_coordinate - thickness / 2;
        ep.y_coordinate = face.corners[2].y_coordinate;
        ep.z_coordinate = face.corners[2].z_coordinate;
      } else {
        sp.x_coordinate = face.corners[0].x_coordinate;
        sp.y_coordinate = face.corners[0].y_coordinate;
        sp.z_coordinate = face.corners[0].z_coordinate + thickness / 2;

        ep.x_coordinate = face.corners[2].x_coordinate;
        ep.y_coordinate = face.corners[2].y_coordinate;
        ep.z_coordinate = face.corners[2].z_coordinate - thickness / 2;
      }
    } else if (face.name == 2 || face.name == 4) {
      if ((corner_3.z_coordinate - corner_1.z_coordinate) == thickness) {
        sp.x_coordinate = face.corners[0].x_coordinate;
        sp.y_coordinate = face.corners[0].y_coordinate;
        sp.z_coordinate = face.corners[0].z_coordinate + thickness / 2;

        ep.x_coordinate = face.corners[2].x_coordinate;
        ep.y_coordinate = face.corners[2].y_coordinate;
        ep.z_coordinate = face.corners[2].z_coordinate - thickness / 2;
      } else {
        sp.x_coordinate = face.corners[0].x_coordinate;
        sp.y_coordinate = face.corners[0].y_coordinate + thickness / 2;
        sp.z_coordinate = face.corners[0].z_coordinate;

        ep.x_coordinate = face.corners[2].x_coordinate;
        ep.y_coordinate = face.corners[2].y_coordinate - thickness / 2;
        ep.z_coordinate = face.corners[2].z_coordinate;
      }
    } else if (face.name == 5 || face.name == 6) {
      if ((corner_3.x_coordinate - corner_1.x_coordinate) == thickness) {
        sp.x_coordinate = face.corners[0].x_coordinate +
            (corner_3.x_coordinate - corner_1.x_coordinate) / 2;
        sp.y_coordinate = face.corners[0].y_coordinate;
        sp.z_coordinate = face.corners[0].z_coordinate;

        ep.x_coordinate = face.corners[2].x_coordinate -
            (corner_3.x_coordinate - corner_1.x_coordinate) / 2;
        ep.y_coordinate = face.corners[2].y_coordinate;
        ep.z_coordinate = face.corners[2].z_coordinate;
      } else {
        sp.x_coordinate = face.corners[0].x_coordinate;
        sp.y_coordinate = face.corners[0].y_coordinate +
            (corner_3.y_coordinate - corner_1.y_coordinate) / 2;
        sp.z_coordinate = face.corners[0].z_coordinate;

        ep.x_coordinate = face.corners[2].x_coordinate;
        ep.y_coordinate = face.corners[2].y_coordinate -
            (corner_3.y_coordinate - corner_1.y_coordinate) / 2;
        ep.z_coordinate = face.corners[2].z_coordinate;
      }
    }

    Join_Line join_line = Join_Line(sp, ep, "DRILL");

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
  bool check_if_point_in_face(Single_Face face, Point_model p) {
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

  /// all next method are to discover the intersection between tow faces

  /// discover intersection between tow line
  bool discover_lines_intersect(Line l1, Line l2, String plane) {
    bool intersected = false;
    Point_model l1sp = l1.start_point;
    Point_model l1ep = l1.end_point;
    Point_model l2sp = l2.start_point;
    Point_model l2ep = l2.end_point;

    if (line_axis(l1) != line_axis(l2)) {
      if (plane == "XY") {
        if (line_axis(l1) == "X") {
          bool x_compare = (l1sp.x_coordinate < l2sp.x_coordinate &&
                  l1ep.x_coordinate > l2sp.x_coordinate) ||
              (l1sp.x_coordinate > l2sp.x_coordinate &&
                  l1ep.x_coordinate < l2sp.x_coordinate);

          bool y_compare = (l2sp.y_coordinate < l1sp.y_coordinate &&
                  l2ep.y_coordinate > l1sp.y_coordinate) ||
              (l2sp.y_coordinate > l1sp.y_coordinate &&
                  l2ep.y_coordinate < l1sp.y_coordinate);

          intersected = x_compare && y_compare;
        } else {
          bool x_compare = (l2sp.x_coordinate < l1sp.x_coordinate &&
                  l2ep.x_coordinate > l1sp.x_coordinate) ||
              (l2sp.x_coordinate > l1sp.x_coordinate &&
                  l2ep.x_coordinate < l1sp.x_coordinate);

          bool y_compare = (l1sp.y_coordinate < l2sp.y_coordinate &&
                  l1ep.y_coordinate > l2sp.y_coordinate) ||
              (l1sp.y_coordinate > l2sp.y_coordinate &&
                  l1ep.y_coordinate < l2sp.y_coordinate);

          intersected = x_compare && y_compare;
        }
      }

      if (plane == "XZ") {
        if (line_axis(l1) == "X") {
          bool x_compare = (l1sp.x_coordinate < l2sp.x_coordinate &&
                  l1ep.x_coordinate > l2sp.x_coordinate) ||
              (l1sp.x_coordinate > l2sp.x_coordinate &&
                  l1ep.x_coordinate < l2sp.x_coordinate);

          bool z_compare = (l2sp.z_coordinate < l1sp.z_coordinate &&
                  l2ep.z_coordinate > l1sp.z_coordinate) ||
              (l2sp.z_coordinate > l1sp.z_coordinate &&
                  l2ep.z_coordinate < l1sp.z_coordinate);

          intersected = x_compare && z_compare;
        } else {
          bool x_compare = (l2sp.x_coordinate < l1sp.x_coordinate &&
                  l2ep.x_coordinate > l1sp.x_coordinate) ||
              (l2sp.x_coordinate > l1sp.x_coordinate &&
                  l2ep.x_coordinate < l1sp.x_coordinate);

          bool z_compare = (l1sp.z_coordinate < l2sp.z_coordinate &&
                  l1ep.z_coordinate > l2sp.z_coordinate) ||
              (l1sp.z_coordinate > l2sp.z_coordinate &&
                  l1ep.z_coordinate < l2sp.z_coordinate);

          intersected = x_compare && z_compare;
        }
      }

      if (plane == "YZ") {
        if (line_axis(l1) == "Z") {
          bool z_compare = (l1sp.z_coordinate < l2sp.z_coordinate &&
                  l1ep.z_coordinate > l2sp.z_coordinate) ||
              (l1sp.z_coordinate > l2sp.z_coordinate &&
                  l1ep.z_coordinate < l2sp.z_coordinate);

          bool y_compare = (l2sp.y_coordinate < l1sp.y_coordinate &&
                  l2ep.y_coordinate > l1sp.y_coordinate) ||
              (l2sp.y_coordinate > l1sp.y_coordinate &&
                  l2ep.y_coordinate < l1sp.y_coordinate);

          intersected = z_compare && y_compare;
        } else {
          bool z_compare = (l2sp.z_coordinate < l1sp.z_coordinate &&
                  l2ep.z_coordinate > l1sp.z_coordinate) ||
              (l2sp.z_coordinate > l1sp.z_coordinate &&
                  l2ep.z_coordinate < l1sp.z_coordinate);

          bool y_compare = (l1sp.y_coordinate < l2sp.y_coordinate &&
                  l1ep.y_coordinate > l2sp.y_coordinate) ||
              (l1sp.y_coordinate > l2sp.y_coordinate &&
                  l1ep.y_coordinate < l2sp.y_coordinate);

          intersected = z_compare && y_compare;
        }
      }
    }

    return intersected;
  }

  /// discover the axis of the line
  String line_axis(Line l) {
    late String axis;
    Point_model sp = l.start_point;
    Point_model ep = l.end_point;

    if (sp.x_coordinate == ep.x_coordinate &&
        sp.y_coordinate == ep.y_coordinate) {
      axis = "Z";
    } else if (sp.x_coordinate == ep.x_coordinate &&
        sp.z_coordinate == ep.z_coordinate) {
      axis = "Y";
    } else if (sp.z_coordinate == ep.z_coordinate &&
        sp.y_coordinate == ep.y_coordinate) {
      axis = "X";
    } else {
      axis = 'Z';
    }

    return axis;
  }

  /// extract face edges as lines
  List<Line> extract_face_lines(Single_Face face) {
    List<Line> face_line = [];
    for (int i = 0; i < 4; i++) {
      int t = i;
      if (t == 3) {
        Line line = Line(face.corners[i], face.corners[0]);
        face_line.add(line);
        continue;
      } else {
        Line line = Line(face.corners[i], face.corners[i + 1]);
        face_line.add(line);
      }
    }

    return face_line;
  }

  /// detect the other tow corner witch will be the corners of the face that not intersected,
  /// but have same coordinate of second face border
  List<Point_model> extract_intersection_rect_corner(
      Single_Face face1, Single_Face face2) {
    List<Point_model> corners = [];

    for (int i = 0; i < 4; i++) {
      Point_model p = face1.corners[i];

      if (check_if_point_in_face(face2, p)) {
        corners.add(p);
        // for (int ii = 0; ii < corners.length; ii++) {
        //
        //   Point_model tp = corners[ii];
        //   if (tp.x_coordinate == p.x_coordinate &&
        //       tp.y_coordinate == p.y_coordinate &&
        //       tp.z_coordinate == p.z_coordinate)
        //   {
        //     continue;
        //   }
        //   else
        //   {
        //     corners.add(p);
        //   }
        //
        // }
      }
    }

    for (int i = 0; i < 4; i++) {
      Point_model p = face2.corners[i];

      if (check_if_point_in_face(face1, p)) {
        corners.add(p);

        // for (int ii = 0; ii < corners.length; ii++) {
        //
        //   Point_model tp = corners[ii];
        //   if (tp.x_coordinate == p.x_coordinate &&
        //       tp.y_coordinate == p.y_coordinate &&
        //       tp.z_coordinate == p.z_coordinate)
        //   {
        //     continue;
        //   } else {
        //     corners.add(p);
        //   }
        //
        // }
      }
    }

    return corners;
  }

  /// final method until now
  Join_Line check_tow_face_intersected(Single_Face face1, Single_Face face2) {
    late Join_Line join_line =
        Join_Line(Point_model(0, 0, 0), Point_model(0, 0, 0), "null");
    List<Point_model> intersection_rect = [];

    if (check_if_same_plane(face1, face2)) {
      for (int f1 = 0; f1 < extract_face_lines(face1).length; f1++) {
        Line l1 = extract_face_lines(face1)[f1];

        for (int f2 = 0; f2 < extract_face_lines(face2).length; f2++) {
          Line l2 = extract_face_lines(face2)[f2];

          if (discover_lines_intersect(l1, l2, face_plane(face1))) {
            late double x;
            late double y;
            late double z;

            if (l1.start_point.x_coordinate == l1.end_point.x_coordinate) {
              x = l1.start_point.x_coordinate;
            } else if (l2.start_point.x_coordinate ==
                l2.end_point.x_coordinate) {
              x = l2.start_point.x_coordinate;
            } else {
              print(
                  "l1 x : ${l1.start_point.x_coordinate} , l1  eX:${l1.end_point.x_coordinate}");
            }

            if (l1.start_point.y_coordinate == l1.end_point.y_coordinate) {
              y = l1.start_point.y_coordinate;
            } else if (l2.start_point.y_coordinate ==
                l2.end_point.y_coordinate) {
              y = l2.start_point.y_coordinate;
            }

            if (l1.start_point.z_coordinate == l1.end_point.z_coordinate) {
              z = l1.start_point.z_coordinate;
            } else if (l2.start_point.z_coordinate ==
                l2.end_point.z_coordinate) {
              z = l2.start_point.z_coordinate;
            }

            intersection_rect.add(Point_model(x, y, z));
          }
        }
      }

      if (intersection_rect.length != 0) {
        List<Point_model> other_corners =
            extract_intersection_rect_corner(face1, face2);
        other_corners.forEach((element) {
          intersection_rect.add(element);
        });

        // print('other_corners :${other_corners.length}');
        // print('intersection_rect :${intersection_rect.length}');

        Line line = extract_join_line(intersection_rect, face1);

        join_line = Join_Line(line.end_point, line.start_point, "DRILL");
      }
      // for(int i=0;i<intersection_rect.length;i++){
      //   print("$i : X:${intersection_rect[i].x_coordinate} , Y:${intersection_rect[i].y_coordinate} , Z:${intersection_rect[i].z_coordinate}");
      // }
    }
    //
    // print("start point  X:${nested_points.start_point.x_coordinate} , Y:${nested_points.start_point.y_coordinate} ,Z:${nested_points.start_point.z_coordinate}");
    // print("end point    X:${nested_points.end_point.x_coordinate} , Y:${nested_points.end_point.y_coordinate} ,Z:${nested_points.end_point.z_coordinate}");

    return join_line;
  }

  /// nesting the points of intersection rectangle corners
  /// and add join line for both faces
  Line extract_join_line(List<Point_model> corners, Single_Face face_1) {
    late Line join_line;

    late Point_model join_line_start_point;
    late Point_model join_line_end_point;

    List<Point_model> l1 = [];
    List<Point_model> l2 = [];

    Point_model p1 = corners[0];
    String plane = face_plane(face_1);

    // print(plane);

    if (plane == "XY") {
      l1.add(p1);
      for (int i = 1; i < corners.length; i++) {
        if (p1.x_coordinate == corners[i].x_coordinate) {
          l2.add(corners[i]);
        } else if (p1.y_coordinate == corners[i].y_coordinate) {
          l1.add(corners[i]);
        }
      }

      bool xdir = l1[0].x_coordinate > l1[1].x_coordinate;
      bool ydir = l1[0].y_coordinate < l2[0].y_coordinate;

      double x_cord = xdir
          ? (l1[0].x_coordinate - (box_model.init_material_thickness) / 2)
          : (l1[0].x_coordinate + (box_model.init_material_thickness) / 2);

      join_line_start_point = Point_model(x_cord,
          ydir ? l1[0].y_coordinate : l2[0].y_coordinate, l1[0].z_coordinate);

      join_line_end_point = Point_model(x_cord,
          ydir ? l2[0].y_coordinate : l1[0].y_coordinate, l2[0].z_coordinate);
    } else if (plane == "XZ") {
      l1.add(p1);

      for (int i = 1; i < corners.length; i++) {
        if (p1.x_coordinate == corners[i].x_coordinate) {
          l2.add(corners[i]);
        } else {
          l1.add(corners[i]);
        }
      }

      bool xdir = l1[0].x_coordinate > l1[1].x_coordinate;
      bool zdir = l1[0].z_coordinate < l2[0].z_coordinate;

      double x_cord = xdir
          ? (l1[0].x_coordinate - (box_model.init_material_thickness) / 2)
          : (l1[0].x_coordinate + (box_model.init_material_thickness) / 2);

      join_line_start_point = Point_model(x_cord, l1[0].y_coordinate,
          zdir ? (l1[0].z_coordinate) : (l2[0].z_coordinate));
      join_line_end_point = Point_model(x_cord, l1[0].y_coordinate,
          (!zdir) ? (l1[0].z_coordinate) : (l2[0].z_coordinate));
    } else if (plane == "YZ") {
      l1.add(p1);
      for (int i = 1; i < corners.length; i++) {
        if (p1.z_coordinate == corners[i].z_coordinate) {
          l2.add(corners[i]);
        } else if (p1.y_coordinate == corners[i].y_coordinate) {
          l1.add(corners[i]);
        }
      }

      late bool join_axis_is_Z;
      if (l1[0].z_coordinate - l2[0].z_coordinate ==
          box_model.init_material_thickness) {
        join_axis_is_Z = false;
      } else {
        join_axis_is_Z = true;
      }
      late double y_cord_1;
      late double y_cord_2;
      if (join_axis_is_Z) {
        y_cord_1 = (l1[0].y_coordinate + l2[0].y_coordinate) / 2;
        y_cord_2 = y_cord_1;
      } else {
        if (l1[0].y_coordinate < l2[0].y_coordinate) {
          y_cord_1 = l1[0].y_coordinate;
          y_cord_2 = l2[0].y_coordinate;
        } else {
          y_cord_1 = l2[0].y_coordinate;
          y_cord_2 = l1[0].y_coordinate;
        }
      }

      late double z_cord_1;
      late double z_cord_2;

      if (join_axis_is_Z) {
        z_cord_1 = l1[0].z_coordinate;
        z_cord_2 = l1[1].z_coordinate;
      } else {
        if (l1[0].z_coordinate < l2[0].z_coordinate) {
          z_cord_1 = l1[0].z_coordinate;
          z_cord_2 = l2[0].z_coordinate;
        } else {
          z_cord_1 = l2[0].z_coordinate;
          z_cord_2 = l1[0].z_coordinate;
        }
      }

      join_line_start_point =
          Point_model(l1[0].x_coordinate, y_cord_1, z_cord_1);
      join_line_end_point = Point_model(l1[0].x_coordinate, y_cord_2, z_cord_2);

    }

    if (join_line_start_point.z_coordinate > join_line_end_point.z_coordinate) {
      join_line = Line(join_line_start_point, join_line_end_point);
    } else {
      join_line = Line(join_line_end_point, join_line_start_point);
    }

    return join_line;
  }

  /// here we will transform hte join line into bore hole
  /// 1-  first we need to detect the direction of face , if it horizontal or vertical
  /// 2-  detect length and axis of join line to pass it to next method
  /// 3-  handling the last parameters and add list of bore_model to the face

  add_drill_bores_to_faces() {
    for (int i = 0; i < box_model.box_pieces.length; i++) {
      Piece_model p = box_model.box_pieces[i];

      for (int f = 0; f < p.piece_faces.faces.length; f++) {
        Single_Face face = p.piece_faces.faces[f];

        for (int j = 0; j < face.joines.length; j++) {
          Join_Line join_line = face.joines[j];

          if (join_line.join_type == "DRILL") {
            Line line = Line(join_line.start_point, join_line.end_point);

            int second_face_id =
                detect_second_face(p.piece_name, p.piece_direction, face);
            Single_Face second_face = p.piece_faces.faces[second_face_id];

            transform_line_into_bores(
                line, p.piece_direction, face, second_face, p.piece_name);

            // print('piece : ${p.piece_name} , Face : ${face.name} , second face :${second_face.name}');
            // print('==========');
            //
          } else if (join_line.join_type == "Lamello") {}
        }
      }
    }
  }

  transform_line_into_bores(Line l, String piece_direction, Single_Face face,
      Single_Face second_face, String piece_name) {
    String join_line_axis = line_axis(l);
    double join_line_length = calculate_length_of_line(l, join_line_axis);
    String face_direction = detect_face_direction(piece_direction, face);

    TowFaceBoring towFaceBoring = TowFaceBoring([], []);

    // if (join_line_axis == "X") {
    //   towFaceBoring = add_bore_holes_X_axis(
    //       l.start_point, join_line_length, face_direction, face.name,piece_direction);
    // }
    // else if (join_line_axis == "Y") {
    //   towFaceBoring = add_bore_holes_Y_axis(
    //       l.start_point, join_line_length, face_direction, face.name,piece_direction , piece_name);
    // }
    // else
    if (join_line_axis == "Z") {
      towFaceBoring = add_bore_holes_Z_axis(l.start_point, join_line_length,
          face_direction, face.name, piece_direction);

      // print('element as json : ${towFaceBoring.H_bores.length}');
      //
      // for(Bore_model bm in towFaceBoring.H_bores){
      //   print('element : '
      //       ' x : ${bm.origin.x_coordinate} ,'
      //       ' y : ${bm.origin.y_coordinate} ,'
      //       ' z : ${bm.origin.z_coordinate} ,'
      //   );
      //   print('==========');
      // }

    }

    towFaceBoring.H_bores.forEach((element) {
      // print('element : '
      //     ' x : ${element.origin.x_coordinate} ,'
      //     ' y : ${element.origin.y_coordinate} ,'
      //     ' z : ${element.origin.z_coordinate} ,'
      // );
      // print('==========');
      face.bores.add(element);

    });

    if (face_direction != "V") {
      towFaceBoring.V_bores.forEach((element) {
        second_face.bores.add(element);
      });
    }
  }

  int detect_second_face(
      String piece_name, String piece_direction, Single_Face face) {
    int second_face_id = 0;

    if (piece_direction == "H") {
      if (box_model.box_type == "wall_cabinet") {
        if (piece_name == "top") {
          second_face_id = 0;
        }
      } else {
        second_face_id = 2;
      }
    } else if (piece_direction == "V") {
      if (piece_name == "left" || piece_name.contains("DBR")) {
        second_face_id = 1;
      } else {
        second_face_id = 3;
      }
    } else if (piece_direction == "F") {
      second_face_id = 5;
    }

    return second_face_id;
  }

  String detect_face_direction(String piece_direction, Single_Face face) {
    String face_direction = 'V';

    if (piece_direction == "H") {
      if (face.name == 2 ||
          face.name == 4 ||
          face.name == 5 ||
          face.name == 6) {
        face_direction = "H";
      } else if (face.name == 1) {
        face_direction = "V";
      } else if (face.name == 3) {
        face_direction = "B";
      }
    } else if (piece_direction == "V") {
      if (face.name == 1 ||
          face.name == 3 ||
          face.name == 5 ||
          face.name == 6) {
        face_direction = "H";
      } else if (face.name == 2) {
        face_direction = "V";
      } else if (face.name == 4) {
        face_direction = "B";
      }
    } else if (piece_direction == "F") {
      if (face.name == 1 ||
          face.name == 2 ||
          face.name == 3 ||
          face.name == 4) {
        face_direction = "H";
      } else if (face.name == 5) {
        face_direction = "V";
      } else if (face.name == 6) {
        face_direction = "B";
      }
    } else {
      face_direction = 'R';
    }

    return face_direction;
  }

  double calculate_length_of_line(Line line, String axis) {
    late double length;
    if (axis == "X") {
      length = line.end_point.x_coordinate - line.start_point.x_coordinate;
    } else if (axis == "Y") {
      length = line.end_point.y_coordinate - line.start_point.y_coordinate;
    } else if (axis == "Z") {
      length = line.end_point.z_coordinate - line.start_point.z_coordinate;
    }
    return length.abs();
  }

  //
  // TowFaceBoring add_bore_holes_X_axis(Point_model p, double join_line_length,
  //     String face_direction, int face_name,String piece_direction)
  // {
  //
  //   List<Bore_model> H_bores = [];
  //   List<Bore_model> V_bores = [];
  //
  //   double small_limit = draw_controller.box_repository.small_length_limit;
  //   double medium_limit = draw_controller.box_repository.medium_length_limit;
  //   double larg_limit = draw_controller.box_repository.larg_length_limit;
  //   double X_larg_limit = draw_controller.box_repository.larg_length_limit;
  //
  //   double small_start = draw_controller.box_repository.start_distence_small;
  //   double big_start = draw_controller.box_repository.start_distence_big;
  //
  //   Point_model origin = Point_model(p.x_coordinate, p.y_coordinate, p.z_coordinate);
  //
  //   if (join_line_length <= small_limit) {
  //
  //     if (face_direction == "H") {
  //
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate + small_start, origin.y_coordinate,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length / 2,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - small_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //
  //
  //       /// add vertical hole /////
  //       ///
  //       late double x_cordinate ;
  //       late double y_cordinate ;
  //       late double z_cordinate ;
  //
  //       if (piece_direction=="H") {
  //
  //           x_cordinate =origin.x_coordinate + join_line_length / 2;
  //           y_cordinate=origin.y_coordinate ;
  //
  //          if(face_name==5){
  //            z_cordinate=origin.z_coordinate + draw_controller.box_repository.minifix_distence;
  //
  //          }
  //          else if(face_name==6){
  //            z_cordinate=origin.z_coordinate - draw_controller.box_repository.minifix_distence;
  //
  //          }
  //
  //         Bore_model bv = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         V_bores.add(bv);
  //       }
  //       else if (piece_direction=="F") {
  //
  //         x_cordinate =origin.x_coordinate + join_line_length / 2;
  //         z_cordinate=origin.z_coordinate;
  //
  //         if(face_name==1){
  //           y_cordinate=origin.y_coordinate- draw_controller.box_repository.minifix_distence;
  //
  //         }
  //         else if(face_name==3){
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //
  //         }
  //
  //
  //
  //         Bore_model bv = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         V_bores.add(bv);
  //
  //       }
  //
  //
  //       ///     ////////////
  //       ///     ////////////
  //
  //
  //     }
  //     else if (face_direction == "V"||face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate + small_start, origin.y_coordinate,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length / 2,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - small_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     }
  //   }
  //
  //   else if (join_line_length > small_limit && join_line_length <= medium_limit) {
  //     if (face_direction == "H") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate + small_start, origin.y_coordinate,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length / 2,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - small_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //
  //       /// add vertical hole /////
  //       ///
  //       late double x_cordinate_1 ;
  //       late double x_cordinate_2 ;
  //       late double y_cordinate ;
  //       late double z_cordinate ;
  //
  //       if (piece_direction=="H") {
  //
  //         x_cordinate_1 =origin.x_coordinate +  small_start;
  //         x_cordinate_2 =origin.x_coordinate + join_line_length - small_start;
  //         y_cordinate=origin.y_coordinate ;
  //
  //         if(face_name==5){
  //           z_cordinate=origin.z_coordinate + draw_controller.box_repository.minifix_distence;
  //         }
  //         else if(face_name==6){
  //           z_cordinate=origin.z_coordinate - draw_controller.box_repository.minifix_distence;
  //         }
  //       }
  //       else if (piece_direction=="F") {
  //         x_cordinate_1 =origin.x_coordinate +  small_start;
  //         x_cordinate_2 =origin.x_coordinate + join_line_length - small_start;
  //         z_cordinate=origin.z_coordinate;
  //         if(face_name==1){
  //           y_cordinate=origin.y_coordinate- draw_controller.box_repository.minifix_distence;
  //         }
  //         else if(face_name==3){
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //         }
  //       }
  //       Bore_model bv_1 = Bore_model(
  //           Point_model(x_cordinate_1, y_cordinate,z_cordinate),
  //           draw_controller.box_repository.minifix_diameter,
  //           draw_controller.box_repository.minifix_depth);
  //       Bore_model bv_2 = Bore_model(
  //           Point_model(x_cordinate_2, y_cordinate,z_cordinate),
  //           draw_controller.box_repository.minifix_diameter,
  //           draw_controller.box_repository.minifix_depth);
  //
  //       V_bores.add(bv_1);
  //       V_bores.add(bv_2);
  //
  //       ///     ////////////
  //       ///     ////////////
  //
  //     }
  //     else if (face_direction == "V"||face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate + small_start, origin.y_coordinate,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length / 2,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - small_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     }
  //   }
  //
  //   else if (join_line_length > medium_limit && join_line_length < larg_limit) {
  //     if (face_direction == "H") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate + big_start, origin.y_coordinate,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate + big_start + 32,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length / 2,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - big_start - 32,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - big_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //
  //       /// add vertical hole /////
  //       ///
  //       late double x_cordinate_1 ;
  //       late double x_cordinate_2 ;
  //       late double y_cordinate ;
  //       late double z_cordinate ;
  //
  //       if (piece_direction=="H") {
  //
  //         x_cordinate_1 =origin.x_coordinate +  big_start;
  //         x_cordinate_2 =origin.x_coordinate + join_line_length - big_start;
  //         y_cordinate=origin.y_coordinate ;
  //
  //         if(face_name==5){
  //           z_cordinate=origin.z_coordinate + draw_controller.box_repository.minifix_distence;
  //         }
  //         else if(face_name==6){
  //           z_cordinate=origin.z_coordinate - draw_controller.box_repository.minifix_distence;
  //         }
  //       }
  //       else if (piece_direction=="F") {
  //         x_cordinate_1 =origin.x_coordinate +  big_start;
  //         x_cordinate_2 =origin.x_coordinate + join_line_length - big_start;
  //         z_cordinate=origin.z_coordinate;
  //         if(face_name==1){
  //           y_cordinate=origin.y_coordinate- draw_controller.box_repository.minifix_distence;
  //         }
  //         else if(face_name==3){
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //         }
  //       }
  //       Bore_model bv_1 = Bore_model(
  //           Point_model(x_cordinate_1, y_cordinate,z_cordinate),
  //           draw_controller.box_repository.minifix_diameter,
  //           draw_controller.box_repository.minifix_depth);
  //       Bore_model bv_2 = Bore_model(
  //           Point_model(x_cordinate_2, y_cordinate,z_cordinate),
  //           draw_controller.box_repository.minifix_diameter,
  //           draw_controller.box_repository.minifix_depth);
  //
  //       V_bores.add(bv_1);
  //       V_bores.add(bv_2);
  //
  //       ///     ////////////
  //       ///     ////////////
  //     }
  //     else if (face_direction == "V"||face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate + big_start, origin.y_coordinate,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate + big_start + 32,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length / 2,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - 32 - big_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - big_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //     }
  //   }
  //
  //   else if (join_line_length >= larg_limit) {
  //     if (face_direction == "H") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate + big_start, origin.y_coordinate,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate + big_start + 32,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length / 2,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - big_start - 32,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - big_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //
  //
  //       /// add vertical hole /////
  //       ///
  //       late double x_cordinate_1 ;
  //       late double x_cordinate_2 ;
  //       late double x_cordinate_3 ;
  //       late double y_cordinate ;
  //       late double z_cordinate ;
  //
  //       if (piece_direction=="H") {
  //
  //         x_cordinate_1 =origin.x_coordinate +  big_start;
  //         x_cordinate_2 =origin.x_coordinate + join_line_length - big_start;
  //         x_cordinate_3 =origin.x_coordinate + join_line_length/2;
  //         y_cordinate=origin.y_coordinate ;
  //
  //         if(face_name==5){
  //           z_cordinate=origin.z_coordinate + draw_controller.box_repository.minifix_distence;
  //         }
  //         else if(face_name==6){
  //           z_cordinate=origin.z_coordinate - draw_controller.box_repository.minifix_distence;
  //         }
  //       }
  //       else if (piece_direction=="F") {
  //         x_cordinate_1 =origin.x_coordinate +  big_start;
  //         x_cordinate_2 =origin.x_coordinate + join_line_length - big_start;
  //         x_cordinate_3 =origin.x_coordinate + join_line_length /2;
  //         z_cordinate=origin.z_coordinate;
  //         if(face_name==1){
  //           y_cordinate=origin.y_coordinate- draw_controller.box_repository.minifix_distence;
  //         }
  //         else if(face_name==3){
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //         }
  //       }
  //       Bore_model bv_1 = Bore_model(
  //           Point_model(x_cordinate_1, y_cordinate,z_cordinate),
  //           draw_controller.box_repository.minifix_diameter,
  //           draw_controller.box_repository.minifix_depth);
  //       Bore_model bv_2 = Bore_model(
  //           Point_model(x_cordinate_2, y_cordinate,z_cordinate),
  //           draw_controller.box_repository.minifix_diameter,
  //           draw_controller.box_repository.minifix_depth);
  //       Bore_model bv_3 = Bore_model(
  //           Point_model(x_cordinate_3, y_cordinate,z_cordinate),
  //           draw_controller.box_repository.minifix_diameter,
  //           draw_controller.box_repository.minifix_depth);
  //
  //       V_bores.add(bv_1);
  //       V_bores.add(bv_2);
  //       V_bores.add(bv_3);
  //
  //       ///     ////////////
  //       ///     ////////////
  //       ///
  //       ///
  //     } else if (face_direction == "V"||face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate + big_start, origin.y_coordinate,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate + big_start + 32,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length / 2,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - 32 - big_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate + join_line_length - big_start,
  //               origin.y_coordinate, origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //     }
  //   }
  //
  //
  //   TowFaceBoring towFaceBoring = TowFaceBoring(H_bores, V_bores);
  //
  //   return towFaceBoring;
  // }
  //
  // TowFaceBoring add_bore_holes_Y_axis(Point_model p, double join_line_length,
  //     String face_direction, int face_name,String piece_direction,String piece_name)
  // {
  //   List<Bore_model> H_bores = [];
  //   List<Bore_model> V_bores = [];
  //
  //   double small_limit = draw_controller.box_repository.small_length_limit;
  //   double medium_limit = draw_controller.box_repository.medium_length_limit;
  //   double larg_limit = draw_controller.box_repository.larg_length_limit;
  //   double X_larg_limit = draw_controller.box_repository.larg_length_limit;
  //
  //   double small_start = draw_controller.box_repository.start_distence_small;
  //   double big_start = draw_controller.box_repository.start_distence_big;
  //
  //   Point_model origin =
  //       Point_model(p.x_coordinate, p.y_coordinate, p.z_coordinate);
  //
  //   // if (join_line_length > small_start&& join_line_length < small_limit) {
  //   //   if (face_direction == "H") {
  //   //     Bore_model b2 = Bore_model(
  //   //         Point_model(
  //   //             origin.x_coordinate,
  //   //             origin.y_coordinate + join_line_length / 2,
  //   //             origin.z_coordinate),
  //   //         draw_controller.box_repository.wood_pen_diameter,
  //   //         draw_controller.box_repository.wood_pen_horizontal_depth);
  //   //
  //   //     H_bores.add(b2);
  //   //   }
  //   //   else if (face_direction == "V") {
  //   //     Bore_model b2 = Bore_model(
  //   //         Point_model(
  //   //             origin.x_coordinate,
  //   //             origin.y_coordinate + join_line_length / 2,
  //   //             origin.z_coordinate),
  //   //         draw_controller.box_repository.scew_nut_diameter,
  //   //         draw_controller.box_repository.scew_nut_depth);
  //   //     H_bores.add(b2);
  //   //   }
  //   //   else if (face_direction == "B") {
  //   //     Bore_model b2 = Bore_model(
  //   //         Point_model(
  //   //             origin.x_coordinate,
  //   //             origin.y_coordinate + join_line_length / 2,
  //   //             origin.z_coordinate),
  //   //         draw_controller.box_repository.scew_nut_diameter,
  //   //         draw_controller.box_repository.scew_nut_depth);
  //   //
  //   //     H_bores.add(b2);
  //   //   }
  //   // }
  //   // else
  //
  //     if (join_line_length <= small_limit) {
  //
  //     if (face_direction == "H") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate + small_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length / 2,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - small_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //
  //       /// add face hole block
  //
  //       late double x_cordinate ;
  //       late double y_cordinate ;
  //       late double z_cordinate ;
  //
  //
  //       if (piece_direction=="F") {
  //         if (face_name == 4)
  //         {
  //           x_cordinate = origin.x_coordinate + draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate+ join_line_length / 2;
  //           z_cordinate=origin.z_coordinate ;
  //         }
  //         else if (face_name == 2)
  //         {
  //           x_cordinate = origin.x_coordinate - draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate+ join_line_length / 2;
  //           z_cordinate=origin.z_coordinate ;
  //
  //         }
  //
  //         Bore_model bv = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         V_bores.add(bv);
  //       }
  //
  //       else if (piece_direction=="V") {
  //
  //         if (face_name == 5)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate=origin.y_coordinate + join_line_length / 2;
  //           z_cordinate=origin.z_coordinate + draw_controller.box_repository.minifix_distence;
  //
  //         }
  //         else if (face_name == 6)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate=origin.y_coordinate + join_line_length / 2;
  //           z_cordinate=origin.z_coordinate - draw_controller.box_repository.minifix_distence;
  //
  //         }
  //         Bore_model bv = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         V_bores.add(bv);
  //       }
  //
  //       /// ///////////////////
  //
  //
  //
  //     }
  //     else if (face_direction == "V") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate + small_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length / 2,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - small_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     }
  //     else if (face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate + small_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length / 2,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - small_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     }
  //   }
  //
  //
  //   else if (join_line_length > small_limit && join_line_length <= medium_limit) {
  //       late double y_cord_1;
  //       late double y_cord_center;
  //       late double y_cord_2;
  //
  //       bool drawer =false;
  //
  //
  //     if (face_direction == "H") {
  //       if(piece_name.contains("DF") ||piece_name.contains("DBL") ||piece_name.contains("DBR")){drawer=true;}
  //
  //
  //       if(drawer){
  //           y_cord_1=origin.y_coordinate + small_start+10;
  //           y_cord_center=origin.y_coordinate + join_line_length / 2+10;
  //           y_cord_2=origin.y_coordinate + join_line_length- small_start+10;
  //       }else{
  //          y_cord_1     =origin.y_coordinate + small_start;
  //          y_cord_center=origin.y_coordinate + join_line_length / 2;
  //          y_cord_2     =origin.y_coordinate+ join_line_length - small_start;
  //       }
  //
  //
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, y_cord_1,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               y_cord_center,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate ,
  //                y_cord_2,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //
  //       /// add face hole block
  //
  //       late double x_cordinate ;
  //       // late double y_cordinate_1 ;
  //       // late double y_cordinate_2 ;
  //       late double z_cordinate ;
  //
  //
  //       if (piece_direction=="F") {
  //         if (face_name == 4)
  //         {
  //           x_cordinate = origin.x_coordinate + draw_controller.box_repository.minifix_distence;
  //           // y_cordinate_1=origin.y_coordinate+ small_start;
  //           // y_cordinate_2=origin.y_coordinate+join_line_length- small_start;
  //           z_cordinate=origin.z_coordinate ;
  //         }
  //         else if (face_name == 2)
  //         {
  //           x_cordinate = origin.x_coordinate - draw_controller.box_repository.minifix_distence;
  //           // y_cordinate_1=origin.y_coordinate+ small_start;
  //           // y_cordinate_2=origin.y_coordinate+join_line_length- small_start;
  //           z_cordinate=origin.z_coordinate ;
  //
  //         }
  //
  //         Bore_model bv_1 = Bore_model(
  //             Point_model(x_cordinate,drawer?y_cord_center: y_cord_1,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_2 = Bore_model(
  //             Point_model(x_cordinate, y_cord_2,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         V_bores.add(bv_1);
  //        !drawer? V_bores.add(bv_2):print('');
  //       }
  //
  //       else if (piece_direction=="V") {
  //
  //         if (face_name == 5)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           // y_cordinate_1=origin.y_coordinate+ small_start;
  //           // y_cordinate_2=origin.y_coordinate+join_line_length- small_start;
  //           z_cordinate=origin.z_coordinate + draw_controller.box_repository.minifix_distence;
  //         }
  //         else if (face_name == 6)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           // y_cordinate_1=origin.y_coordinate+ small_start;
  //           // y_cordinate_2=origin.y_coordinate+join_line_length- small_start;
  //           z_cordinate=origin.z_coordinate- draw_controller.box_repository.minifix_distence ;
  //         }
  //         Bore_model bv_1 = Bore_model(
  //             Point_model(x_cordinate,drawer?y_cord_center: y_cord_1,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_2 = Bore_model(
  //             Point_model(x_cordinate, y_cord_2,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         V_bores.add(bv_1);
  //         !drawer? V_bores.add(bv_2):print('');
  //       }
  //
  //       /// ///////////////////
  //
  //     }
  //     else if (face_direction == "V" ||face_direction == "B") {
  //       if(piece_name.contains("DF")  ){drawer=true;}
  //
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate + small_start,
  //               origin.z_coordinate),
  //          !drawer? draw_controller.box_repository.scew_nut_diameter:draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length / 2,
  //               origin.z_coordinate),
  //            drawer? draw_controller.box_repository.scew_nut_diameter:draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - small_start,
  //               origin.z_coordinate),
  //           !drawer? draw_controller.box_repository.scew_nut_diameter:draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     }
  //
  //   }
  //
  //
  //   else if (join_line_length > medium_limit && join_line_length <= larg_limit) {
  //     if (face_direction == "H") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate + big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate,
  //               origin.y_coordinate + big_start + 32, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length / 2,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - big_start - 32,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //
  //       /// add face hole block
  //
  //       late double x_cordinate ;
  //       late double y_cordinate_1 ;
  //       late double y_cordinate_2 ;
  //       late double y_cordinate_3 ;
  //       late double z_cordinate ;
  //
  //
  //       if (piece_direction=="F") {
  //         if (face_name == 4)
  //         {
  //           x_cordinate = origin.x_coordinate + draw_controller.box_repository.minifix_distence;
  //           y_cordinate_1=origin.y_coordinate+ big_start;
  //           y_cordinate_2=origin.y_coordinate+join_line_length- big_start;
  //           y_cordinate_3=origin.y_coordinate+join_line_length/2;
  //           z_cordinate=origin.z_coordinate ;
  //         }
  //         else if (face_name == 2)
  //         {
  //           x_cordinate = origin.x_coordinate - draw_controller.box_repository.minifix_distence;
  //           y_cordinate_1=origin.y_coordinate+ big_start;
  //           y_cordinate_2=origin.y_coordinate+join_line_length- big_start;
  //           y_cordinate_3=origin.y_coordinate+join_line_length/2;
  //           z_cordinate=origin.z_coordinate ;
  //
  //         }
  //
  //         Bore_model bv_1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_1,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_2,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_3 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_3,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         V_bores.add(bv_1);
  //         V_bores.add(bv_2);
  //         V_bores.add(bv_3);
  //       }
  //
  //       else if (piece_direction=="V") {
  //
  //         if (face_name == 5)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate_1=origin.y_coordinate+ big_start;
  //           y_cordinate_2=origin.y_coordinate+join_line_length- big_start;
  //           y_cordinate_3=origin.y_coordinate+join_line_length/2;
  //           z_cordinate=origin.z_coordinate + draw_controller.box_repository.minifix_distence;
  //         }
  //         else if (face_name == 6)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate_1=origin.y_coordinate+ big_start;
  //           y_cordinate_2=origin.y_coordinate+join_line_length- big_start;
  //           y_cordinate_3=origin.y_coordinate+join_line_length/2;
  //           z_cordinate=origin.z_coordinate- draw_controller.box_repository.minifix_distence ;
  //         }
  //         Bore_model bv_1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_1,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_2,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_3 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_3,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         V_bores.add(bv_1);
  //         V_bores.add(bv_2);
  //         V_bores.add(bv_3);
  //       }
  //
  //       /// ///////////////////
  //       ///
  //     }
  //     else if (face_direction == "V" ||face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate + big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate,
  //               origin.y_coordinate + big_start + 32, origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length / 2,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - 32 - big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //     }
  //   }
  //
  //
  //   else if (join_line_length > larg_limit) {
  //
  //     if (face_direction == "H") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate + big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate,
  //               origin.y_coordinate + big_start + 32, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length / 2,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - big_start - 32,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //
  //       /// add face hole block
  //
  //       late double x_cordinate ;
  //       late double y_cordinate_1 ;
  //       late double y_cordinate_2 ;
  //       late double y_cordinate_3 ;
  //       late double z_cordinate ;
  //
  //
  //       if (piece_direction=="F") {
  //         if (face_name == 4)
  //         {
  //           x_cordinate = origin.x_coordinate + draw_controller.box_repository.minifix_distence;
  //           y_cordinate_1=origin.y_coordinate+ big_start;
  //           y_cordinate_2=origin.y_coordinate+join_line_length- big_start;
  //           y_cordinate_3=origin.y_coordinate+join_line_length/2;
  //           z_cordinate=origin.z_coordinate ;
  //         }
  //         else if (face_name == 2)
  //         {
  //           x_cordinate = origin.x_coordinate - draw_controller.box_repository.minifix_distence;
  //           y_cordinate_1=origin.y_coordinate+ big_start;
  //           y_cordinate_2=origin.y_coordinate+join_line_length- big_start;
  //           y_cordinate_3=origin.y_coordinate+join_line_length/2;
  //           z_cordinate=origin.z_coordinate ;
  //
  //         }
  //
  //         Bore_model bv_1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_1,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_2,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_3 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_3,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         V_bores.add(bv_1);
  //         V_bores.add(bv_2);
  //         V_bores.add(bv_3);
  //       }
  //
  //       else if (piece_direction=="V") {
  //
  //         if (face_name == 5)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate_1=origin.y_coordinate+ big_start;
  //           y_cordinate_2=origin.y_coordinate+join_line_length- big_start;
  //           y_cordinate_3=origin.y_coordinate+join_line_length/2;
  //           z_cordinate=origin.z_coordinate + draw_controller.box_repository.minifix_distence;
  //         }
  //         else if (face_name == 6)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate_1=origin.y_coordinate+ big_start;
  //           y_cordinate_2=origin.y_coordinate+join_line_length- big_start;
  //           y_cordinate_3=origin.y_coordinate+join_line_length/2;
  //           z_cordinate=origin.z_coordinate- draw_controller.box_repository.minifix_distence ;
  //         }
  //         Bore_model bv_1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_1,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_2,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv_3 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate_3,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         V_bores.add(bv_1);
  //         V_bores.add(bv_2);
  //         V_bores.add(bv_3);
  //       }
  //
  //       /// ///////////////////
  //       ///
  //
  //
  //     } else if (face_direction == "V"||face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate + big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate,
  //               origin.y_coordinate + big_start + 32, origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length / 2,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - 32 - big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(
  //               origin.x_coordinate,
  //               origin.y_coordinate + join_line_length - big_start,
  //               origin.z_coordinate),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //
  //     }
  //   }
  //
  //
  //
  //   TowFaceBoring towFaceBoring = TowFaceBoring(H_bores, V_bores);
  //
  //   return towFaceBoring;
  // }

  // TowFaceBoring add_bore_holes_Z_axis(Point_model p, double join_line_length,
  //     String face_direction, int face_name ,String piece_direction)
  // {
  //
  //   List<Bore_model> H_bores = [];
  //   List<Bore_model> V_bores = [];
  //
  //   double small_limit = draw_controller.box_repository.small_length_limit;
  //   double medium_limit = draw_controller.box_repository.medium_length_limit;
  //   double larg_limit = draw_controller.box_repository.larg_length_limit;
  //   double X_larg_limit = draw_controller.box_repository.larg_length_limit;
  //
  //   double small_start = draw_controller.box_repository.start_distence_small;
  //   double big_start = draw_controller.box_repository.start_distence_big;
  //
  //   Point_model origin = Point_model(p.x_coordinate, p.y_coordinate, p.z_coordinate);
  //
  //   if (join_line_length <= small_limit) {
  //
  //     if (face_direction == "H") {
  //
  //
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + small_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - small_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //
  //
  //       /// add face hole block
  //
  //       late double x_cordinate ;
  //       late double y_cordinate ;
  //       late double z_cordinate ;
  //
  //
  //       if (piece_direction=="H") {
  //         if (face_name == 4)
  //         {
  //           x_cordinate = origin.x_coordinate + draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate;
  //           z_cordinate=origin.z_coordinate + join_line_length / 2;
  //         }
  //         else if (face_name == 2)
  //         {
  //           x_cordinate = origin.x_coordinate - draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate;
  //           z_cordinate=origin.z_coordinate + join_line_length / 2;
  //
  //         }
  //         Bore_model bv = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         V_bores.add(bv);
  //       }
  //       else if (piece_direction=="V") {
  //
  //         if (face_name == 1)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate=origin.y_coordinate - draw_controller.box_repository.minifix_distence;
  //           z_cordinate=origin.z_coordinate + join_line_length / 2;
  //         }
  //         else if (face_name == 3)
  //         {
  //           x_cordinate = origin.x_coordinate;
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //           z_cordinate=origin.z_coordinate + join_line_length / 2;
  //
  //         }
  //         else if (face_name == 5)
  //         {
  //           x_cordinate = origin.x_coordinate;
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //           z_cordinate=origin.z_coordinate + join_line_length / 2;
  //
  //         }
  //         Bore_model bv = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         V_bores.add(bv);
  //       }
  //
  //       /// ///////////////////
  //
  //
  //     }
  //     else if (face_direction == "V") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + small_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - small_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     }
  //     else if (face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + small_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - small_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     }
  //
  //   }
  //
  //   else if (join_line_length > small_limit && join_line_length <= medium_limit) {
  //     if (face_direction == "H") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + small_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - small_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //
  //       late double x_cordinate ;
  //       late double y_cordinate ;
  //       late double z_cordinate_1 ;
  //       late double z_cordinate_2 ;
  //
  //       if (piece_direction=="H") {
  //         if (face_name == 4)
  //         {
  //           x_cordinate = origin.x_coordinate + draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate;
  //           z_cordinate_1=origin.z_coordinate + small_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //         }
  //         else if (face_name == 2)
  //         {
  //           x_cordinate = origin.x_coordinate - draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate;
  //           z_cordinate_1=origin.z_coordinate + small_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //
  //         }
  //         Bore_model bv1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_1),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_2),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         V_bores.add(bv1);
  //         V_bores.add(bv2);
  //
  //
  //
  //
  //       }
  //       else if (piece_direction=="V") {
  //
  //         if (face_name == 1)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate=origin.y_coordinate - draw_controller.box_repository.minifix_distence;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //         }
  //         else if (face_name == 3)
  //         {
  //           x_cordinate = origin.x_coordinate;
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //
  //         }
  //         Bore_model bv1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_1),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_2),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         V_bores.add(bv1);
  //         V_bores.add(bv2);
  //       }
  //
  //
  //
  //     } else if (face_direction == "V") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     } else if (face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //     }
  //   }
  //
  //   else if (join_line_length > medium_limit && join_line_length <= larg_limit) {
  //
  //     if (face_direction == "H") {
  //
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start + 32),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start - 32),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //
  //
  //       /// vertical hole ////
  //
  //       late double x_cordinate ;
  //       late double y_cordinate ;
  //       late double z_cordinate_1 ;
  //       late double z_cordinate_2 ;
  //       late double z_cordinate_3 ;
  //
  //       if (piece_direction=="H") {
  //         if (face_name == 4)
  //         {
  //           x_cordinate = origin.x_coordinate + draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //           z_cordinate_3=origin.z_coordinate + join_line_length/2;
  //         }
  //         else if (face_name == 2)
  //         {
  //           x_cordinate = origin.x_coordinate - draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //           z_cordinate_3=origin.z_coordinate + join_line_length/2;
  //
  //         }
  //         Bore_model bv1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_1),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_2),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         Bore_model bv3 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_3),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //
  //         V_bores.add(bv1);
  //         V_bores.add(bv2);
  //         V_bores.add(bv3);
  //
  //
  //
  //
  //       }
  //       else if (piece_direction=="V") {
  //
  //         if (face_name == 1)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate=origin.y_coordinate - draw_controller.box_repository.minifix_distence;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //           z_cordinate_3=origin.z_coordinate + join_line_length/2;
  //         }
  //         else if (face_name == 3)
  //         {
  //           x_cordinate = origin.x_coordinate;
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //           z_cordinate_3=origin.z_coordinate + join_line_length/2;
  //
  //         }
  //         Bore_model bv1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_1),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_2),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         Bore_model bv3 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_3),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         V_bores.add(bv1);
  //         V_bores.add(bv2);
  //         V_bores.add(bv3);
  //
  //       }
  //
  //
  //       /// /////////////////
  //
  //     } else if (face_direction == "V") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start + 32),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - 32 - big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //     } else if (face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start + 32),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - 32 - big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //     }
  //   }
  //
  //   else if (join_line_length >= larg_limit) {
  //     if (face_direction == "H") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start + 32),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start - 32),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_horizontal_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //
  //       /// vertical hole ////
  //
  //       late double x_cordinate ;
  //       late double y_cordinate ;
  //       late double z_cordinate_1 ;
  //       late double z_cordinate_2 ;
  //       late double z_cordinate_3 ;
  //
  //       if (piece_direction=="H") {
  //         if (face_name == 4)
  //         {
  //           x_cordinate = origin.x_coordinate + draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //           z_cordinate_3=origin.z_coordinate + join_line_length/2;
  //         }
  //         else if (face_name == 2)
  //         {
  //           x_cordinate = origin.x_coordinate - draw_controller.box_repository.minifix_distence;
  //           y_cordinate=origin.y_coordinate;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //           z_cordinate_3=origin.z_coordinate + join_line_length/2;
  //
  //         }
  //         Bore_model bv1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_1),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_2),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         Bore_model bv3 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_3),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //
  //         V_bores.add(bv1);
  //         V_bores.add(bv2);
  //         V_bores.add(bv3);
  //
  //
  //
  //
  //       }
  //       else if (piece_direction=="V") {
  //
  //         if (face_name == 1)
  //         {
  //           x_cordinate = origin.x_coordinate ;
  //           y_cordinate=origin.y_coordinate - draw_controller.box_repository.minifix_distence;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //           z_cordinate_3=origin.z_coordinate + join_line_length/2;
  //         }
  //         else if (face_name == 3)
  //         {
  //           x_cordinate = origin.x_coordinate;
  //           y_cordinate=origin.y_coordinate+ draw_controller.box_repository.minifix_distence;
  //           z_cordinate_1=origin.z_coordinate + big_start;
  //           z_cordinate_2=origin.z_coordinate + join_line_length - big_start;
  //           z_cordinate_3=origin.z_coordinate + join_line_length/2;
  //
  //         }
  //         Bore_model bv1 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_1),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //         Bore_model bv2 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_2),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         Bore_model bv3 = Bore_model(
  //             Point_model(x_cordinate, y_cordinate,z_cordinate_3),
  //             draw_controller.box_repository.minifix_diameter,
  //             draw_controller.box_repository.minifix_depth);
  //
  //         V_bores.add(bv1);
  //         V_bores.add(bv2);
  //         V_bores.add(bv3);
  //
  //       }
  //
  //
  //       /// /////////////////
  //
  //     } else if (face_direction == "V") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start + 32),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - 32 - big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //     } else if (face_direction == "B") {
  //       Bore_model b1 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b2 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + big_start + 32),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b3 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length / 2),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //       Bore_model b4 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - 32 - big_start),
  //           draw_controller.box_repository.wood_pen_diameter,
  //           draw_controller.box_repository.wood_pen_vertical_depth);
  //       Bore_model b5 = Bore_model(
  //           Point_model(origin.x_coordinate, origin.y_coordinate,
  //               origin.z_coordinate + join_line_length - big_start),
  //           draw_controller.box_repository.scew_nut_diameter,
  //           draw_controller.box_repository.scew_nut_depth);
  //
  //       H_bores.add(b1);
  //       H_bores.add(b2);
  //       H_bores.add(b3);
  //       H_bores.add(b4);
  //       H_bores.add(b5);
  //     }
  //   }
  //
  //
  //
  //   TowFaceBoring towFaceBoring = TowFaceBoring(H_bores, V_bores);
  //
  //   return towFaceBoring;
  // }

  TowFaceBoring add_bore_holes_Z_axis(Point_model origin, double join_line_length,
      String face_direction, int face_name, String piece_direction) {
    List<Bore_model> H_bores = [];
    List<Bore_model> V_bores = [];

    List<JoinHolePattern> my_patterns = draw_controller.box_repository.join_patterns;

    for (JoinHolePattern pattern in my_patterns) {
      if (join_line_length > pattern.min_length && join_line_length <= pattern.max_length) {

        List<Bore_unit> bore_units = pattern.apply_pattern(join_line_length);

        for (Bore_unit bore_unit in bore_units) {
          Bore_model side_bore_model = bore_unit.side_bore;
          // print('unit= ${bore_unit.toJson()}');

          if (face_direction == "H") {
            side_bore_model.origin= Point_model(origin.x_coordinate, origin.y_coordinate,
                origin.z_coordinate + bore_unit.pre_distence);

            H_bores.add(side_bore_model);

            // print('anlyze : $face_name'
            //     ' x : ${side_bore_model.origin.x_coordinate} ,'
            //     ' y : ${side_bore_model.origin.y_coordinate} ,'
            //     ' z : ${side_bore_model.origin.z_coordinate} ,'
            // );
            // print('================');


            /// add face bore
            if (bore_unit.have_face_bore) {
              Bore_model face_bore_model = bore_unit.face_bore;

              late double x_cordinate;
              late double y_cordinate;
              late double z_cordinate;

              if (piece_direction == "H") {
              if (face_name == 2) {

                x_cordinate = origin.x_coordinate - bore_unit.face_bore_distence;
                y_cordinate = origin.y_coordinate;
                z_cordinate = origin.z_coordinate + bore_unit.pre_distence;
              }
              else if (face_name == 4) {
                x_cordinate = origin.x_coordinate + bore_unit.face_bore_distence;
                y_cordinate = origin.y_coordinate;
                z_cordinate = origin.z_coordinate + bore_unit.pre_distence;
              }
            }
            else if (piece_direction == "V") {
                  if (face_name == 1) {
                    x_cordinate = origin.x_coordinate ;
                    y_cordinate = origin.y_coordinate - bore_unit.face_bore_distence;
                    z_cordinate = origin.z_coordinate + bore_unit.pre_distence;
                  }
              else if (face_name == 3) {
                    x_cordinate = origin.x_coordinate ;
                    y_cordinate = origin.y_coordinate + bore_unit.face_bore_distence;
                    z_cordinate = origin.z_coordinate + bore_unit.pre_distence;
                  }
            }
              face_bore_model.origin= Point_model(x_cordinate, y_cordinate, z_cordinate );
              V_bores.add(face_bore_model);
            }
          }
        }
        // print('#%#%#%#%#%#%#%#%');

        continue;
      }
    }

    for(Bore_model bm in  H_bores){
      print('after anlyze : '
          ' x : ${bm.origin.x_coordinate} ,'
          ' y : ${bm.origin.y_coordinate} ,'
          ' z : ${bm.origin.z_coordinate} ,'
      );
      print('==========');
    }


    TowFaceBoring towFaceBoring = TowFaceBoring(H_bores, V_bores);
    return towFaceBoring;
  }

  test() {
    ///extract_face_lines
    // Single_Face face = box_model.box_pieces[0].piece_faces.faces[0];
    // List<Line> lines=extract_face_lines(face);
    // for(int i=0;i<lines.length;i++){
    //   print('id :$i start: X=${lines[i].start_point.x_coordinate} Y=${lines[i].start_point.y_coordinate} Z=${lines[i].start_point.z_coordinate}  // '
    //       'end: X=${lines[i].end_point.x_coordinate} Y=${lines[i].end_point.y_coordinate} Z=${lines[i].end_point.z_coordinate}');
    // }
    //
    // print('piece 1 :${box_model.box_pieces[1].piece_name}');
    // print('piece 2 :${box_model.box_pieces[6].piece_name}');
    // //
    // Single_Face face1 = box_model.box_pieces[1].piece_faces.faces[2];
    // Single_Face face2 = box_model.box_pieces[12].piece_faces.faces[3];
    // for(int l=0;l<face2.corners.length;l++){
    //   print(
    //       'face :${face2.name} ,start: X=${face2.corners[l].x_coordinate} , Y=${face2.corners[l].y_coordinate}  , Z=${face2.corners[l].z_coordinate} ');
    //
    //
    //   print('=========================');
    // }

    //
    // check_tow_face_intersected(face2, face1);
    //
    // for(int l=0;l<extract_face_lines(face1).length;l++){
    //   Line l1 = extract_face_lines(face1)[l];
    //   print(
    //       'face 1 :${face1.name} , '
    //           'start: X=${l1.start_point.x_coordinate}  Z=${l1.start_point.z_coordinate}  // '
    //           'end: X=${l1.end_point.x_coordinate}   Z=${l1.end_point.z_coordinate}');
    //
    //
    //   print('=========================');
    // }
    //
    //
    // /// check all pieces joins
    // ///
    //    for(int i=0;i<box_model.box_pieces.length;i++){
    //
    //     Piece_model p = box_model.box_pieces[i];
    //     print("piece name : ${p.piece_name}");
    //   print("......");
    //   for(int f=0;f<p.piece_faces.faces.length;f++){
    //     Single_Face face = p.piece_faces.faces[f];
    //     print("face name : ${face.name} , face direction : ${detect_face_direction(p.piece_direction, face)}");
    //
    //     }
    //     print("......");
    //   }
    //   print("#################");
    //
    //
    // }
  }
}

///2840 lines