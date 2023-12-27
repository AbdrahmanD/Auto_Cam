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

  RxString hover_id = 'null'.obs;


  List<String> selected_pieces_ids = [];

  Rx<bool> hold_piece = true.obs;


  List<List<Point_model>> corners = [];
  List<Point_model> selected_box_corners = [];
  List<Point_model> all_corners = [];


  List<My_Sheet> sheets=[];

List<Nesting_Painter> nesting_painters=[];


  List<CNC_Tool> used_cnc_tools=[];
 late double cut_tool_diameter;


  nesting_initilize() {

    sheets=[];

    cut_tool_diameter=draw_Controller.box_repository.cnc_tools[0].tool_diameter;

    List<Piece_model> my_pieces0 = draw_Controller.nesting_pieces();

    List<Piece_model> my_pieces  = add_cutting_gap_to_pieces(my_pieces0);

    my_pieces.forEach((element) {
      element.nested = false;
    });



    List<Piece_model> remain_piece=my_pieces;

    while(remain_piece.length>0){

      Nesting_Pieces   nest = Nesting_Pieces(my_pieces,draw_Controller.box_repository.cnc_tools[0].tool_diameter);

      // print("nest.sheet_num = ${nest.nesting(my_pieces, container).nested_sheet.pieces.length}");

      My_Sheet container = My_Sheet("sheet=1",1222, 2440, Offset(0,0), []);



      Nested_and_Remained nested_and_remained = nest.nesting(remain_piece, container);

      remain_piece=nested_and_remained.remain_pieces;

      sheets.add(nested_and_remained.nested_sheet);

      nest.nesting(remain_piece, container);


    }

    draw_Controller.box_repository.repo_sheerts=sheets;
    // print("sheets.length : ${sheets[2].pieces.length}");


  }


  find_hover_id(List<Piece_model> pieces) {
    hover_id.value = 'null';
    for (int i = 0; i < pieces.length; i++) {
      Piece_model p = pieces[i];
      if (check_position(p)) {
        hover_id.value = p.piece_id;
      }
    }
   }

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


    return is_hover;
  }


  Piece_model selected_piece(int i){
    Piece_model p=draw_Controller.nesting_pieces().where((element) => element.piece_id==selected_pieces_ids[i]).first;

    return p;
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
  //
  // Nesting_Painter draw_nested_sheet( My_Sheet my_sheet , int shet_id ){
  //
  //   // My_Sheet my_sheet = nest.nesting(nest.all_pieces, container).nested_sheet;
  //
  //   Nesting_Painter nesting_painter= draw_nested_sheet_pattern(my_sheet,);
  //
  //   return nesting_painter;
  // }

  Nesting_Painter draw_selected_sheet() {

    My_Sheet sheet = sheets[0];

    // print("sheets = ${sheets.length}");
    // print("pieces= ${sheet.pieces.length}");
    // print("=============");

    find_hover_id(sheet.pieces);

    Nesting_Painter nesting_painter = Nesting_Painter(
        screen_size.value.width,
        screen_size.value.height,
        sheet,
        mouse_position.value,
        hover_id.value,
        selected_pieces_ids,
        drawing_scale.value,
        corners);

    return nesting_painter;

  }

  // select_piece() {
  //   selected_id = hover_id;
  // }

  mouse_left_click(bool sheft_hold) {

    if(hover_id=="null"){
      selected_pieces_ids=[];
    }else {
      if (sheft_hold) {
        selected_pieces_ids.add(hover_id.value);
      }else{
        if(selected_pieces_ids.length<2){
          selected_pieces_ids=[hover_id.value];

        }

      }
    }
  }

  flip_piece() {
     for(int i=0;i<selected_pieces_ids.length;i++){
       Piece_model p=selected_piece(i);
      double new_w = p.piece_height;
      double new_h = p.piece_width;
      p.piece_width = new_w;
      p.piece_height = new_h;
    }


  }

  // delete_piece() {
  //
  //   if(selected_pieces_ids.length==1){
  //
  //     nest.containers.pieces.removeWhere((element) => element.piece_id == selected_pieces_ids[0]);
  //
  //   }else{
  //
  //     for(int i=0;i<selected_pieces_ids.length;i++){
  //        nest.container.pieces.removeWhere((element) => element.piece_id == selected_pieces_ids[i]);
  //     }
  //
  //   }
  //
  //
  // }

  move_piece(Offset offset ) {


    for(int i=0;i<selected_pieces_ids.length;i++){

      Piece_model p=selected_piece(i);

      p.piece_origin.x_coordinate += offset.dx;
      p.piece_origin.y_coordinate += offset.dy;

    }




  }

  drag_piece(Offset offset ) {

    for(int i=0;i<selected_pieces_ids.length;i++){
      Piece_model p=selected_piece(i);
      // Piece_model p=sheets[0].pieces[2];

      p.piece_origin.x_coordinate += offset.dx / drawing_scale.value;
      p.piece_origin.y_coordinate -= offset.dy / drawing_scale.value;
      snap_to_piece();

    }

  }




  snap_to_piece() {
    corners = [];
    selected_box_corners = [];
    all_corners = [];


    Point_model c1 = Point_model(sheets[0].origin.dx,sheets[0].origin.dy, 0);
    Point_model c2 = Point_model(c1.x_coordinate+sheets[0].w,c1.y_coordinate,0);
    Point_model c3 = Point_model(c1.x_coordinate+sheets[0].w,c1.y_coordinate+sheets[0].h,0);
    Point_model c4 = Point_model(c1.x_coordinate                 ,c1.y_coordinate+sheets[0].h,0);

     all_corners.add(c1);
     all_corners.add(c2);
     all_corners.add(c3);
     all_corners.add(c4);


    if (selected_pieces_ids.length==1)
    {

      List<Piece_model> pieces = draw_Controller.nesting_pieces();
      Piece_model p = pieces.where((element) => element.piece_id == selected_pieces_ids[0]).first;

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
        if (pieces[si].piece_id == selected_pieces_ids[0]) {
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

    else{
      snap_grope_to_piece();
    }
  }

  List<Point_model>  detect_corners_of_selected_pieces(){

    List<Piece_model> selected_pieces=[];

    for(int i=0;i<sheets.length;i++){

      My_Sheet my_sheet = sheets[i];

      for(int t=0;t<my_sheet.pieces.length;t++){
        Piece_model p = my_sheet.pieces[i];
        if(selected_pieces_ids.contains(p.piece_id)){
          selected_pieces.add(p);
        }
      }



    }

    List<Point_model> my_corners=[];

    for(int si=0;si<selected_pieces.length;si++){
      Piece_model sb = selected_pieces[si];

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

      my_corners.add(sc1);
      my_corners.add(sc2);
      my_corners.add(sc3);
      my_corners.add(sc4);

    }

    double min_x=my_corners[0].x_coordinate;
    double min_y=my_corners[0].y_coordinate;
    double max_x=my_corners[0].x_coordinate;
    double max_y=my_corners[0].y_coordinate;




    for(int poi=1;poi<my_corners.length;poi++){

      if(my_corners[poi].x_coordinate<min_x){
        min_x=my_corners[poi].x_coordinate;
      }else if(my_corners[poi].x_coordinate>max_x){
        max_x=my_corners[poi].x_coordinate;
      }

      if(my_corners[poi].y_coordinate<min_y){
        min_y=my_corners[poi].y_coordinate;
      }else if(my_corners[poi].y_coordinate>max_y){
        max_y=my_corners[poi].y_coordinate;
      }


    }


    Point_model mc1=Point_model(min_x,min_y, 0);
    Point_model mc2=Point_model(max_x,min_y, 0);
    Point_model mc3=Point_model(min_x,max_y, 0);
    Point_model mc4=Point_model(max_x,max_y, 0);




    List<Point_model> selected_boxes_corners=[mc1, mc2, mc3, mc4];

    return selected_boxes_corners;
  }

  snap_grope_to_piece(){

    corners = [];
    selected_box_corners = [];
    all_corners = [];


    Point_model c1 = Point_model(sheets[0].origin.dx, sheets[0].origin.dy, 0);
    Point_model c2 = Point_model(c1.x_coordinate+sheets[0].w,c1.y_coordinate,0);
    Point_model c3 = Point_model(c1.x_coordinate+sheets[0].w,c1.y_coordinate+     sheets[0].h,0);
    Point_model c4 = Point_model(c1.x_coordinate                 ,c1.y_coordinate+sheets[0].h,0);

    all_corners.add(c1);
    all_corners.add(c2);
    all_corners.add(c3);
    all_corners.add(c4);


    List<Piece_model> pieces = draw_Controller.nesting_pieces();

    // Piece_model p = pieces.where((element) => element.piece_id == selected_pieces_ids[0]).first;
    //
    // Point_model c1 =Point_model(
    //     p.piece_origin.x_coordinate-cut_tool_diameter/2,
    //     p.piece_origin.y_coordinate-cut_tool_diameter/2,
    //     p.piece_origin.z_coordinate);
    //
    // Point_model c2 = Point_model(
    //     p.piece_origin.x_coordinate + p.piece_width+cut_tool_diameter/2,
    //     p.piece_origin.y_coordinate-cut_tool_diameter/2,
    //     p.piece_origin.z_coordinate);
    //
    // Point_model c3 = Point_model(
    //     p.piece_origin.x_coordinate + p.piece_width+cut_tool_diameter/2,
    //     p.piece_origin.y_coordinate + p.piece_height+cut_tool_diameter/2,
    //     p.piece_origin.z_coordinate);
    //
    // Point_model c4 = Point_model(
    //     p.piece_origin.x_coordinate-cut_tool_diameter/2,
    //     p.piece_origin.y_coordinate + p.piece_height+cut_tool_diameter/2,
    //     p.piece_origin.z_coordinate);
    //
    // selected_box_corners.add(c1);
    // selected_box_corners.add(c2);
    // selected_box_corners.add(c3);
    selected_box_corners=  detect_corners_of_selected_pieces();

    for (int si = 0; si < pieces.length; si++)
    {
      if (selected_pieces_ids.contains(pieces[si].piece_id)) {
        continue;
      }
      else
      {
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


  finish_draging( ) {

    bool a1 = corners.length != 0;
    bool a2 = selected_box_corners.length != 0;
    bool a3 = all_corners.length != 0;

    bool all = a1 && a2 && a3;

    if (selected_pieces_ids.length != 0 && all) {

      Point_model p1 = corners[0][0];
      Point_model p2 = corners[0][1];
      double x_value;
      double y_value;


      x_value = (p2.x_coordinate - p1.x_coordinate);
      y_value = (p2.y_coordinate - p1.y_coordinate);

      move_piece(Offset(x_value, y_value));

      selected_pieces_ids = [];

      corners = [];
      selected_box_corners = [];
      all_corners = [];
    }



  }

  save_sheet(){

    // draw_Controller.box_repository.nesting_pieces=nest;
    draw_Controller.box_repository.nesting_pieces_saves=true;


  }

  reset(){

    draw_Controller.box_repository.nesting_pieces_saves=false;
    nesting_initilize();

  }








}
