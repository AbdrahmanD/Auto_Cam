import 'dart:ui';

import 'package:auto_cam/Controller/Painters/Box_Painter.dart';
import 'package:auto_cam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam/Controller/View_3_D/three_D_Painter.dart';
import 'package:auto_cam/Controller/View_3_D/transform_controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Controller/Draw_Controllers/kdt_file.dart';
import 'package:auto_cam/View/Dialog_Boxes/Context_Menu_Dialogs/Main_Edit_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Draw_Controller extends GetxController {

  RxDouble drawing_scale = (0.8).obs;
  Rx<Size> screen_size = Size(800, 600).obs;
  Rx<Offset> mouse_position = Offset(0, 0).obs;

  Box_Repository box_repository = Get.find();
  int hover_id = 90;

  String box_type="wall_box";

  RxBool draw_3_D = false.obs;

  Box_model get_box() {
    return box_repository.box_model.value;
  }

  Box_Painter draw_Box() {

    Box_model box_model = get_box() ;
    double w = screen_size.value.width;
    hover_id_find(box_model);
    Box_Painter boxPainter = Box_Painter(box_model, drawing_scale.value,
        Size(w, screen_size.value.height), hover_id);
    return boxPainter;
  }

  three_D_Painter draw_3_D_box(){
    transform_controller transform=transform_controller(screen_size.value);

    three_D_Painter my_painter=transform.camera_cordinate_draw(screen_size.value);
    return my_painter;
  }

  add_Box(Box_model box_model) {
    box_repository.box_model.value = box_model;
    draw_Box();
  }

  /// here tow method :
  /// 1-hover_id_finder :
  ///      to loop around box pieces and check if the mouse cursor is hover on , using the second method : check_position
  /// 2-check_position :
  ///      this method  piece_model as parameter  and check if cursor hover on it .

  /// the first one :
  hover_id_find(Box_model box_model) {
    Point_model my_origin = box_model.box_origin;
    List<Piece_model> box_pieces = box_model.box_pieces;

    hover_id = 100;
    for (int i = 0; i < box_pieces.length; i++) {
      Piece_model p = box_pieces[i];
      if (p.piece_name.contains('back_panel')) {
        continue;
      } else if (check_position(p, my_origin)) {
        hover_id = i;
      }
    }

  }

  ///the second one :
  bool check_position(Piece_model p, Point_model my_origin) {
    bool is_hover = false;


    List<Point_model> piece_points = p.piece_faces.front_face.corners;

    double left_down_point_x = (my_origin.x_coordinate +
        piece_points[0].x_coordinate * drawing_scale.value);
    double left_down_point_y = (my_origin.y_coordinate -
        piece_points[0].y_coordinate * drawing_scale.value);

    double right_up_point_x = (my_origin.x_coordinate +
        piece_points[2].x_coordinate * drawing_scale.value);
    double right_up_point_y = (my_origin.y_coordinate -
        piece_points[2].y_coordinate * drawing_scale.value);

    double mouse_position_x = mouse_position.value.dx;
    double mouse_position_y = mouse_position.value.dy;

    bool x_compare = left_down_point_x < mouse_position_x &&
        mouse_position_x < right_up_point_x;

    bool y_compare = left_down_point_y > mouse_position_y &&
        mouse_position_y > right_up_point_y;

    if (x_compare && y_compare) {
      is_hover = true;
    }

    return is_hover;
  }



  /// general list will appear when the customer make long press out of any enner area
  String general_list()
  {
    String dialogs_titles = '';

    if (!(hover_id == 100)) {
      if (box_repository.box_model.value.box_pieces[hover_id].piece_name == 'inner') {
        dialogs_titles = 'Edit Box';
      } else {
        dialogs_titles = 'Edit Piece';
      }
    } else {
      dialogs_titles = 'properties';
    }
    return dialogs_titles;
  }

  /// Context list will appear when the customer make long press on one of enners areas
  /// this dialog will give customer all available choices as :
  /// add shelf , partition , door , or drawer
  Widget Context_list()
  {
    late Widget my_widget;

    if (!(hover_id == 100)) {
      if (box_repository.box_model.value.box_pieces[hover_id].piece_name ==
          'inner') {
        my_widget = Main_Edit_Dialog();
      } else {
        my_widget = Container(
          child: Text('pieces menu'),
        );
      }
    } else {
      my_widget = Container(
        child: Text('general menu'),
      );
    }

    return my_widget;
  }



  /// add shelf method
  add_shelf(
      double top_Distence, double frontage_Gap, double material_thickness,int quantity,String shelf_type)
  {
    box_repository.box_model.value.add_Shelf(hover_id, top_Distence, frontage_Gap, material_thickness,quantity,shelf_type
   , box_repository.box_model.value.bac_panel_distence + box_repository.box_model.value.back_panel_thickness);
    // print_pieces_coordinate();

  }


  /// add partition method
  add_partition(
      double top_Distence, double frontage_Gap, double material_thickness,int quantity,double back_distance)
  {
    box_repository.box_model.value.
    add_Partition(hover_id, top_Distence, frontage_Gap, material_thickness,quantity,back_distance);
    // print_pieces_coordinate();

  }



/// add door method
  add_door(Door_Model door_model){
    door_model.inner_id=hover_id;
    box_repository.box_model.value.add_door(door_model);
  }


/// extract executable files with xml extension  to use in this case with kdt drilling machine
  extract_xml_files(){

    DateTime dateTime =DateTime.now();
    String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";


    String box_name='(${box_repository.box_model.value.box_width}X${box_repository.box_model.value.box_height}X'
        '${box_repository.box_model.value.box_depth})-${date}';

    for (int i = 0; i < box_repository.box_model.value.box_pieces.length; i++) {
      if( box_repository.box_model.value.box_pieces[i].piece_name=="inner" ||
          box_repository.box_model.value.box_pieces[i].piece_name.contains("back_panel")||
          box_repository.box_model.value.box_pieces[i].piece_name.contains("base_panel")||
          box_repository.box_model.value.box_pieces[i].piece_name=="help_shelf"||
          box_repository.box_model.value.box_pieces[i].piece_inable==false||
          box_repository.box_model.value.box_pieces[i].is_changed==true
      ){
       continue;
      }else{
        kdt_file kdt=kdt_file(box_repository.box_model.value.box_pieces[i],box_repository.box_model.value.box_name);
      }

    }
  }


  /// this only debug mode method to get information off the box pieces
  print_pieces_coordinate() {

    for (int i = 0; i < box_repository.box_model.value.box_pieces.length; i++) {
      print('index : $i;; piece id :${box_repository.box_model.value.box_pieces[i].piece_id} ;; name  :${box_repository.box_model.value.box_pieces[i].piece_name}');
      print('height :  ${box_repository.box_model.value.box_pieces[i].   piece_height} ;;'
          ' width :  ${box_repository.box_model.value.box_pieces[i]     .piece_width}');
      print('thickness :  ${box_repository.box_model.value.box_pieces[i].piece_thickness}');
      print('quantity :  1');
      //
      // box_repository.box_model.value.box_pieces[i].piece_faces.top_face.face_item.forEach((element) {print('top   : $element');});
      // print('---------');
      // box_repository.box_model.value.box_pieces[i].piece_faces.right_face.face_item.forEach((element) {print('right : $element');});
      // print('---------');
      // box_repository.box_model.value.box_pieces[i].piece_faces.base_face .face_item.forEach((element) {print('base  : $element');});
      // print('---------');
      // box_repository.box_model.value.box_pieces[i].piece_faces.left_face .face_item.forEach((element) {print('left  : $element');});
      // print('---------');
      // print('(# Y #) = ${box_repository.box_model.value.box_pieces[i].piece_origin.y_coordinate}');
      print('---------');

    }
  }







}
