

import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Face_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Model/Main_Models/Point_model.dart';
import 'package:get/get.dart';

class Drawer_model{

  late int drawer_id;
  late double inner_height;
  late double inner_width;
  late int drawer_type;
  late double side_gape;
  late double drawer_box_material_thickness;
  late double drawer_box_width;
  late double drawer_box_height;
  late double drawer_box_depth;
  late Point_model drawer_origin;

  Drawer_model(
      this.drawer_id,
      this.inner_height,
      this.inner_width,
      this.drawer_type,
      this.side_gape,
      this.drawer_box_material_thickness,
      this.drawer_box_height,
      this.drawer_box_depth,
      this.drawer_origin) {

if(drawer_type==1){
  drawer_box_width=inner_width-2*side_gape;
}

    Draw_Controller draw_controller=Get.find();


    /// drawer box right piece
    Face_model drawer_box_right_side_face=Face_model(
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
    );
    Point_model drawer_box_right_side_ogirin=Point_model(
        drawer_origin.x_coordinate+drawer_box_width-drawer_box_material_thickness+side_gape,
        drawer_origin.y_coordinate+(inner_height-drawer_box_height)/2,
        drawer_origin.z_coordinate
    );
    Piece_model drawer_right_piece = Piece_model(draw_controller.box_repository.box_model.value.pieces_id,
        'Drawer $drawer_id right side', 'V', 'material_name',
        drawer_box_depth, drawer_box_height, drawer_box_material_thickness,
        drawer_box_right_side_ogirin,
        drawer_box_right_side_face);
    draw_controller.box_repository.box_model.value.box_pieces.add(drawer_right_piece);
    draw_controller.box_repository.box_model.value.pieces_id++;


    /// drawer box left piece
    Face_model drawer_box_left_side_face=Face_model(
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
    );
    Point_model drawer_box_left_side_ogirin=Point_model(
        drawer_origin.x_coordinate+side_gape,
        drawer_origin.y_coordinate+(inner_height-drawer_box_height)/2,
        drawer_origin.z_coordinate
    );
    Piece_model drawer_left_piece = Piece_model(draw_controller.box_repository.box_model.value.pieces_id,
        'Drawer $drawer_id left side', 'V', 'material_name',
        drawer_box_depth, drawer_box_height, drawer_box_material_thickness,
        drawer_box_left_side_ogirin,
        drawer_box_left_side_face);
    draw_controller.box_repository.box_model.value.box_pieces.add(drawer_left_piece);
    draw_controller.box_repository.box_model.value.pieces_id++;


    /// drawer box front piece
    Face_model drawer_box_front_side_face=Face_model(
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
    );
    Point_model drawer_box_front_side_ogirin=Point_model(
        drawer_origin.x_coordinate+side_gape+drawer_box_material_thickness,
        drawer_origin.y_coordinate+(inner_height-drawer_box_height)/2,
        drawer_origin.z_coordinate
    );
    Piece_model drawer_front_piece = Piece_model(draw_controller.box_repository.box_model.value.pieces_id,
        'Drawer $drawer_id front side', 'F', 'material_name',
        drawer_box_width-2*drawer_box_material_thickness,
        drawer_box_height,
        drawer_box_material_thickness,
        drawer_box_front_side_ogirin,
        drawer_box_front_side_face);
    draw_controller.box_repository.box_model.value.box_pieces.add(drawer_front_piece);
    draw_controller.box_repository.box_model.value.pieces_id++;


    /// drawer box back piece
    Face_model drawer_box_back_side_face=Face_model(
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
      Single_Face([],[],[]),
    );
    Point_model drawer_box_back_side_ogirin=Point_model(
        drawer_origin.x_coordinate+side_gape+drawer_box_material_thickness,
        drawer_origin.y_coordinate+(inner_height-drawer_box_height)/2,
        drawer_origin.z_coordinate-drawer_box_depth-drawer_box_material_thickness
    );
    Piece_model drawer_back_piece = Piece_model(draw_controller.box_repository.box_model.value.pieces_id,
        'Drawer $drawer_id back side', 'F', 'material_name',
        drawer_box_width-2*drawer_box_material_thickness,
        drawer_box_height, drawer_box_material_thickness,
        drawer_box_back_side_ogirin,
        drawer_box_back_side_face);
    draw_controller.box_repository.box_model.value.box_pieces.add(drawer_back_piece);
    draw_controller.box_repository.box_model.value.pieces_id++;



  }
}