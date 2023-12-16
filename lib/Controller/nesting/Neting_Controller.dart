import 'dart:ui';

import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Nesting_Painter.dart';
import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:auto_cam/Model/Main_Models/CNC_Tool.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:get/get.dart';

class Neting_Controller extends GetxController {
  Draw_Controller draw_Controller = Get.find();

  // late List<Piece_model> pieces;
  // = draw_Controller.nesting_pieces();

  Rx<double> drawing_scale = 0.3.obs;
  Rx<Size> screen_size = Size(800, 600).obs;

  Rx<Offset> mouse_position = Offset(0, 0).obs;

  String hover_id = 'null';

  String selected_id = 'null';

  Rx<bool> hold_piece = true.obs;

  List<List<Point_model>> corners = [];
  List<Point_model> selected_box_corners = [];
  List<Point_model> all_corners = [];

  late Nesting_Pieces nest;

  List<CNC_Tool> used_cnc_tools=[];
 late double cut_tool_diameter;

  find_hover_id(List<Piece_model> pieces) {
    hover_id = 'null';
    for (int i = 0; i < pieces.length; i++) {
      Piece_model p = pieces[i];
      if (check_position(p)) {
        hover_id = p.piece_id;
      }
    }
  }

  ///the second one :
  bool check_position(Piece_model p) {
    bool is_hover = false;

    late double left_down_point_x;
    late double left_down_point_y;
    late double right_up_point_x;
    late double right_up_point_y;

    left_down_point_x = p.piece_origin.x_coordinate * drawing_scale.value;
    left_down_point_y = p.piece_origin.y_coordinate * drawing_scale.value;

    right_up_point_x = p.piece_origin.x_coordinate * drawing_scale.value +
        p.piece_width * drawing_scale.value;
    right_up_point_y = p.piece_origin.y_coordinate * drawing_scale.value +
        p.piece_height * drawing_scale.value;

    double mouse_position_x = mouse_position.value.dx - 40;
    double mouse_position_y =
        screen_size.value.height - mouse_position.value.dy;

    bool x_compare = left_down_point_x < mouse_position_x &&
        mouse_position_x < right_up_point_x;

    bool y_compare = left_down_point_y < mouse_position_y &&
        mouse_position_y < right_up_point_y;

    if (x_compare && y_compare) {
      is_hover = true;
    }

    // print('piece : ${p.piece_name}');
    // print(' Sx : ${left_down_point_x} , SY : ${left_down_point_y}');
    // print(' Ex : ${ right_up_point_x} , EY : ${ right_up_point_y}');
    // print(' mouseX : ${mouse_position_x} ,mouseY : ${mouse_position_y}');
    //
    //  print('x_compare: $x_compare , y_compare: $y_compare');
    //
    //  print('============');
    // print('\n\n ');

    return is_hover;
  }



  nesting_initilize() {
      cut_tool_diameter=draw_Controller.box_repository.cnc_tools[0].tool_diameter;

    List<Piece_model> my_pieces0 = draw_Controller.nesting_pieces();

    List<Piece_model> my_pieces= add_cutting_gap_to_pieces(my_pieces0);
    if(draw_Controller.box_repository.nesting_pieces_saves
        &&(my_pieces.length==draw_Controller.box_repository.nesting_pieces.container.pieces.length) ){
      nest=draw_Controller.box_repository.nesting_pieces;
    }
    else{

      my_pieces.forEach((element) {
        element.nested = false;
      });
      nest = Nesting_Pieces(my_pieces,draw_Controller.box_repository.cnc_tools[0].tool_diameter);

    }

  }

  List<Piece_model> add_cutting_gap_to_pieces(List<Piece_model> pieces){

    List<Piece_model> my_pieces =[];

     double cut_diameter=draw_Controller.box_repository.cnc_tools[0].tool_diameter;

    for(int i=0;i<pieces.length;i++){
      Point_model p1=pieces[i].piece_origin;
      Point_model p2=Point_model(pieces[i].piece_origin.x_coordinate+pieces[i].piece_width+cut_diameter, pieces[i].piece_origin.y_coordinate, 0);
      Point_model p3=Point_model(pieces[i].piece_origin.x_coordinate+pieces[i].piece_width+cut_diameter, pieces[i].piece_origin.y_coordinate+pieces[i].piece_height+cut_diameter, 0);
      Point_model p4=Point_model(pieces[i].piece_origin.x_coordinate, pieces[i].piece_origin.y_coordinate+pieces[i].piece_height+cut_diameter, 0);

      pieces[i].cutting_boarder=[p1,p2,p3,p4];


      my_pieces.add(pieces[i]);

    }


    return my_pieces;
  }


  Nesting_Painter draw_nested_sheet() {
    find_hover_id(nest.pieces);

    Nesting_Painter nesting_painter = Nesting_Painter(
        screen_size.value.width,
        screen_size.value.height,
        nest.container,
        mouse_position.value,
        hover_id,
        selected_id,
        drawing_scale.value,
        corners);

    return nesting_painter;
  }

  select_piece() {
    selected_id = hover_id;
  }

  mouse_left_click() {
    selected_id = hover_id;
  }

  flip_piece() {
    Piece_model p =
        nest.pieces.where((element) => element.piece_id == selected_id).first;

    double new_w = p.piece_height;
    double new_h = p.piece_width;
    p.piece_width = new_w;
    p.piece_height = new_h;
  }

  delete_piece() {
    nest.pieces.remove(
        nest.pieces.where((element) => element.piece_id == selected_id));
  }

  move_piece(Offset offset) {
    Piece_model p = nest.pieces.where((element) => element.piece_id == selected_id).first;

    // p.piece_origin = Point_model(
    //     (mouse_position.value.dx-40)/ drawing_scale.value,
    //     screen_size.value.height/ drawing_scale.value -
    //         mouse_position.value.dy / drawing_scale.value,
    //     p.piece_origin.z_coordinate);

    p.piece_origin.x_coordinate += offset.dx;
    p.piece_origin.y_coordinate += offset.dy;
  }

  snap_to_piece() {
    corners = [];
    selected_box_corners = [];
    all_corners = [];


    Point_model c1 = Point_model(nest.container.origin.dx, nest.container.origin.dy, 0);
    Point_model c2 = Point_model(c1.x_coordinate+nest.container.w,c1.y_coordinate,0);
    Point_model c3 = Point_model(c1.x_coordinate+nest.container.w,c1.y_coordinate+nest.container.h,0);
    Point_model c4 = Point_model(c1.x_coordinate                 ,c1.y_coordinate+nest.container.h,0);

     all_corners.add(c1);
     all_corners.add(c2);
     all_corners.add(c3);
     all_corners.add(c4);


    if (selected_id != 'null') {
      List<Piece_model> pieces = draw_Controller.nesting_pieces();
      Piece_model p = pieces.where((element) => element.piece_id == selected_id).first;

      Point_model c1 =Point_model(
          p.piece_origin.x_coordinate-cut_tool_diameter/2,
          p.piece_origin.y_coordinate-cut_tool_diameter/2,
          p.piece_origin.z_coordinate);

      Point_model c2 = Point_model(
          p.piece_origin.x_coordinate + p.piece_width+cut_tool_diameter/2,
          p.piece_origin.y_coordinate-cut_tool_diameter/2,
          p.piece_origin.z_coordinate);

      Point_model c3 = Point_model(
          p.piece_origin.x_coordinate + p.piece_width+cut_tool_diameter/2,
          p.piece_origin.y_coordinate + p.piece_height+cut_tool_diameter/2,
          p.piece_origin.z_coordinate);

      Point_model c4 = Point_model(
          p.piece_origin.x_coordinate-cut_tool_diameter/2,
          p.piece_origin.y_coordinate + p.piece_height+cut_tool_diameter/2,
          p.piece_origin.z_coordinate);

      selected_box_corners.add(c1);
      selected_box_corners.add(c2);
      selected_box_corners.add(c3);
      selected_box_corners.add(c4);

      for (int si = 0; si < pieces.length; si++) {
        if (pieces[si].piece_id == selected_id) {
          continue;
        } else {
          Piece_model sb = pieces[si];

          Point_model sc1 =Point_model(
              sb.piece_origin.x_coordinate-cut_tool_diameter/2,
              sb.piece_origin.y_coordinate-cut_tool_diameter/2,
              sb.piece_origin.z_coordinate);

          Point_model sc2 = Point_model(
              sb.piece_origin.x_coordinate + sb.piece_width+cut_tool_diameter/2,
              sb.piece_origin.y_coordinate-cut_tool_diameter/2,
              sb.piece_origin.z_coordinate);

          Point_model sc3 = Point_model(
              sb.piece_origin.x_coordinate + sb.piece_width+cut_tool_diameter/2,
              sb.piece_origin.y_coordinate + sb.piece_height+cut_tool_diameter/2,
              sb.piece_origin.z_coordinate);

          Point_model sc4 = Point_model(
              sb.piece_origin.x_coordinate-cut_tool_diameter/2,
              sb.piece_origin.y_coordinate + sb.piece_height+cut_tool_diameter/2,
              sb.piece_origin.z_coordinate);

          all_corners.add(sc1);
          all_corners.add(sc2);
          all_corners.add(sc3);
          all_corners.add(sc4);
        }
      }

      for (int i = 0; i < selected_box_corners.length; i++) {
        Point_model p = selected_box_corners[i];

        double x = p.x_coordinate;
        double y = p.y_coordinate;

        for (int t = 0; t < all_corners.length; t++) {
          Point_model tp = all_corners[t];

          double sx = tp.x_coordinate;
          double sy = tp.y_coordinate;

          bool x_compare = (x - sx).abs() < 50;
          bool y_compare = (y - sy).abs() < 50;

          if (x_compare && y_compare) {
            corners.add([p, tp]);
          }
        }
      }
    }
  }

  drag_piece(Offset offset) {
    if (selected_id != "null") {
      Piece_model p =
          nest.pieces.where((element) => element.piece_id == selected_id).first;

      p.piece_origin.x_coordinate += offset.dx / drawing_scale.value;
      p.piece_origin.y_coordinate -= offset.dy / drawing_scale.value;
      snap_to_piece();

    }
  }

  finish_draging() {
    bool a1 = corners.length != 0;
    bool a2 = selected_box_corners.length != 0;
    bool a3 = all_corners.length != 0;

    bool all = a1 && a2 && a3;
    if (selected_id != 'null' && all) {
      Point_model p1 = corners[0][0];
      Point_model p2 = corners[0][1];
      double x_value;
      double y_value;


      x_value = (p2.x_coordinate - p1.x_coordinate);
      y_value = (p2.y_coordinate - p1.y_coordinate);

      move_piece(Offset(x_value, y_value));

      selected_id = 'null';

      corners = [];
      selected_box_corners = [];
      all_corners = [];
    }



  }

  save_sheet(){

    draw_Controller.box_repository.nesting_pieces=nest;
    draw_Controller.box_repository.nesting_pieces_saves=true;


  }

  reset(){
    draw_Controller.box_repository.nesting_pieces_saves=false;

nesting_initilize();

  }


  add_tools_to_sheet(){}





}
