import 'dart:convert';
  import 'dart:io';

 import 'dart:math';

import 'package:auto_cam/Controller/Draw_Controllers/AnalyzeJoins.dart';
import 'package:auto_cam/Controller/Painters/Box_Painter.dart';
 import 'package:auto_cam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Filler_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Controller/Draw_Controllers/kdt_file.dart';
import 'package:auto_cam/Model/Main_Models/Support_Filler.dart';
 import 'package:auto_cam/View/Dialog_Boxes/Context_Menu_Dialogs/Main_Edit_Dialog.dart';
  import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:path_provider/path_provider.dart';

import '../../View/Dialog_Boxes/Context_Menu_Dialogs/Out_Box_Menu.dart';

class Draw_Controller extends GetxController {



  RxDouble drawing_scale = (0.9).obs;
  Rx<Size> screen_size = Size(800, 600).obs;
  Rx<Offset> mouse_position = Offset(0, 0).obs;

  Rx<Offset> start_select_window = Offset(0, 0).obs;
  Rx<Offset> end_select_window = Offset(0, 0).obs;
  RxBool select_window = false.obs;

  Box_Repository box_repository = Get.find();
  int hover_id = 100;

  RxList selected_id = [].obs;

  String box_type = "wall_cabinet";

  RxBool draw_3_D = false.obs;

  RxString view_port = 'F'.obs;

  Rx<Offset> box_move_offset = Offset(0, 0).obs;


  List<Point_model> corners_points=[];


  Draw_Controller() {
    read_pattern_files();

  }




  ///
  select_window_method(Offset offset, bool select) {
    if (select) {
      double sx=0;
      double sy=0;
      double ex=0;
      double ey=0;

      if(mouse_position.value.dx>offset.dx){sx=mouse_position.value.dx;ex=offset.dx;}
      if(mouse_position.value.dx<offset.dx){ex=mouse_position.value.dx;sx=offset.dx;}
      if(mouse_position.value.dy<offset.dy){sy=mouse_position.value.dy;ey=offset.dy;}
      if(mouse_position.value.dy>offset.dy){ey=mouse_position.value.dy;sy=offset.dy;}



      start_select_window.value = Offset(sx,sy);

      end_select_window.value = Offset(ex,ey);
    } else {
      start_select_window.value = Offset(0, 0);
      end_select_window.value = Offset(0, 0);
    }
  }

  select_piece_via_window() {
    Point_model my_origin = box_repository.box_model.value.box_origin;

    double ssx = start_select_window.value.dx;
    double ssy = start_select_window.value.dy;
    double esx = end_select_window.value.dx;
    double esy = end_select_window.value.dy;

    late double left_down_point_x;
    late double left_down_point_y;
    late double right_up_point_x;
    late double right_up_point_y;

    for (int i = 0; i < box_repository.box_model.value.box_pieces.length; i++) {
      Piece_model p = box_repository.box_model.value.box_pieces[i];

      if (view_port == 'F') {
        left_down_point_x = (my_origin.x_coordinate +
            p.piece_faces.faces[4].corners[0].x_coordinate *
                drawing_scale.value);
        left_down_point_y = (my_origin.y_coordinate -
            p.piece_faces.faces[4].corners[0].y_coordinate *
                drawing_scale.value);
        right_up_point_x = (my_origin.x_coordinate +
            p.piece_faces.faces[4].corners[2].x_coordinate *
                drawing_scale.value);
        right_up_point_y = (my_origin.y_coordinate -
            p.piece_faces.faces[4].corners[2].y_coordinate *
                drawing_scale.value);
      } else if (view_port == 'R') {
        left_down_point_x = (my_origin.x_coordinate +
            p.piece_faces.faces[1].corners[0].z_coordinate *
                drawing_scale.value);
        left_down_point_y = (my_origin.y_coordinate -
            p.piece_faces.faces[1].corners[0].y_coordinate *
                drawing_scale.value);
        right_up_point_x = (my_origin.x_coordinate +
            p.piece_faces.faces[1].corners[2].z_coordinate *
                drawing_scale.value);
        right_up_point_y = (my_origin.y_coordinate -
            p.piece_faces.faces[1].corners[2].y_coordinate *
                drawing_scale.value);
      } else if (view_port == 'T') {
        left_down_point_x = (my_origin.x_coordinate +
            p.piece_faces.faces[0].corners[0].x_coordinate *
                drawing_scale.value);
        left_down_point_y = (my_origin.y_coordinate -
            p.piece_faces.faces[0].corners[0].z_coordinate *
                drawing_scale.value);
        right_up_point_x = (my_origin.x_coordinate +
            p.piece_faces.faces[0].corners[2].x_coordinate *
                drawing_scale.value);
        right_up_point_y = (my_origin.y_coordinate -
            p.piece_faces.faces[0].corners[2].z_coordinate *
                drawing_scale.value);
      }

      bool x_compare = right_up_point_x < ssx && left_down_point_x > esx;
      bool y_compare = right_up_point_y > ssy && left_down_point_y < esy;

      if (x_compare &&
          y_compare
          // && !p.piece_name.contains('inner')
      // &&
          // !p.piece_name.contains('back_panel') &&
          // !p.piece_name.contains('Helper')
      ) {
        selected_id.add(i);
      }
    }

    start_select_window.value = Offset(0, 0);
    end_select_window.value = Offset(0, 0);
  }

  ///

  select_piece(Offset offset) {
    if (hover_id != 100) {
      if (
      !box_repository.box_model.value.box_pieces[hover_id].piece_name.contains('inner') &&
      !box_repository.box_model.value.box_pieces[hover_id].piece_name.contains('Helper')

      )
      {
        if (!selected_id.contains(hover_id)) {
          selected_id.add(hover_id);
        }
      }
    } else {
      selected_id.value = [];
    }
  }

  Box_model get_box() {
    return box_repository.box_model.value;
  }

  Box_Painter draw_Box() {

    Box_model box_model = get_box();

     hover_id_find(box_model);

    Box_Painter boxPainter = Box_Painter(
        box_model,
        drawing_scale.value,
        Size(screen_size.value.width, screen_size.value.height),
        hover_id,
        selected_id,
        view_port.value,
        start_select_window.value,
        end_select_window.value,
        // corners_points
    );
    return boxPainter;
  }

  add_Box(Box_model box_model) {
    // box_repository.box_model.value = box_model;

    box_repository.add_box_to_repo(box_model);
    anlyze_inners();

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
      if ((p.piece_name.contains('back_panel')&&view_port=="F") ||
          p.piece_name.contains('Door')) {
        continue;
      } else if (check_position(p, my_origin)) {
        hover_id = i;
      }
    }
  }

  ///the second one :
  bool check_position(Piece_model p, Point_model my_origin) {
    bool is_hover = false;

    late double left_down_point_x;
    late double left_down_point_y;
    late double right_up_point_x;
    late double right_up_point_y;

    if (view_port == 'F') {
      left_down_point_x = (my_origin.x_coordinate +
          p.piece_faces.faces[4].corners[0].x_coordinate * drawing_scale.value);
      left_down_point_y = (my_origin.y_coordinate -
          p.piece_faces.faces[4].corners[0].y_coordinate * drawing_scale.value);
      right_up_point_x = (my_origin.x_coordinate +
          p.piece_faces.faces[4].corners[2].x_coordinate * drawing_scale.value);
      right_up_point_y = (my_origin.y_coordinate -
          p.piece_faces.faces[4].corners[2].y_coordinate * drawing_scale.value);
    } else if (view_port == 'R') {
      left_down_point_x = (my_origin.x_coordinate +
          p.piece_faces.faces[1].corners[0].z_coordinate * drawing_scale.value);
      left_down_point_y = (my_origin.y_coordinate -
          p.piece_faces.faces[1].corners[0].y_coordinate * drawing_scale.value);
      right_up_point_x = (my_origin.x_coordinate +
          p.piece_faces.faces[1].corners[2].z_coordinate * drawing_scale.value);
      right_up_point_y = (my_origin.y_coordinate -
          p.piece_faces.faces[1].corners[2].y_coordinate * drawing_scale.value);
    } else if (view_port == 'T') {
      left_down_point_x = (my_origin.x_coordinate +
          p.piece_faces.faces[0].corners[0].x_coordinate * drawing_scale.value);
      left_down_point_y = (my_origin.y_coordinate -
          p.piece_faces.faces[0].corners[0].z_coordinate * drawing_scale.value);
      right_up_point_x = (my_origin.x_coordinate +
          p.piece_faces.faces[0].corners[2].x_coordinate * drawing_scale.value);
      right_up_point_y = (my_origin.y_coordinate -
          p.piece_faces.faces[0].corners[2].z_coordinate * drawing_scale.value);
    }

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
  String general_list() {
    String dialogs_titles = '';

    if (!(hover_id == 100)) {
      if (box_repository.box_model.value.box_pieces[hover_id].piece_name.contains('inner')
          ) {
        dialogs_titles = 'Edit Box';
      } else {
        dialogs_titles = 'Edit Piece';
      }
    } else {
      dialogs_titles = 'properties';
    }
    return dialogs_titles;
  }

  /// Context list will appear when the customer make long press on one of inner areas
  /// this dialog will give customer all available choices as :
  /// add shelf , partition , door ,  drawer , or filler
  Widget Context_list() {
    late Widget my_widget;

    if (!(hover_id == 100)) {
      if (box_repository.box_model.value.box_pieces[hover_id].piece_name.contains('inner')) {
        my_widget = Main_Edit_Dialog();
      } else {
        my_widget = Container(
          child: Text('pieces menu'),
        );
      }
    } else {
      my_widget = Container(
        child: Out_Box_Menu(),
      );
    }

    return my_widget;
  }

  /// add shelf method
  add_shelf(double top_Distence, double frontage_Gap, double material_thickness,
      int quantity, String shelf_type) {

    double back_panel_distance=0;
    if(box_repository.back_panel_type=="groove"){
      back_panel_distance= box_repository.box_model.value.bac_panel_distence +
          box_repository.box_model.value.back_panel_thickness;
    }
    box_repository.box_model.value.add_Shelf(
        hover_id,
        frontage_Gap,
      back_panel_distance,
        material_thickness,
      top_Distence,

      quantity,
        shelf_type,
      );
    // print_pieces_coordinate();

    // Box_model b = box_repository.box_model.value;
    // Box_model nb = Box_model(
    //     b.box_name,
    //     box_type,
    //     b.box_width,
    //     b.box_height,
    //     b.box_depth,
    //     b.init_material_thickness,
    //     b.init_material_name,
    //     b.back_panel_thickness,
    //     b.grove_value,
    //     b.bac_panel_distence,
    //     b.top_base_piece_width,
    //     b.is_back_panel,
    //     b.box_origin);
    // nb.piece_id = b.piece_id;
    // nb.box_pieces = b.box_pieces;
    // add_Box(nb);

    anlyze_inners();

    draw_Box();
  }

  /// add partition method
  add_partition(
      double left_Distence,
      double frontage_Gap,
      double material_thickness,
      int quantity,
       bool helper) {

    double back_panel_distance=0;
    if(box_repository.back_panel_type=="groove"){
      back_panel_distance= box_repository.box_model.value.bac_panel_distence +
          box_repository.box_model.value.back_panel_thickness;
    }

    box_repository.box_model.value.add_Partition(hover_id,frontage_Gap,back_panel_distance,material_thickness,
        left_Distence,
          quantity,  helper?"Help_partition":"partition");
    //
    // Box_model b = box_repository.box_model.value;
    // Box_model nb = Box_model(
    //     b.box_name,
    //     box_type,
    //     b.box_width,
    //     b.box_height,
    //     b.box_depth,
    //     b.init_material_thickness,
    //     b.init_material_name,
    //     b.back_panel_thickness,
    //     b.grove_value,
    //     b.bac_panel_distence,
    //     b.top_base_piece_width,
    //     b.is_back_panel,
    //     b.box_origin);
    // nb.piece_id = b.piece_id;
    // nb.box_pieces = b.box_pieces;
    // add_Box(nb);
    anlyze_inners();

    draw_Box();
  }


  /// add support
  add_support(Support_Filler support_filler, int quantity) {
    if (support_filler.vertical) {
      box_repository.box_model.value.add_vertical_support(
          hover_id,
          support_filler.left_distance,
          support_filler.width,
          support_filler.thickness,
          quantity);
    } else {
      box_repository.box_model.value.add_horizontal_support(
          hover_id,
          support_filler.left_distance,
          support_filler.width,
          support_filler.thickness,
          quantity);
    }
    anlyze_inners();

    draw_Box();
  }

  // add_filler(Filler_model filler_model) {
  //   box_repository.box_model.value.add_filler(filler_model, hover_id);
  //   draw_Box();
  // }

  /// add door method
  add_door(Door_Model door_model) {
    door_model.inner_id = hover_id;
    box_repository.box_model.value.add_door(door_model);
  }

  /// add panel
  add_fix_panel(double piece_thickness, String material_name, int corner) {

    String piece_id = box_repository.box_model.value.get_id("Fix Panel");
    String piece_name = "Fix_panel_$piece_id";
    double piece_width = box_repository.box_model.value.box_depth;
    late double piece_height;
    if (corner == 1 || corner == 3) {
      piece_height = box_repository.box_model.value.box_width;
    } else if (corner == 2 || corner == 4) {
      piece_height = box_repository.box_model.value.box_height;
    }

    Piece_model p = box_repository.box_model.value.box_pieces
        .where((element) => element.piece_name == "left")
        .first;
    Point_model ref_origin = p.piece_origin;

    double w = box_repository.box_model.value.box_width;
    double h = box_repository.box_model.value.box_height;

    late String piece_direction;
    late Point_model fix_origin;

    if (corner == 1) {
      fix_origin = Point_model(ref_origin.x_coordinate,
          ref_origin.y_coordinate + h, ref_origin.z_coordinate);
      piece_direction = "H";
    } else if (corner == 2) {
      fix_origin = Point_model(ref_origin.x_coordinate + w,
          ref_origin.y_coordinate, ref_origin.z_coordinate);
      piece_direction = "V";
    } else if (corner == 3) {
      fix_origin = Point_model(ref_origin.x_coordinate,
          ref_origin.y_coordinate - piece_thickness, ref_origin.z_coordinate);
      piece_direction = "H";
    } else if (corner == 4) {
      fix_origin = Point_model(ref_origin.x_coordinate - piece_thickness,
          ref_origin.y_coordinate, ref_origin.z_coordinate);
      piece_direction = "V";
    }

    Piece_model piece_model = Piece_model(piece_id, piece_name, piece_direction,
        material_name, piece_width, piece_height, piece_thickness, fix_origin);
    box_repository.box_model.value.box_pieces.add(piece_model);
    anlyze_inners();

    draw_Box();

  }


  /// add back panel

  add_back_banel(String back_panel_type , String back_panel_material_name ,double material_thickness,double back_distance , double groove_depth){

    if(back_panel_type=="groove")
    {


      Piece_model  back_panel = Piece_model(
              box_repository.box_model.value.get_id("BP"),
              'back_panel',
              'F',
          box_repository.box_model.value.init_material_name,
              correct_value(box_repository.box_model.value.box_width-2*box_repository.box_model.value.init_material_thickness+2*groove_depth-1),
              correct_value(box_repository.box_model.value.box_height-2*box_repository.box_model.value.init_material_thickness+2*groove_depth-1),
              correct_value(material_thickness),
              Point_model(
                  correct_value(box_repository.box_model.value.init_material_thickness-groove_depth+1),
                  correct_value(box_repository.box_model.value.init_material_thickness-groove_depth+1 ),
                  correct_value(box_repository.box_model.value.box_depth-back_distance-material_thickness)
              )
          );

      Piece_model  back_panel_Helper = Piece_model(
          box_repository.box_model.value.get_id("BP"),
          'back_panel_Helper',
          'F',
          box_repository.box_model.value.init_material_name,
          correct_value(box_repository.box_model.value.box_width-2*box_repository.box_model.value.init_material_thickness),
          correct_value(box_repository.box_model.value.box_height-2*box_repository.box_model.value.init_material_thickness),
          correct_value(material_thickness),
          Point_model(
              correct_value(box_repository.box_model.value.init_material_thickness),
              correct_value(box_repository.box_model.value.init_material_thickness ),
              correct_value(box_repository.box_model.value.box_depth-back_distance-material_thickness)
          )
      );


      box_repository.box_model.value.box_pieces.add(back_panel);
      box_repository.box_model.value.box_pieces.add(back_panel_Helper);

    }
    else if(back_panel_type=="full_cover"){
      Piece_model back_panel=Piece_model(
          box_repository.box_model.value.get_id("back_panel"),
          "full cover back_panel",
          "F",
          back_panel_material_name,
          box_repository.box_model.value.box_width,
          box_repository.box_model.value.box_height,
          material_thickness,
          Point_model(
              0,
              0,
              0+box_repository.box_model.value.box_depth
          )
      );

      box_repository.box_model.value.box_pieces.add(back_panel);
      box_repository.back_panel_type=back_panel_type;

    }



  }




  /// delete piece
  delete_piece() {
    Box_model b = box_repository.box_model.value;

    Piece_model p = b.box_pieces.where((element) => element.piece_id==b.box_pieces[selected_id[0]].piece_id).first;
if(selected_id.length==1){

  //
  // ///


  //
  // if (!(
  // b.box_pieces[selected_id[0]].piece_name.contains("left") ||
  // b.box_pieces[selected_id[0]].piece_name.contains("right") ||
  // b.box_pieces[selected_id[0]].piece_name.contains("top") ||
  // b.box_pieces[selected_id[0]].piece_name.contains("base")
  //
  // )){
  //
  //   String inner_1="${b.box_pieces[selected_id[0]].enner_name}_1";
  //   String inner_2="${b.box_pieces[selected_id[0]].enner_name}_2";
  //   Piece_model old_inner=b.box_deleted_pieces.
  //   where((element) => element.piece_name==b.box_pieces[selected_id[0]].enner_name).first;
  //
  //   b.box_pieces.removeWhere((element) => element.piece_name==inner_1);
  //   b.box_pieces.removeWhere((element) => element.piece_name==inner_2);
  //
  //
  //   b.box_pieces .add(old_inner);
  //
  // }




  box_repository.box_model.value.box_pieces.remove(p);

  box_repository.add_box_to_repo(b);
  selected_id.value = [];
  draw_Box();

   }

    anlyze_inners();

  }

  move_piece(double x_move_value, double y_move_value) {
    Box_model b = box_repository.box_model.value;

    ///

    double dx = 0;
    double dy = 0;
    double dz = 0;

    if (view_port == 'F') {
      /// move X
      dx = x_move_value;

      /// move Y
      dy = y_move_value;
    } else if (view_port == 'R') {
      /// move Y
      dy = y_move_value;

      /// move Z
      dz = x_move_value;
    } else if (view_port == 'T') {
      /// move X
      dx = x_move_value;

      /// move Z
      dz = y_move_value;
    }

    if (selected_id.length==1) {
      Piece_model p = box_repository.box_model.value.box_pieces[selected_id[0]];

      for (int i = 0; i < 4; i++) {

        //
        // p.piece_faces.faces[0].corners[i].x_coordinate += dx;
        // p.piece_faces.faces[0].corners[i].y_coordinate += dy;
        // p.piece_faces.faces[0].corners[i].z_coordinate += dz;
        //
        // p.piece_faces.faces[1].corners[i].x_coordinate += dx;
        // p.piece_faces.faces[1].corners[i].y_coordinate += dy;
        // p.piece_faces.faces[1].corners[i].z_coordinate += dz;
        //
        // p.piece_faces.faces[2].corners[i].x_coordinate += dx;
        // p.piece_faces.faces[2].corners[i].y_coordinate += dy;
        // p.piece_faces.faces[2].corners[i].z_coordinate += dz;
        //
        // p.piece_faces.faces[3].corners[i].x_coordinate += dx;
        // p.piece_faces.faces[3].corners[i].y_coordinate += dy;
        // p.piece_faces.faces[3].corners[i].z_coordinate += dz;

        p.piece_faces.faces[4].corners[i].x_coordinate += dx;
        p.piece_faces.faces[4].corners[i].y_coordinate += dy;
        p.piece_faces.faces[4].corners[i].z_coordinate += dz;

        p.piece_faces.faces[5].corners[i].x_coordinate += dx;
        p.piece_faces.faces[5].corners[i].y_coordinate += dy;
        p.piece_faces.faces[5].corners[i].z_coordinate += dz;
      }
      p.piece_origin.x_coordinate += dx;
      p.piece_origin.y_coordinate += dy;
      p.piece_origin.z_coordinate += dz;

      // String inner_1="${b.box_pieces[selected_id[0]].enner_name}_1";
      // String inner_2="${b.box_pieces[selected_id[0]].enner_name}_2";
      //
      // Piece_model orgin_inner_1=b.box_pieces.where((element) => element.piece_name==inner_1).first;
      // Piece_model orgin_inner_2=b.box_pieces.where((element) => element.piece_name==inner_2).first;
      //
      // //
      // // print("orgin_inner_1 : ${orgin_inner_1.piece_name}");
      // // print("orgin_inner_2 : ${orgin_inner_2.piece_name}");
      // //
      //
      //
      // // Piece_model new_inner_1=orgin_inner_1;
      // // Piece_model new_inner_2=orgin_inner_2;
      //   //
      //   // new_inner_1.piece_width+=dx;
      //   // new_inner_1.piece_height-=dy;
      //   // new_inner_1.piece_thickness-=dz;
      //   //
      //   //
      //   // new_inner_2.piece_width-=    dx;
      //   // new_inner_2.piece_height+=   dy;
      //   // new_inner_2.piece_thickness+=dz;
      //   //
      //
      //   Piece_model n_inner_1=Piece_model(
      //       orgin_inner_1.piece_id,
      //       orgin_inner_1.piece_name,
      //       orgin_inner_1.piece_direction,
      //       orgin_inner_1.material_name,
      //       orgin_inner_1.piece_width+dx,
      //       orgin_inner_1.piece_height+dy,
      //       orgin_inner_1.piece_thickness+dz,
      //       Point_model(
      //           orgin_inner_1.piece_origin.x_coordinate,
      //           orgin_inner_1.piece_origin.y_coordinate,
      //           orgin_inner_1.piece_origin.z_coordinate
      //       ),
      //       orgin_inner_1.enner_name);
      //
      // Piece_model n_inner_2=Piece_model(
      //     orgin_inner_2.piece_id,
      //     orgin_inner_2.piece_name,
      //     orgin_inner_2.piece_direction,
      //     orgin_inner_2.material_name,
      //     orgin_inner_2.piece_width-dx,
      //     orgin_inner_2.piece_height-dy,
      //     orgin_inner_2.piece_thickness-dz,
      //     Point_model(
      //         orgin_inner_2.piece_origin.x_coordinate+dx,
      //         orgin_inner_2.piece_origin.y_coordinate+dy,
      //         orgin_inner_2.piece_origin.z_coordinate+dz
      //     ),
      //     orgin_inner_1.enner_name);
      //
      //
      //
      //   box_repository.box_model.value.box_pieces.removeWhere((element) => element.piece_name==inner_1);
      //   box_repository.box_model.value.box_pieces.removeWhere((element) => element.piece_name==inner_2);
      //
      //   box_repository.box_model.value.box_pieces.add(n_inner_1);
      //   box_repository.box_model.value.box_pieces.add(n_inner_2);

      ///
      box_repository.add_box_to_repo(b);
      anlyze_inners();

      draw_Box();



    }






  }

  // flip_piece() {
  //   Box_model b = box_repository.box_model.value;
  //
  //   if (selected_id.length==1) {
  //     Piece_model p = b.box_pieces[selected_id[0]];
  //
  //     if (view_port == 'F') {
  //     } else if (view_port == 'R') {
  //       if (p.piece_direction == 'H') {
  //         p.piece_direction = "F";
  //       } else if (p.piece_direction == 'F') {
  //         p.piece_direction = "H";
  //       }
  //     } else if (view_port == 'T') {}
  //
  //     Piece_model np = Piece_model(
  //         p.piece_id,
  //         p.piece_name,
  //         p.piece_direction,
  //         p.material_name,
  //         p.piece_height,
  //         p.piece_width,
  //         p.piece_thickness,
  //         p.piece_origin,
  //     p.enner_name);
  //
  //     b.box_pieces.remove(p);
  //     b.box_pieces.add(np);
  //   }
  //
  //   box_repository.add_box_to_repo(b);
  //
  //   draw_Box();
  // }

  rotate_around_X(Piece_model p) {
    double h = p.piece_width;
    double th = p.piece_thickness;

    ///
    p.piece_faces.faces[4].corners[2].y_coordinate += h - th;
    p.piece_faces.faces[4].corners[3].y_coordinate += h - th;
    p.piece_faces.faces[5].corners[0].z_coordinate += h - th;
    p.piece_faces.faces[5].corners[1].z_coordinate -= h - th;
    p.piece_faces.faces[5].corners[2].y_coordinate += h - th;
    p.piece_faces.faces[5].corners[2].z_coordinate -= h - th;
    p.piece_faces.faces[5].corners[3].y_coordinate += h - th;
    p.piece_faces.faces[5].corners[3].z_coordinate -= h - th;
  }

  /// analyze box
  analyze() {
    AnalyzeJoins analayzejoins = AnalyzeJoins(false,false);
  }

  /// move_box
  move_box(double dx,double dy)
  {

    Box_model b = box_repository.box_model.value;

  for(int pi=0;pi<b.box_pieces.length;pi++){
    selected_id.value.add(pi);
  }
  move_piece(dx*drawing_scale.value/40, dy*drawing_scale.value/40);


  }


  /// extract executable files with xml extension  to use in this case with kdt drilling machine
  extract_xml_files_pattern(Box_model box_model ,String folder_name,String directory) {

    for (int i = 0; i < box_model.box_pieces.length; i++) {
      if (box_model.box_pieces[i].piece_name.contains("inner") ||
          box_model.box_pieces[i].piece_name
              .contains("back_panel") ||
          box_model.box_pieces[i].piece_name
              .contains("base_panel") ||
          box_model.box_pieces[i].piece_name
              .contains("Help") ||
          box_model.box_pieces[i].piece_inable == false) {
        continue;
      } else {
        kdt_file kdt = kdt_file(directory,box_model.box_pieces[i]);
      }
    }
  }

  extract_xml_files(bool project) async{

     String? directory = await FilePicker.platform.saveFile(
    dialogTitle: 'Please select an output file:',
    fileName: 'box name',
    );

    if(project){

      for(int i=0;i<box_repository.project_model.boxes.length;i++){
        Box_model box_model = box_repository.project_model.boxes[i];
        extract_xml_files_pattern(box_model,box_repository.project_model.project_name,directory!);
      }
    }else{
      extract_xml_files_pattern(box_repository.box_model.value,box_repository.box_model.value.box_name,directory!);
    }
  }

  save_Box() async {
    if (box_repository.box_have_been_saved) {
      String jsonData = jsonEncode(box_repository.box_model.value.toJson());
      File file = File(box_repository.box_file_path!);
      file.writeAsStringSync(jsonData);
    } else {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: 'box name',
      );

      if (outputFile == null) {}

      try {
        String jsonData = jsonEncode(box_repository.box_model.value.toJson());
        File file = File(outputFile!);
        file.writeAsStringSync(jsonData);
        box_repository.box_file_path = outputFile;
        box_repository.box_have_been_saved = true;



        print("file file $file");
      } catch (e) {
        print('Error writing JSON data to the file: $e');
      }
    }

  }

  Future<String> open_File() async {
    String repo_path ;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      repo_path=files.first.path;
    } else {
      // User canceled the picker
      repo_path='';
    }

    // read_Box_from_rebository(file!.path);

    // Get.to(Cabinet_Editor());

    return repo_path;

  }

  Future<Box_model> read_Box_from_rebository() async {
    String path = await open_File();
    File f = File("$path");
    String content = await f.readAsString();

    Box_model bfr = Box_model.fromJson(json.decode(content));

    box_repository.box_model.value = bfr;
    return bfr;
  }

  save_joinHolePattern(JoinHolePattern joinHolePattern,String category) async {

    bool windows_platform=Platform.isWindows;
    final directory = await getApplicationDocumentsDirectory();

    final Directory oldDirectory = windows_platform?(Directory('${directory.path}\\Auto_Cam')):(Directory('${directory.path}/Auto_Cam'));
    oldDirectory.createSync();

    final Directory newDirectory = windows_platform?(Directory('${oldDirectory.path}\\Setting')):(Directory('${oldDirectory.path}/Setting'));
    newDirectory.createSync();

    final Directory finalDirectory0 = windows_platform?(Directory('${newDirectory.path}\\Join_Patterns')):(Directory('${newDirectory.path}/Join_Patterns'));
    finalDirectory0.createSync();

    final Directory finalDirectory =windows_platform?(        Directory('${finalDirectory0.path}\\${category}')
    ):(        Directory('${finalDirectory0.path}/${category}')
    );
    finalDirectory.createSync();

    final path = await finalDirectory.path;
    String file_path = windows_platform?('$path\\${joinHolePattern.name}-pattern'):('$path/${joinHolePattern.name}-pattern');
    // writeJsonToFile(joinHolePattern.toJson(),file_path);
    File file = File(file_path);

    try {
      // Convert the data to a JSON string
      String jsonData = jsonEncode(joinHolePattern.toJson());

      // Write the JSON data to the file
      file.writeAsStringSync(jsonData);

      print('JSON data has been written to $file_path');
    } catch (e) {
      print('Error writing JSON data to the file: $e');
    }
  }


  delete_joinHolePattern(JoinHolePattern joinHolePattern,String category) async {

    bool windows_platform=Platform.isWindows;
    final directory = await getApplicationDocumentsDirectory();

    final Directory oldDirectory = windows_platform?(Directory('${directory.path}\\Auto_Cam')):(Directory('${directory.path}/Auto_Cam'));
    oldDirectory.createSync();

    final Directory newDirectory = windows_platform?(Directory('${oldDirectory.path}\\Setting')):(Directory('${oldDirectory.path}/Setting'));
    newDirectory.createSync();

    final Directory finalDirectory0 = windows_platform?(Directory('${newDirectory.path}\\Join_Patterns')):(Directory('${newDirectory.path}/Join_Patterns'));
    finalDirectory0.createSync();

    final Directory finalDirectory =windows_platform?(        Directory('${finalDirectory0.path}\\${category}')
    ):(        Directory('${finalDirectory0.path}/${category}')
    );
    finalDirectory.createSync();

    final path = await finalDirectory.path;
    String file_path = windows_platform?('$path\\${joinHolePattern.name}-pattern'):('$path/${joinHolePattern.name}-pattern');

    final dir = Directory(file_path);
    dir.deleteSync(recursive: true);

    box_repository.join_patterns[category]!.remove(joinHolePattern);
    await read_pattern_files();


  }


  enable_pattern(JoinHolePattern joinHolePattern,String category) async {

    bool windows_platform=Platform.isWindows;
    final directory = await getApplicationDocumentsDirectory();

    final Directory oldDirectory = windows_platform?(Directory('${directory.path}\\Auto_Cam')):(Directory('${directory.path}/Auto_Cam'));
    oldDirectory.createSync();

    final Directory newDirectory = windows_platform?(Directory('${oldDirectory.path}\\Setting')):(Directory('${oldDirectory.path}/Setting'));
    newDirectory.createSync();

    final Directory finalDirectory0 = windows_platform?(Directory('${newDirectory.path}\\Join_Patterns')):(Directory('${newDirectory.path}/Join_Patterns'));
    finalDirectory0.createSync();

    final Directory finalDirectory =windows_platform?(        Directory('${finalDirectory0.path}\\${category}')
    ):(        Directory('${finalDirectory0.path}/${category}')
    );
    finalDirectory.createSync();

    JoinHolePattern new_join_pattern=joinHolePattern;
    new_join_pattern.pattern_enable=true;

    box_repository.join_patterns[category]!.remove(joinHolePattern);

    save_joinHolePattern(new_join_pattern, category);


  }
  disable_pattern(JoinHolePattern joinHolePattern,String category) async {
    bool windows_platform=Platform.isWindows;
    final directory = await getApplicationDocumentsDirectory();

    final Directory oldDirectory = windows_platform?(Directory('${directory.path}\\Auto_Cam')):(Directory('${directory.path}/Auto_Cam'));
    oldDirectory.createSync();

    final Directory newDirectory = windows_platform?(Directory('${oldDirectory.path}\\Setting')):(Directory('${oldDirectory.path}/Setting'));
    newDirectory.createSync();

    final Directory finalDirectory0 = windows_platform?(Directory('${newDirectory.path}\\Join_Patterns')):(Directory('${newDirectory.path}/Join_Patterns'));
    finalDirectory0.createSync();

    final Directory finalDirectory =windows_platform?(        Directory('${finalDirectory0.path}\\${category}')
    ):(        Directory('${finalDirectory0.path}/${category}')
    );
    finalDirectory.createSync();
    JoinHolePattern new_join_pattern=joinHolePattern;
    new_join_pattern.pattern_enable=false;

    box_repository.join_patterns[category]!.remove(joinHolePattern);

    save_joinHolePattern(new_join_pattern, category);


  }


  read_pattern_files() async {


    box_repository.join_patterns["Box_Fitting_DRILL"]!.clear();
    box_repository.join_patterns["Flexible_Shelves"]!.clear();
    box_repository.join_patterns["Drawer_Face"]!.clear();
    box_repository.join_patterns["Drawer_Rail_Box"]!.clear();
    box_repository.join_patterns["Drawer_Rail_Side"]!.clear();
    box_repository.join_patterns["Door_Hinges"]!.clear();
    box_repository.join_patterns["side_Hinges"]!.clear();
    box_repository.join_patterns["Groove"]!.clear();




    bool windows_platform=Platform.isWindows;

    final rootdirectory = await getApplicationDocumentsDirectory();

    final Directory directory0 =windows_platform?
(        Directory('${rootdirectory.path}\\Auto_Cam\\Setting\\Join_Patterns')

):(
        Directory('${rootdirectory.path}/Auto_Cam/Setting/Join_Patterns')
    )
    ;
    directory0.createSync();

    for (int i = 0; i < box_repository.join_patterns.length; i++) {
      String category_name = box_repository.join_patterns.keys.toList()[i];

      final Directory directory =windows_platform?
          (Directory('${directory0.path}\\${category_name}')):(Directory('${directory0.path}/${category_name}'));
      directory.createSync();

      if (directory.existsSync()) {
        List<FileSystemEntity> files = directory.listSync();

        // Filter the list to include only files
        List<File> fileList = [];
        for (var fileEntity in files) {
          if (fileEntity is File) {
            fileList.add(fileEntity as File);
          }
        }

        // Now, fileList contains a list of File objects from the directory.
        for (var file in fileList) {
          if (file.existsSync()) {
            File f = File(file.path);

            if (f.path.contains('pattern')) {
              String content = await f.readAsString();

              JoinHolePattern joinHolePattern =
                  JoinHolePattern.fromJson(json.decode(content));

              box_repository.join_patterns[category_name]!.add(joinHolePattern);

            }
          } else {
            print('Directory does not exist: $directory');
          }
        }
      }
    }



  }


  /// this only debug mode method to get information off the box pieces
  print_pieces_coordinate() {
    for (int i = 0; i < box_repository.box_model.value.box_pieces.length; i++) {
      print(
          'index : $i;; name  :${box_repository.box_model.value.box_pieces[i].piece_name}');
      Piece_model p = box_repository.box_model.value.box_pieces[i];
      for (int i = 0; i < p.piece_faces.faces.length; i++) {
        Single_Face sf = p.piece_faces.faces[i];
        print('index : $i;; face name  :${sf.name}');
        print('bores  :${sf.bores.length}');

        print("==   ==   ==   ==");
      }

      // print(
      //     'index : $i;; piece id :${box_repository.box_model.value.box_pieces[i].piece_id} ;; name  :${box_repository.box_model.value.box_pieces[i].piece_name}');
      // print(
      //     'height :  ${box_repository.box_model.value.box_pieces[i].piece_height} ;;'
      //     ' width :  ${box_repository.box_model.value.box_pieces[i].piece_width}');
      // print(
      //     'thickness :  ${box_repository.box_model.value.box_pieces[i].piece_thickness}');
      // print('quantity :  1');
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
      print('-----------------------------------');
      print('-----------------------------------');
    }
  }



  ///nesting_pieces
  List<Piece_model> nesting_pieces(){

    List<Piece_model> nesting_pieces=[];


    for (int r = 0; r < box_repository.box_model.value.box_pieces.length; r++) {
      Piece_model my_piece = box_repository.box_model.value.box_pieces[r];
      if(my_piece.piece_name.contains("inner") ||my_piece.piece_name.contains("Helper")){continue;}
      else{
        my_piece.nested=false;
        nesting_pieces.add(my_piece);
      }
    }

    return nesting_pieces;

  }


  /// /// / / / PROJECT /////////////


/// String tools

  String first_chart_every_word(String name){

    List<String> Lbox_name=name.split(" ");
    String nbn;
    if (Lbox_name.length>1) {
      String nn1=Lbox_name[0].substring(0,1);
      String nn2=Lbox_name[1].substring(0,1);
      nbn="$nn1$nn2";
    }else{
      String nn1=Lbox_name[0].substring(0,2);
      nbn="$nn1";
    }

    return nbn;
  }

  String first_chart_every_word_with_random_num(String name){

    String nbn="";

    String nn=first_chart_every_word(name);
    int n = Random().nextInt(1000);
    if(n<10){
      nbn="${nn}_00${n}";

    }else if(n>10&&n<100){
      nbn="${nn}_0${n}";

    }else{
      nbn="${nn}_${n}";

    }

    return nbn;
  }




  /// automatic detect inners

  anlyze_inners(){

    clear_inners_list();
    corners_points=detct_corners();
    List<Rectangle_model> rectangles=  draw_rectangles();
    List<Rectangle_model> correct_rectangles=  cancel_contained_rectangle_in_piece(rectangles);

    for(Rectangle_model rectangle in correct_rectangles){
      Piece_model inner=Piece_model(box_repository.box_model.value.get_id("inner"),
          "inner",
          "F",
          "gh",
          rectangle.width,
          rectangle.height,
          0,
          origin_of_rectangle(rectangle)
       );
      box_repository.box_model.value.box_pieces.add(inner);
    }





  }

  ///clear_inners_list
  clear_inners_list(){
    List<Piece_model> box_pieces_without_inners=[];
    for(Piece_model piece_model in box_repository.box_model.value.box_pieces){
      if(piece_model.piece_name!="inner"){
        box_pieces_without_inners.add(piece_model);
      }
    }
    box_repository.box_model.value.box_pieces=box_pieces_without_inners;
  }




  ///origin of rectangle
  Point_model origin_of_rectangle(Rectangle_model rectangle){
    double x=rectangle.corners[0].x_coordinate;
    double y=rectangle.corners[0].y_coordinate;
    double z=rectangle.corners[0].z_coordinate;

    for(int poi=1;poi<3;poi++){
      if(rectangle.corners[poi].x_coordinate<x){
        x=rectangle.corners[poi].x_coordinate;
      }

      if(rectangle.corners[poi].y_coordinate<y){
        y=rectangle.corners[poi].y_coordinate;
      }

    }

    Point_model origin=Point_model(x, y, z);

    return origin;
  }

  /// detect corners off inners
  List<Point_model> detct_corners(){
    List<Point_model> corners=[];
    for(int i=0;i<box_repository.box_model.value.box_pieces.length;i++){
      Piece_model p = box_repository.box_model.value.box_pieces[i];
      if(
      p.piece_name.contains("shelf")||
          p.piece_name.contains("partition")||
          p.piece_name.contains("top")||
          p.piece_name.contains("base")||
          p.piece_name.contains("right")||
          p.piece_name.contains("left")
      )
      {
        Single_Face front_face=p.piece_faces.faces[4];

        for(Point_model poi in front_face.corners)
        {
          corners.add(poi);
        }

      }
    }

    return corners;
  }


  ///
  List<Rectangle_model> draw_rectangles(){

    List<Rectangle_model> rects=[];

    for(Point_model p in  corners_points){
      if(can_draw_rect_from_point(p)){
        Rectangle_model rectangle_model=   rect_from_point(p);

        if(rectangle_model.width!=0 && rectangle_model.height!=0){
          rects.add(rectangle_model);

        }
      }
    }



    return rects;


  }


  List<Rectangle_model> cancel_contained_rectangle_in_piece(List<Rectangle_model> rects){
    List<Rectangle_model> inners=[];

    for(Rectangle_model rect in rects){
      if(!the_face_contained_in_piece(rect)){
        inners.add(rect);
      }
    }

    return inners;
  }

  bool the_face_contained_in_piece(Rectangle_model rect){
    bool contained=false;

    for(Piece_model piece in box_repository.box_model.value.box_pieces){
      if(piece.piece_name.contains("back_panel")){
        continue;
      }
      if(center_in_piece(piece, rectangle_center(rect))){
        contained=true;
      }
    }


    return contained;
  }


  ///can_draw_rect_from_point
 bool  can_draw_rect_from_point(Point_model p){
    bool can_draw=false;

    if(have_next_X(p)){
      Point_model p2=next_X(p);
      if(have_next_Y(p2)){
        can_draw=true;
      }
    }

    return can_draw;
  }

  Rectangle_model rect_from_point(Point_model p){


    Point_model p1=Point_model(p.x_coordinate,p.y_coordinate,0);
    Point_model p2=next_X(p);
    Point_model p3=next_Y(p2);



    Rectangle_model rectangle_model=Rectangle_model([p1,p2,p3,p1]);

    return rectangle_model;
  }

  bool have_next_X(Point_model p ){
    bool have_next_x=false;

    for(Point_model poi in corners_points){
      if(poi.y_coordinate==p.y_coordinate && poi.x_coordinate>p.x_coordinate){
        have_next_x=true;
      }
    }

    return have_next_x;
  }

  bool have_next_Y(Point_model p ){
    bool have_next_y=false;

    for(Point_model poi in corners_points){
      if(poi.x_coordinate==p.x_coordinate && poi.y_coordinate<p.y_coordinate){
        have_next_y=true;
      }
    }
    return have_next_y;
  }


  Point_model next_X(Point_model p ){

    List<double> next_x_value=[];

    for(Point_model poi in corners_points){
      if(poi.y_coordinate==p.y_coordinate){
        if(poi.x_coordinate>p.x_coordinate){
            next_x_value.add(poi.x_coordinate);
        }
      }
    }
    next_x_value.sort();
    Point_model next_x_point=Point_model(
        next_x_value[0],
        p.y_coordinate,
        0);



    return next_x_point;
  }



  Point_model next_Y(Point_model p ){


    List<double> next_y_value=[];

    for(Point_model poi in corners_points){
      if(poi.x_coordinate==p.x_coordinate){
        if(poi.y_coordinate<p.y_coordinate){
            next_y_value.add(poi.y_coordinate);
        }
      }
    }


    next_y_value.sort();

    Point_model next_y_point=Point_model(
        p.x_coordinate,
        next_y_value[next_y_value.length-1],
        0);


    return next_y_point;
  }


  Point_model rectangle_center(Rectangle_model rectangle_model){

    Point_model center=Point_model(
origin_of_rectangle(rectangle_model).x_coordinate+rectangle_model.width/2,
origin_of_rectangle(rectangle_model).y_coordinate+rectangle_model.height/2,
        0);


    return center;
  }

  bool center_in_piece(Piece_model piece , Point_model center){
    bool center_in_piece=false;

    Rectangle_model rectangle_model=Rectangle_model(piece.piece_faces.faces[4].corners);

    bool compare_x=rectangle_model.corners[0].x_coordinate<center.x_coordinate &&
        rectangle_model.corners[2].x_coordinate>center.x_coordinate;

    bool compare_y=rectangle_model.corners[0].y_coordinate<center.y_coordinate &&
                   rectangle_model.corners[2].y_coordinate>center.y_coordinate;


    if(compare_x && compare_y){
      center_in_piece=true;
    }
    return center_in_piece;

  }


  double  correct_value(double v){
    double resault= double.parse(v.toStringAsFixed(2));
    return resault;
  }





}
