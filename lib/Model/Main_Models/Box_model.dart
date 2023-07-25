import 'dart:math';

import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam/Model/Main_Models/Drawer_model.dart';
import 'package:auto_cam/Model/Main_Models/Face_model.dart';
import 'package:auto_cam/Model/Main_Models/Groove_model.dart';
import 'package:auto_cam/Model/Main_Models/Join_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Model/Main_Models/Point_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Box_model {
  late String box_name;
  late int box_id;
  late double box_width;
  late double box_height;
  late double box_depth;
  late double init_material_thickness;
  late String init_material_name;
  late double backpanel_thickness;
  late bool is_back_panel;
  late Point_model box_origin;
  late List<Piece_model> box_pieces;
  late List<Drawer_model> box_drawers;
  late String box_type;


  int pieces_id = 8;
  double fix_shelf_limet = 200;

  Box_model(this.box_name,this.box_width, this.box_height, this.box_depth,
      this.init_material_thickness,this.init_material_name, this.backpanel_thickness,this.is_back_panel,this.box_type) {
    box_id = 0;
    box_origin = Point_model(0, 0, 0);
    ////////////////////////////////////////////////////////////////////////////
    box_drawers = [];

    /// we need to define the id of initiate pieces
    /// note : we consider the main inner or inner area has the id of back panel
    /// and it will always like this , the different id for inner will be for new inners

    ////////////////////////////////////////////////////////////////////////////

    /// 1- initiate the (top) piece of the box
    /// 1-1 initiate the Faces of the top piece
    ///

   late Piece_model top_piece;
   late Piece_model top_piece_1;
   late Piece_model top_piece_2;

    if(box_type=="wall_box"){
      Groove_model top_back_panel_grove = Groove_model(Point_model(0, 21, 0),
          Point_model(box_width - 2 * init_material_thickness, 21, 0), 6, 10);

      Join_model j1 = Join_model(Point_model(init_material_thickness / 2, 50, 0), 8, 32, 'boring');
      Join_model j2 = Join_model(Point_model(init_material_thickness / 2, 82, 0), 8, 32, 'boring');
      Join_model j3 = Join_model(Point_model(init_material_thickness / 2, box_depth / 2, 0), 8, 32, 'boring');
      Join_model j4 = Join_model(Point_model(init_material_thickness / 2, box_depth - 50, 0), 8, 32, 'boring');
      Join_model j5 = Join_model(Point_model(init_material_thickness / 2, box_depth - 82, 0), 8, 32, 'boring');

      Join_model j_back_1 = Join_model(Point_model(34, 82, 0), 15, 13, 'boring');
      Join_model j_back_2 = Join_model(Point_model(34, box_depth - 82, 0), 15, 13, 'boring');
      Join_model j_back_3 = Join_model(Point_model(box_width - 2 * init_material_thickness - 34, 82, 0), 15, 13, 'boring');
      Join_model j_back_4 = Join_model(Point_model(box_width - 2 * init_material_thickness - 34, box_depth - 82, 0), 15, 13, 'boring');

      Single_Face top_Piece_top_face =
      Single_Face([0], [j_back_1, j_back_2, j_back_3, j_back_4], []);
      Single_Face top_Piece_right_face =
      Single_Face([4], [j1, j2, j3, j4, j5], []);
      Single_Face top_Piece_base_face =
      Single_Face([1], [], is_back_panel?[top_back_panel_grove]:[]);
      Single_Face top_Piece_left_face =
      Single_Face([7], [j1, j2, j3, j4, j5], []);
      Single_Face top_Piece_front_face = Single_Face([0], [], []);
      Single_Face top_Piece_back_face = Single_Face([0], [], []);

      Face_model top_faces = Face_model(
          top_Piece_top_face,
          top_Piece_right_face,
          top_Piece_base_face,
          top_Piece_left_face,
          top_Piece_front_face,
          top_Piece_back_face);

      ///1-2 initiate the top piece itself
       top_piece = Piece_model(
          2,1,false,
          'top',
          'H',
           init_material_name,
          box_depth,
          box_width - 2 * init_material_thickness,
          init_material_thickness,
          Point_model(box_origin.x_coordinate + init_material_thickness,
              box_origin.y_coordinate + box_height - init_material_thickness, 0),
          top_faces);
     }
   else {
      Groove_model top_back_panel_grove = Groove_model(Point_model(0, 21, 0),
          Point_model(box_width - 2 * init_material_thickness, 21, 0), 6, 10);

      Join_model j1 = Join_model(Point_model(init_material_thickness / 2, 30, 0), 8, 32, 'boring');
      Join_model j2 = Join_model(Point_model(init_material_thickness / 2, 50, 0), 8, 32, 'boring');
      Join_model j3 = Join_model(Point_model(init_material_thickness / 2, 80, 0), 8, 32, 'boring');

      Join_model j1_f = Join_model(Point_model(init_material_thickness / 2, 25, 0), 8, 32, 'boring');
      Join_model j2_f = Join_model(Point_model(init_material_thickness / 2, 50, 0), 8, 32, 'boring');
      Join_model j3_f = Join_model(Point_model(init_material_thickness / 2, 75, 0), 8, 32, 'boring');

      Join_model j_back_1 = Join_model(Point_model(34, 50, 0), 15, 13, 'boring');
      Join_model j_back_2 = Join_model(Point_model(box_width - 2 * init_material_thickness-34,50, 0), 15, 13, 'boring');

      Single_Face top_Piece_top_face =
      Single_Face([0], [j_back_1, j_back_2 ], []);
      Single_Face top_Piece_right_face =
      Single_Face([2], [j1, j2, j3], []);
      Single_Face top_Piece_base_face =
      Single_Face([5], [], is_back_panel?[top_back_panel_grove]:[]);
      Single_Face top_Piece_left_face =
      Single_Face([4], [j1, j2, j3], []);
      Single_Face top_Piece_front_face = Single_Face([0], [], []);
      Single_Face top_Piece_back_face = Single_Face([0], [], []);

      Face_model top_faces_1 = Face_model(
          top_Piece_top_face,
          top_Piece_right_face,
          top_Piece_base_face,
          top_Piece_left_face,
          top_Piece_front_face,
          top_Piece_back_face);



      Single_Face top_2_Piece_top_face =
      Single_Face([0], [j_back_1, j_back_2 ], []);
      Single_Face top_2_Piece_right_face =
      Single_Face([2], [j1_f, j2_f, j3_f], []);
      Single_Face top_2_Piece_base_face =
      Single_Face([5], [],[]);
      Single_Face top_2_Piece_left_face =
      Single_Face([4], [j1_f, j2_f, j3_f], []);
      Single_Face top_2_Piece_front_face = Single_Face([0], [], []);
      Single_Face top_2_Piece_back_face = Single_Face([0], [], []);


      Face_model top_faces_2 = Face_model(
          top_2_Piece_top_face,
          top_2_Piece_right_face,
          top_2_Piece_base_face,
          top_2_Piece_left_face,
          top_2_Piece_front_face,
          top_2_Piece_back_face);

      ///1-2 initiate the top piece itself
       top_piece_1 = Piece_model(
          2,1,false,
          'top',
          'H',
           init_material_name,
          100,
          box_width - 2 * init_material_thickness,
          init_material_thickness,
          Point_model(box_origin.x_coordinate + init_material_thickness,
              box_origin.y_coordinate + box_height - init_material_thickness, 0),
          top_faces_1);

       top_piece_2 = Piece_model(
          3,1,false,
          'top',
          'H',
           init_material_name,
          100,
          box_width - 2 * init_material_thickness,
          init_material_thickness,
          Point_model(box_origin.x_coordinate + init_material_thickness,
              box_origin.y_coordinate + box_height - init_material_thickness,box_depth-100),
          top_faces_2);

    }

    ////////////////////////////////////////////////////////////////////////////

    /// 2- initiate the (right) piece of the box
    /// 2-1 initiate the Faces of the right piece
    ///

    //back panel grove
    Groove_model right_back_panel_grove = Groove_model(Point_model(21, 9, 0), Point_model(21, box_height - 9, 0), 6, 10);



   List<Join_model> rplsj=[];
    if(box_type=="wall_box"){
      rplsj.add(Join_model(Point_model(50, init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(82, init_material_thickness / 2, 0), 10, 11, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth / 2, init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 50, init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 82, init_material_thickness / 2, 0), 10, 11, 'boring'));
      rplsj.add(Join_model(Point_model(50, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(82, box_height - init_material_thickness / 2, 0), 10, 11, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth / 2, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 50, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 82, box_height - init_material_thickness / 2, 0), 10, 10, 'boring'));

    }
    else if(box_type=="base_box"){
      rplsj.add(Join_model(Point_model(50,             init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(82,             init_material_thickness / 2, 0), 10, 11, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth / 2,  init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 50, init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 82, init_material_thickness / 2, 0), 10, 11, 'boring'));



      rplsj.add(Join_model(Point_model(30,             box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(50,             box_height - init_material_thickness / 2, 0), 10, 11, 'boring'));
      rplsj.add(Join_model(Point_model(80,             box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));

      rplsj.add(Join_model(Point_model(box_depth - 25, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 50, box_height - init_material_thickness / 2, 0), 10, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 75, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));

    }
    else if(box_type=="inner_box"){

      rplsj.add(Join_model(Point_model(30,            init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(50,            init_material_thickness / 2, 0), 10, 11, 'boring'));
      rplsj.add(Join_model(Point_model(80,            init_material_thickness / 2, 0), 8, 10, 'boring'));

      rplsj.add(Join_model(Point_model(box_depth - 25,init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 50,init_material_thickness / 2, 0), 10, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 75,init_material_thickness / 2, 0), 8, 10, 'boring'));



      rplsj.add(Join_model(Point_model(30,             box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(50,             box_height - init_material_thickness / 2, 0), 10, 11, 'boring'));
      rplsj.add(Join_model(Point_model(80,             box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));

      rplsj.add(Join_model(Point_model(box_depth - 25, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 50, box_height - init_material_thickness / 2, 0), 10, 10, 'boring'));
      rplsj.add(Join_model(Point_model(box_depth - 75, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));

    }






    Single_Face right_Piece_top_face = Single_Face([0], [], []);
    Single_Face right_Piece_right_face = Single_Face([0], [], []);
    Single_Face right_Piece_base_face = Single_Face([0], [], []);
    Single_Face right_Piece_left_face = Single_Face([
      2,
      1,
      5
    ], rplsj,
      is_back_panel?[right_back_panel_grove] :[]
    );
    Single_Face right_Piece_front_face = Single_Face([0], [], []);
    Single_Face right_Piece_back_face = Single_Face([0], [], []);

    Face_model right_faces = Face_model(
        right_Piece_top_face,
        right_Piece_right_face,
        right_Piece_base_face,
        right_Piece_left_face,
        right_Piece_front_face,
        right_Piece_back_face);

    ///2-2 initiate the right piece itself
    Piece_model right_piece = Piece_model(
        4,1,false,
        'right',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(
            box_origin.x_coordinate + box_width - init_material_thickness,
            box_origin.y_coordinate,
            0),
        right_faces);
     ////////////////////////////////////////////////////////////////////////////

    /// 4- initiate the (base) piece of the box
    /// 4-1 initiate the Faces of the base piece


    late Piece_model base_piece;
    late Piece_model base_piece_1;
    late Piece_model base_piece_2;


    if(box_type=="wall_box" || box_type=="base_box"){
      Groove_model base_back_panel_grove = Groove_model(Point_model(0, box_depth - 21, 0), Point_model(box_width - 2 * init_material_thickness, box_depth - 21, 0), 6, 10);

      Join_model base_j1 = Join_model(Point_model(init_material_thickness / 2, 50, 0), 8, 32, 'boring');
      Join_model base_j2 = Join_model(Point_model(init_material_thickness / 2, 82, 0), 8, 32, 'boring');
      Join_model base_j3 = Join_model(Point_model(init_material_thickness / 2, box_depth / 2, 0), 8, 32, 'boring');
      Join_model base_j4 = Join_model(Point_model(init_material_thickness / 2, box_depth - 50, 0), 8, 32, 'boring');
      Join_model base_j5 = Join_model(Point_model(init_material_thickness / 2, box_depth - 82, 0), 8, 32, 'boring');

      Join_model base_j_back_1 = Join_model(Point_model(34, 82, 0), 15, 13, 'boring');
      Join_model base_j_back_2 = Join_model(Point_model(34, box_depth - 82, 0), 15, 13, 'boring');
      Join_model base_j_back_3 = Join_model(Point_model(box_width - 2 * init_material_thickness - 34, 82, 0), 15, 13, 'boring');
      Join_model base_j_back_4 = Join_model(Point_model(box_width - 2 * init_material_thickness - 34, box_depth - 82, 0), 15, 13, 'boring');

      Single_Face base_Piece_top_face =
      Single_Face([1], [], is_back_panel?[base_back_panel_grove]:[]);
      Single_Face base_Piece_right_face = Single_Face([
        4
      ], [
        base_j1,
        base_j2,
        base_j3,
        base_j4,
        base_j5,
      ], []);
      Single_Face base_Piece_base_face = Single_Face([
        0
      ], [
        base_j_back_1,
        base_j_back_2,
        base_j_back_3,
        base_j_back_4,
      ], []);
      Single_Face base_Piece_left_face = Single_Face([
        7
      ], [
        base_j1,
        base_j2,
        base_j3,
        base_j4,
        base_j5,
      ], []);
      Single_Face base_Piece_front_face = Single_Face([0], [], []);
      Single_Face base_Piece_back_face = Single_Face([0], [], []);

      Face_model base_faces = Face_model(
          base_Piece_top_face,
          base_Piece_right_face,
          base_Piece_base_face,
          base_Piece_left_face,
          base_Piece_front_face,
          base_Piece_back_face);

      ///4-2 initiate the base piece itself
       base_piece = Piece_model(
          5,1,false,
          'base',
          'H',
           init_material_name,
          box_depth,
          box_width - 2 * init_material_thickness,
          init_material_thickness,
          Point_model(box_origin.x_coordinate + init_material_thickness,
              box_origin.y_coordinate, 0),
          base_faces);
     }
    else {
      Groove_model base_back_panel_grove =
      Groove_model(Point_model(0, 100 - 21, 0),
          Point_model(box_width - 2 * init_material_thickness, 100 - 21, 0), 6, 10);

      Join_model base_j1_f = Join_model(Point_model(init_material_thickness / 2, 20, 0), 8, 32, 'boring');
      Join_model base_j2_f = Join_model(Point_model(init_material_thickness / 2, 50, 0), 8, 32, 'boring');
      Join_model base_j3_f = Join_model(Point_model(init_material_thickness / 2, 70, 0), 8, 32, 'boring');


      Join_model base_j1 = Join_model(Point_model(init_material_thickness / 2, 25, 0), 8, 32, 'boring');
      Join_model base_j2 = Join_model(Point_model(init_material_thickness / 2, 50, 0), 8, 32, 'boring');
      Join_model base_j3 = Join_model(Point_model(init_material_thickness / 2, 75, 0), 8, 32, 'boring');

      Join_model base_j_back_1 = Join_model(Point_model(34, 50, 0), 15, 13, 'boring');
      Join_model base_j_back_2 = Join_model(Point_model( box_width - 2 * init_material_thickness-34,50, 0), 15, 13, 'boring');

      Single_Face base_Piece_top_face =
      Single_Face([1], [], is_back_panel?[base_back_panel_grove]:[]);
      Single_Face base_Piece_right_face = Single_Face([
        4
      ], [
        base_j1,
        base_j2,
        base_j3,
      ], []);
      Single_Face base_Piece_base_face = Single_Face([
        0
      ], [
        base_j_back_1,
        base_j_back_2,
      ], []);
      Single_Face base_Piece_left_face = Single_Face([
        7
      ], [
        base_j1,
        base_j2,
        base_j3,
      ], []);
      Single_Face base_Piece_front_face = Single_Face([0], [], []);
      Single_Face base_Piece_back_face = Single_Face([0], [], []);

      Face_model base_faces_1 = Face_model(
          base_Piece_top_face,
          Single_Face([
           4
          ], [
            base_j1_f,
            base_j2_f,
            base_j3_f,
          ], []),
          base_Piece_base_face,
          Single_Face([
            7
          ], [
            base_j1_f,
            base_j2_f,
            base_j3_f,
          ], []),
          base_Piece_front_face,
          base_Piece_back_face);


      Face_model base_faces_2 = Face_model(
          Single_Face([1], [],[]),
          base_Piece_right_face,
          base_Piece_base_face,
          base_Piece_left_face,
          base_Piece_front_face,
          base_Piece_back_face);

      ///4-2 initiate the base piece itself
       base_piece_1 = Piece_model(
          5,1,false,
          'base',
          'H',
           init_material_name,
          100,
          box_width - 2 * init_material_thickness,
          init_material_thickness,
          Point_model(box_origin.x_coordinate + init_material_thickness,
              box_origin.y_coordinate, box_depth-100),
          base_faces_1);

      base_piece_2 = Piece_model(
          6,1,false,
          'base',
          'H',
          init_material_name,
          100,
          box_width - 2 * init_material_thickness,
          init_material_thickness,
          Point_model(box_origin.x_coordinate + init_material_thickness,
              box_origin.y_coordinate, 0),
          base_faces_2);


    }

    ////////////////////////////////////////////////////////////////////////////

    /// 3- initiate the (left) piece of the box
    /// 3-1 initiate the Faces of the left piece
    ///
    ///
    ///
    Groove_model left_panel_grove = Groove_model(Point_model(21, 9, 0), Point_model(21, box_height - 9, 0), 6, 10);


    List<Join_model> lplsj=[];
    if(box_type=="wall_box"){
      lplsj.add(Join_model(Point_model(50,             init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(82,             init_material_thickness / 2, 0), 10, 11, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth / 2,  init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 50, init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 82, init_material_thickness / 2, 0), 10, 11, 'boring'));
      lplsj.add(Join_model(Point_model(50, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(82, box_height - init_material_thickness / 2, 0), 10, 11, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth / 2, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 50, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 82, box_height - init_material_thickness / 2, 0), 10, 10, 'boring'));

    }
    else if(box_type=="base_box"){
      lplsj.add(Join_model(Point_model(50,             init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(82,             init_material_thickness / 2, 0), 10, 11, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth / 2,  init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 50, init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 82, init_material_thickness / 2, 0), 10, 11, 'boring'));



      lplsj.add(Join_model(Point_model(30,             box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(50,             box_height - init_material_thickness / 2, 0), 10, 11, 'boring'));
      lplsj.add(Join_model(Point_model(80,             box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));

      lplsj.add(Join_model(Point_model(box_depth - 25, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 50, box_height - init_material_thickness / 2, 0), 10, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 75, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));

    }
    else if(box_type=="inner_box"){

      lplsj.add(Join_model(Point_model(30,            init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(50,            init_material_thickness / 2, 0), 10, 11, 'boring'));
      lplsj.add(Join_model(Point_model(80,            init_material_thickness / 2, 0), 8, 10, 'boring'));

      lplsj.add(Join_model(Point_model(box_depth - 25,init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 50,init_material_thickness / 2, 0), 10, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 75,init_material_thickness / 2, 0), 8, 10, 'boring'));



      lplsj.add(Join_model(Point_model(30,             box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(50,             box_height - init_material_thickness / 2, 0), 10, 11, 'boring'));
      lplsj.add(Join_model(Point_model(80,             box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));

      lplsj.add(Join_model(Point_model(box_depth - 25, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 50, box_height - init_material_thickness / 2, 0), 10, 10, 'boring'));
      lplsj.add(Join_model(Point_model(box_depth - 75, box_height - init_material_thickness / 2, 0), 8, 10, 'boring'));

    }

    Single_Face left_Piece_top_face = Single_Face([0], [], []);
    Single_Face left_Piece_right_face = Single_Face([
      2,
      1,
      5
    ], lplsj, is_back_panel?[
      left_panel_grove
    ]:[]);
    Single_Face left_Piece_base_face = Single_Face([0], [], []);
    Single_Face left_Piece_left_face = Single_Face([0], [], []);
    Single_Face left_Piece_front_face = Single_Face([0], [], []);
    Single_Face left_Piece_back_face = Single_Face([0], [], []);

    Face_model left_faces = Face_model(
        left_Piece_top_face,
        left_Piece_right_face,
        left_Piece_base_face,
        left_Piece_left_face,
        left_Piece_front_face,
        left_Piece_back_face);

    ///3-2 initiate the left piece itself
    Piece_model left_piece = Piece_model(
        7,1,false,
        'left',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate, box_origin.y_coordinate, 0),
        left_faces);

    ////////////////////////////////////////////////////////////////////////////

    /// 6- initiate the (main inner) piece of the box
    /// 6-1 initiate the Faces of the inner piece

    Single_Face inner_Piece_top_face = Single_Face([2], [], []);
    Single_Face inner_Piece_right_face = Single_Face([4], [], []);
    Single_Face inner_Piece_base_face = Single_Face([5], [], []);
    Single_Face inner_Piece_left_face = Single_Face([7], [], []);
    Single_Face inner_Piece_front_face = Single_Face([0], [], []);
    Single_Face inner_Piece_back_face = Single_Face([0], [], []);

    Face_model inner_panel_faces = Face_model(
      inner_Piece_top_face,
      inner_Piece_right_face,
      inner_Piece_base_face,
      inner_Piece_left_face,
      inner_Piece_front_face,
      inner_Piece_back_face,
    );

    ///6-2 initiate the inner piece itself
    Piece_model inner_piece = Piece_model(
        1,1,false,
        'inner',
        'F',
        init_material_name,
        box_width - init_material_thickness * 2,
        box_height - init_material_thickness * 2,
        backpanel_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + init_material_thickness, 0),
        inner_panel_faces);
     ////////////////////////////////////////////////////////////////////////////

    box_pieces = [];
if(box_type=="wall_box"){box_pieces.add(top_piece);}else{
  box_pieces.add(top_piece_1);
  box_pieces.add(top_piece_2);
}


    box_pieces.add(right_piece);
    if(box_type=="wall_box"||box_type=="base_box"){box_pieces.add(base_piece);}else{
      box_pieces.add(base_piece_1);
      box_pieces.add(base_piece_2);
    }
    box_pieces.add(left_piece);
    box_pieces.add(inner_piece);

    ////////////////////////////////////////////////////////////////////////////

    /// 5- initiate the (back_panel) piece of the box
    /// 5-1 initiate the Faces of the back_panel piece

    Single_Face back_panel_Piece_top_face = Single_Face([2], [], []);
    Single_Face back_panel_Piece_right_face = Single_Face([4], [], []);
    Single_Face back_panel_Piece_base_face = Single_Face([5], [], []);
    Single_Face back_panel_Piece_left_face = Single_Face([7], [], []);
    Single_Face back_panel_Piece_front_face = Single_Face([0], [], []);
    Single_Face back_panel_Piece_back_face = Single_Face([0], [], []);

    Face_model back_panel_faces = Face_model(
        back_panel_Piece_top_face,
        back_panel_Piece_right_face,
        back_panel_Piece_base_face,
        back_panel_Piece_left_face,
        back_panel_Piece_front_face,
        back_panel_Piece_back_face);

   late double top_thickness;
    if(box_type=="wall_box"){top_thickness=(top_piece.Piece_thickness);}else{top_thickness=top_piece_1.Piece_thickness;}

    late double base_thickness;
    if(box_type=="wall_box" ||box_type=="base_box"){base_thickness=(base_piece.Piece_thickness);}
    else {base_thickness=base_piece_1.Piece_thickness;}

    Piece_model back_panel_piece = Piece_model(
        pieces_id,1,false,
        "Box back_panel",
        'F',
        'back panel material',
        box_width -
            (left_piece.Piece_thickness + right_piece.Piece_thickness) +
            18,
        box_height -
            (top_thickness+base_thickness) +
            18,
        backpanel_thickness,
        Point_model(
            left_piece.Piece_thickness - 9, base_thickness- 9, 0),
        back_panel_faces);

    if(is_back_panel){
      pieces_id++;
      box_pieces.add(back_panel_piece);
    }

  }


  add_Shelf_pattern(int inner, double top_Distence, double frontage_Gap,
      double shelf_material_thickness, String shelf_type,bool is_copy,int shelf_quantity) {
    double down_Distence = box_pieces[inner].Piece_height -
        top_Distence -
        shelf_material_thickness;

    double depth_of_shelf = box_depth - 24 - frontage_Gap;

    int old_inner_id = pieces_id;
    int new_inner_id = pieces_id + 1;
    int new_piece_id = pieces_id + 2;

    Face_model old_inner_faces = Face_model(
      Single_Face(
          [box_pieces[inner].piece_faces.top_face.face_item.first], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.right_face.face_item.first], [], []),
      Single_Face([new_piece_id], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.left_face.face_item.first], [], []),
      Single_Face([], [], []),
      Single_Face([], [], []),
    );

    Piece_model old_inner = Piece_model(
        pieces_id,1,false,
        'inner',
        'F',
        'inner',
        box_pieces[inner].Piece_width,
        top_Distence,
        1,
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate +
                down_Distence +
                shelf_material_thickness,
            box_pieces[inner].piece_origin.z_coordinate),
        old_inner_faces);
    pieces_id++;

    Face_model new_inner_faces = Face_model(
      Single_Face([new_piece_id], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.right_face.face_item.first], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.base_face.face_item.first], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.left_face.face_item.first], [], []),
      Single_Face([], [], []),
      Single_Face([], [], []),
    );

    Piece_model new_inner = Piece_model(
        pieces_id,1,false,
        'inner',
        'F',
        'inner',
        box_pieces[inner].Piece_width,
        down_Distence,
        10,
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate),
        new_inner_faces);
    pieces_id++;

    Join_model join_model_1 = Join_model(Point_model(shelf_material_thickness / 2, 30, 0), 8, 32, 'fixed_shelf');
    Join_model join_model_2 = Join_model(Point_model(shelf_material_thickness / 2, 60, 0), 8, 32, 'fixed_shelf');
    Join_model join_model_3 = Join_model(Point_model(shelf_material_thickness / 2, depth_of_shelf / 2, 0), 8, 32, 'fixed_shelf');
    Join_model join_model_4 = Join_model(Point_model(shelf_material_thickness / 2, depth_of_shelf - 60, 0), 8, 32, 'fixed_shelf');
    Join_model join_model_5 = Join_model(Point_model(shelf_material_thickness / 2, depth_of_shelf - 30, 0), 8, 32, 'fixed_shelf');

    Join_model join_model_6 = Join_model(Point_model(34, 60, 0), 15, 13, 'fixed_shelf');
    Join_model join_model_7 = Join_model(Point_model(34, depth_of_shelf - 60, 0), 15, 13, 'fixed_shelf');
    Join_model join_model_8 = Join_model(Point_model(box_pieces[inner].Piece_width - 34, 60, 0), 15, 13, 'fixed_shelf');
    Join_model join_model_9 = Join_model(Point_model(box_pieces[inner].Piece_width - 34, depth_of_shelf - 60, 0), 15, 13, 'fixed_shelf');

    Join_model join_model_small_1 = Join_model(Point_model(34, depth_of_shelf / 2, 0), 15, 13, 'fixed_shelf');
    Join_model join_model_small_2 = Join_model(Point_model(box_pieces[inner].Piece_width - 34, depth_of_shelf / 2, 0), 15, 13, 'fixed_shelf');

    Single_Face new_Piece_top_face = Single_Face([old_inner_id], [], []);

    Single_Face new_Piece_base_face;

    if (shelf_type == 'fixed_shelf') {
      if (depth_of_shelf > fix_shelf_limet) {
        new_Piece_base_face = Single_Face([
          new_inner_id
        ], [
          join_model_6,
          join_model_7,
          join_model_8,
          join_model_9,
        ], []);
      } else {
        new_Piece_base_face = Single_Face([
          new_inner_id
        ], [
          join_model_small_1,
          join_model_small_2,
        ], []);
      }
    } else {
      new_Piece_base_face = Single_Face([new_inner_id], [], []);
    }

    Single_Face new_right_face;

    if (shelf_type == 'fixed_shelf') {
      if (depth_of_shelf > fix_shelf_limet) {
        new_right_face = Single_Face([
          box_pieces[inner].piece_faces.right_face.face_item.first
        ], [
          join_model_1,
          join_model_2,
          join_model_3,
          join_model_4,
          join_model_5,
        ], []);
      } else {
        new_right_face = Single_Face([
          box_pieces[inner].piece_faces.right_face.face_item.first
        ], [
          join_model_1,
          join_model_3,
          join_model_5,
        ], []);
      }
    } else {
      new_right_face = box_pieces[inner].piece_faces.right_face;
    }

    Single_Face new_left_face;
    if (shelf_type == 'fixed_shelf') {
      if (depth_of_shelf > fix_shelf_limet) {
        new_left_face = Single_Face([
          box_pieces[inner].piece_faces.left_face.face_item.first
        ], [
          join_model_1,
          join_model_2,
          join_model_3,
          join_model_4,
          join_model_5,
        ], []);
      } else {
        new_left_face = Single_Face([
          box_pieces[inner].piece_faces.left_face.face_item.first
        ], [
          join_model_1,
          join_model_3,
          join_model_5,
        ], []);
      }
    } else {
      new_left_face = box_pieces[inner].piece_faces.left_face;
    }

    Single_Face new_Piece_front_face = Single_Face([0], [], []);
    Single_Face new_Piece_back_face = Single_Face([0], [], []);

    Face_model new_piece_faces = Face_model(
        new_Piece_top_face,
        new_right_face,
        new_Piece_base_face,
        new_left_face,
        new_Piece_front_face,
        new_Piece_back_face);

    Piece_model new_piece = Piece_model(
        pieces_id,shelf_quantity,is_copy,
        '$shelf_type',
        !(shelf_type == 'help_shelf') ? 'H' : 'help_shelf',
        init_material_name,
        depth_of_shelf,
        box_pieces[inner].Piece_width,
        shelf_material_thickness,
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate + down_Distence,
            box_pieces[inner].piece_origin.z_coordinate),
        new_piece_faces);
    pieces_id++;

    /// EDIT ALL SIDES
    /// 1-RIGHT
    ///edit right side

    int right_side_id =
        box_pieces[inner].piece_faces.right_face.face_item.first;

    Piece_model right_side_piece =
        box_pieces.where((element) => element.piece_id == right_side_id).first;

    List<int> right_side_new_left_face_items = [];

    for (int i = 0;
        i < right_side_piece.piece_faces.left_face.face_item.length;
        i++) {
      if (right_side_piece.piece_faces.left_face.face_item[i] ==
          box_pieces[inner].piece_id) {
        right_side_new_left_face_items.add(old_inner_id);
        right_side_new_left_face_items.add(new_piece_id);
        right_side_new_left_face_items.add(new_inner_id);
      } else {
        right_side_new_left_face_items
            .add(right_side_piece.piece_faces.left_face.face_item[i]);
      }
    }

    late Point_model right_side_shelf_hole_point_1;
    late Point_model right_side_shelf_hole_point_2;

    late Point_model right_side_fixed_shelf_p_1;
    late Point_model right_side_fixed_shelf_p_2;
    late Point_model right_side_fixed_shelf_p_3;
    late Point_model right_side_fixed_shelf_p_4;
    late Point_model right_side_fixed_shelf_p_5;

    if (right_side_piece.piece_name == 'partition') {
      right_side_shelf_hole_point_1 = Point_model(60, box_pieces[inner].piece_origin.y_coordinate + down_Distence - 2, 0);
      right_side_shelf_hole_point_2 = Point_model(depth_of_shelf - 60, box_pieces[inner].piece_origin.y_coordinate + down_Distence - 2, 0);

      right_side_fixed_shelf_p_1 = Point_model(30, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
      right_side_fixed_shelf_p_2 = Point_model(60, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
      right_side_fixed_shelf_p_3 = Point_model(depth_of_shelf / 2, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
      right_side_fixed_shelf_p_4 = Point_model(depth_of_shelf - 60, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
      right_side_fixed_shelf_p_5 = Point_model(depth_of_shelf - 30, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
    } else {
      right_side_shelf_hole_point_1 = Point_model(60 + 24, box_pieces[inner].piece_origin.y_coordinate + down_Distence - 2, 0);
      right_side_shelf_hole_point_2 = Point_model(box_depth - frontage_Gap - 60, box_pieces[inner].piece_origin.y_coordinate + down_Distence - 2, 0);

      right_side_fixed_shelf_p_1 = Point_model(24 + 30, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
      right_side_fixed_shelf_p_2 = Point_model(24 + 60, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
      right_side_fixed_shelf_p_3 = Point_model(24 + depth_of_shelf / 2, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
      right_side_fixed_shelf_p_4 = Point_model(24 + depth_of_shelf - 60, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
      right_side_fixed_shelf_p_5 = Point_model(24 + depth_of_shelf - 30, box_pieces[inner].piece_origin.y_coordinate + down_Distence + shelf_material_thickness / 2, 0);
    }

    if (shelf_type == 'fixed_shelf') {
      if (depth_of_shelf > fix_shelf_limet) {
        right_side_piece.piece_faces.left_face.join_list
            .add(Join_model(right_side_fixed_shelf_p_1, 8, 10, 'fixed_shelf'));
        right_side_piece.piece_faces.left_face.join_list
            .add(Join_model(right_side_fixed_shelf_p_2, 10, 10, 'fixed_shelf'));
        right_side_piece.piece_faces.left_face.join_list
            .add(Join_model(right_side_fixed_shelf_p_3, 8, 10, 'fixed_shelf'));
        right_side_piece.piece_faces.left_face.join_list
            .add(Join_model(right_side_fixed_shelf_p_4, 10, 10, 'fixed_shelf'));
        right_side_piece.piece_faces.left_face.join_list
            .add(Join_model(right_side_fixed_shelf_p_5, 8, 10, 'fixed_shelf'));
      } else {
        right_side_piece.piece_faces.left_face.join_list
            .add(Join_model(right_side_fixed_shelf_p_1, 8, 10, 'fixed_shelf'));
        right_side_piece.piece_faces.left_face.join_list
            .add(Join_model(right_side_fixed_shelf_p_3, 10, 10, 'fixed_shelf'));
        right_side_piece.piece_faces.left_face.join_list
            .add(Join_model(right_side_fixed_shelf_p_4, 8, 10, 'fixed_shelf'));
      }
    } else if (shelf_type == 'shelf') {
      right_side_piece.piece_faces.left_face.join_list
          .add(Join_model(right_side_shelf_hole_point_1, 5, 10, 'shelf'));
      right_side_piece.piece_faces.left_face.join_list
          .add(Join_model(right_side_shelf_hole_point_2, 5, 10, 'shelf'));
    }
    Piece_model right_piece_new = Piece_model(
        right_side_piece.piece_id,right_side_piece.piece_quantity,right_side_piece.is_copy,
        right_side_piece.piece_name,
        right_side_piece.piece_direction,
        right_side_piece.material_name,
        right_side_piece.Piece_width,
        right_side_piece.Piece_height,
        right_side_piece.Piece_thickness,
        right_side_piece.piece_origin,
        Face_model(
            right_side_piece.piece_faces.top_face,
            right_side_piece.piece_faces.right_face,
            right_side_piece.piece_faces.base_face,
            Single_Face(
                right_side_new_left_face_items,
                right_side_piece.piece_faces.left_face.join_list,
                right_side_piece.piece_faces.left_face.groove_list),
            right_side_piece.piece_faces.front_face,
            right_side_piece.piece_faces.back_face));

    ///

    /// 2_LEFT
    ///edit left side

    int left_side_id = box_pieces[inner].piece_faces.left_face.face_item.first;
    Piece_model left_side_piece =
        box_pieces.where((element) => element.piece_id == left_side_id).first;

    List<int> left_side_new_right_face_items = [];

    for (int i = 0;
        i < left_side_piece.piece_faces.right_face.face_item.length;
        i++) {
      if (left_side_piece.piece_faces.right_face.face_item[i] ==
          box_pieces[inner].piece_id) {
        left_side_new_right_face_items.add(old_inner_id);
        left_side_new_right_face_items.add(new_piece_id);
        left_side_new_right_face_items.add(new_inner_id);
      } else {
        left_side_new_right_face_items
            .add(left_side_piece.piece_faces.right_face.face_item[i]);
      }
    }

    late Point_model left_side_shelf_hole_point_a1;
    late Point_model left_side_shelf_hole_point_a2;
    late Point_model left_side_fixed_shelf_p_1;
    late Point_model left_side_fixed_shelf_p_2;
    late Point_model left_side_fixed_shelf_p_3;
    late Point_model left_side_fixed_shelf_p_4;
    late Point_model left_side_fixed_shelf_p_5;

    if (left_side_piece.piece_name == 'partition') {
      left_side_shelf_hole_point_a1 = Point_model( 60,
          box_pieces[inner].piece_origin.y_coordinate + down_Distence - 2, 0);
      left_side_shelf_hole_point_a2 = Point_model(  depth_of_shelf - 60,
          box_pieces[inner].piece_origin.y_coordinate + down_Distence - 2, 0);

      left_side_fixed_shelf_p_1 = Point_model(
           30,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
      left_side_fixed_shelf_p_2 = Point_model(
           60,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
      left_side_fixed_shelf_p_3 = Point_model(
           depth_of_shelf / 2,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
      left_side_fixed_shelf_p_4 = Point_model(
            depth_of_shelf - 60,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
      left_side_fixed_shelf_p_5 = Point_model(
           depth_of_shelf - 30,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
    } else {
      left_side_shelf_hole_point_a1 = Point_model(  60 + 24,
          box_pieces[inner].piece_origin.y_coordinate + down_Distence - 2, 0);
      left_side_shelf_hole_point_a2 = Point_model( depth_of_shelf - 60,
          box_pieces[inner].piece_origin.y_coordinate + down_Distence - 2, 0);

      left_side_fixed_shelf_p_1 = Point_model(
           24 + 30,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
      left_side_fixed_shelf_p_2 = Point_model(
           24 + 60,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
      left_side_fixed_shelf_p_3 = Point_model(
           24 +depth_of_shelf / 2,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
      left_side_fixed_shelf_p_4 = Point_model(
          24 +depth_of_shelf - 60,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
      left_side_fixed_shelf_p_5 = Point_model(
          24 + depth_of_shelf - 30,
          box_pieces[inner].piece_origin.y_coordinate +
              down_Distence +
              shelf_material_thickness / 2,
          0);
    }

    if (shelf_type == 'fixed_shelf') {
      if (depth_of_shelf > fix_shelf_limet) {
        left_side_piece.piece_faces.right_face.join_list
            .add(Join_model(left_side_fixed_shelf_p_1, 8, 10, 'fixed_shelf'));
        left_side_piece.piece_faces.right_face.join_list
            .add(Join_model(left_side_fixed_shelf_p_2, 10, 10, 'fixed_shelf'));
        left_side_piece.piece_faces.right_face.join_list
            .add(Join_model(left_side_fixed_shelf_p_3, 8, 10, 'fixed_shelf'));
        left_side_piece.piece_faces.right_face.join_list
            .add(Join_model(left_side_fixed_shelf_p_4, 10, 10, 'fixed_shelf'));
        left_side_piece.piece_faces.right_face.join_list
            .add(Join_model(left_side_fixed_shelf_p_5, 8, 10, 'fixed_shelf'));
      } else {
        left_side_piece.piece_faces.right_face.join_list
            .add(Join_model(left_side_fixed_shelf_p_1, 8, 10, 'fixed_shelf'));
        left_side_piece.piece_faces.right_face.join_list
            .add(Join_model(left_side_fixed_shelf_p_3, 10, 10, 'fixed_shelf'));
        left_side_piece.piece_faces.right_face.join_list
            .add(Join_model(left_side_fixed_shelf_p_4, 8, 10, 'fixed_shelf'));
      }
    } else if (shelf_type == 'shelf') {
      left_side_piece.piece_faces.right_face.join_list
          .add(Join_model(left_side_shelf_hole_point_a1, 5, 10, 'shelf'));
      left_side_piece.piece_faces.right_face.join_list
          .add(Join_model(left_side_shelf_hole_point_a2, 5, 10, 'shelf'));
    }

    Piece_model left_piece_new = Piece_model(
        left_side_piece.piece_id,left_side_piece.piece_quantity,left_side_piece.is_copy,
        left_side_piece.piece_name,
        left_side_piece.piece_direction,
        left_side_piece.material_name,
        left_side_piece.Piece_width,
        left_side_piece.Piece_height,
        left_side_piece.Piece_thickness,
        left_side_piece.piece_origin,
        Face_model(
            left_side_piece.piece_faces.top_face,
            Single_Face(
                left_side_new_right_face_items,
                left_side_piece.piece_faces.right_face.join_list,
                left_side_piece.piece_faces.right_face.groove_list),
            left_side_piece.piece_faces.base_face,
            left_side_piece.piece_faces.left_face,
            left_side_piece.piece_faces.front_face,
            left_side_piece.piece_faces.back_face));

    ///
    ///
    /// 3_TOP
    ///edit top side

    int top_side_id = box_pieces[inner].piece_faces.top_face.face_item.first;
    Piece_model top_side_piece =
        box_pieces.where((element) => element.piece_id == top_side_id).first;

    List<int> top_side_new_base_face_items = [];

    for (int i = 0;
        i < top_side_piece.piece_faces.base_face.face_item.length;
        i++) {
      if (top_side_piece.piece_faces.base_face.face_item[i] ==
          box_pieces[inner].piece_id) {
        top_side_new_base_face_items.add(old_inner_id);
      } else {
        top_side_new_base_face_items
            .add(top_side_piece.piece_faces.base_face.face_item[i]);
      }
    }
    Piece_model top_piece_new = Piece_model(
        top_side_piece.piece_id,top_side_piece.piece_quantity,top_side_piece.is_copy,
        top_side_piece.piece_name,
        top_side_piece.piece_direction,
        top_side_piece.material_name,
        top_side_piece.Piece_width,
        top_side_piece.Piece_height,
        top_side_piece.Piece_thickness,
        top_side_piece.piece_origin,
        Face_model(
            top_side_piece.piece_faces.top_face,
            top_side_piece.piece_faces.right_face,
            Single_Face(
                top_side_new_base_face_items,
                top_side_piece.piece_faces.base_face.join_list,
                top_side_piece.piece_faces.base_face.groove_list),
            top_side_piece.piece_faces.left_face,
            top_side_piece.piece_faces.front_face,
            top_side_piece.piece_faces.back_face));

    ///
    ///

    /// 4_BASE
    ///edit base side

    int base_side_id = box_pieces[inner].piece_faces.base_face.face_item.first;
    Piece_model base_side_piece =
        box_pieces.where((element) => element.piece_id == base_side_id).first;

    List<int> base_side_new_base_face_items = [];

    for (int i = 0;
        i < base_side_piece.piece_faces.top_face.face_item.length;
        i++) {
      if (base_side_piece.piece_faces.top_face.face_item[i] ==
          box_pieces[inner].piece_id) {
        base_side_new_base_face_items.add(new_inner_id);
      } else {
        base_side_new_base_face_items
            .add(base_side_piece.piece_faces.top_face.face_item[i]);
      }
    }
    Piece_model base_piece_new = Piece_model(
        base_side_piece.piece_id,base_side_piece.piece_quantity,base_side_piece.is_copy,
        base_side_piece.piece_name,
        base_side_piece.piece_direction,
        base_side_piece.material_name,
        base_side_piece.Piece_width,
        base_side_piece.Piece_height,
        base_side_piece.Piece_thickness,
        base_side_piece.piece_origin,
        Face_model(
            Single_Face(
                base_side_new_base_face_items,
                base_side_piece.piece_faces.top_face.join_list,
                base_side_piece.piece_faces.top_face.groove_list),
            base_side_piece.piece_faces.right_face,
            base_side_piece.piece_faces.base_face,
            base_side_piece.piece_faces.left_face,
            base_side_piece.piece_faces.front_face,
            base_side_piece.piece_faces.back_face));

    ///
    ///

    box_pieces.remove(box_pieces[inner]);

    box_pieces.removeWhere((element) => element.piece_id == left_side_id);
    box_pieces.removeWhere((element) => element.piece_id == right_side_id);
    box_pieces.removeWhere((element) => element.piece_id == top_side_id);
    box_pieces.removeWhere((element) => element.piece_id == base_side_id);

    box_pieces.add(old_inner);
    box_pieces.add(new_piece);
    box_pieces.add(right_piece_new);
    box_pieces.add(left_piece_new);
    box_pieces.add(top_piece_new);
    box_pieces.add(base_piece_new);

    box_pieces.add(new_inner);


  }

  add_Shelf(int inner, double top_Distence, double frontage_Gap,
      double shelf_material_thickness, int Quantity, String shelf_type) {
    if (Quantity == 1) {
      if (box_pieces[inner].Piece_height > top_Distence && top_Distence > 0) {
        add_Shelf_pattern(inner, top_Distence, frontage_Gap,
            shelf_material_thickness, shelf_type,false,Quantity);
        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    } else {
      if (((Quantity - 1) * top_Distence +
              Quantity * shelf_material_thickness) <
          box_pieces[inner].Piece_height) {
        double distance = double.parse(((box_pieces[inner].Piece_height -
            Quantity * shelf_material_thickness) /
            (Quantity + 1)).toStringAsFixed(1));

        add_Shelf_pattern(inner, distance, frontage_Gap,
            shelf_material_thickness, shelf_type,false,Quantity);

        for (int i = 1; i < Quantity; i++) {
          add_Shelf_pattern(box_pieces.length - 1, distance, frontage_Gap,
              shelf_material_thickness, shelf_type,true,Quantity);

        }

        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }
  }

  ///start Partition

  add_Partition_pattern(int inner, double left_Distence, double frontage_Gap,
      double partition_material_thickness,bool is_copy,int Partition_quantity) {


    double right_Distence = box_pieces[inner].Piece_width -
        left_Distence -
        partition_material_thickness;

    double depth_of_partition = box_depth - 24 - frontage_Gap;

    int old_inner_id = pieces_id;
    int new_inner_id = pieces_id + 1;
    int new_piece_id = pieces_id + 2;

    Face_model old_inner_faces = Face_model(
      Single_Face(
          [box_pieces[inner].piece_faces.top_face.face_item.first], [], []),
      Single_Face([new_piece_id], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.base_face.face_item.first], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.left_face.face_item.first], [], []),
      Single_Face([], [], []),
      Single_Face([], [], []),
    );

    Piece_model old_inner = Piece_model(
        pieces_id,1,false,
        'inner',
        'F',
        'inner',
        left_Distence,
        box_pieces[inner].Piece_height,
        1,
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate),
        old_inner_faces);
    pieces_id++;

    Face_model new_inner_faces = Face_model(
      Single_Face(
          [box_pieces[inner].piece_faces.top_face.face_item.first], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.right_face.face_item.first], [], []),
      Single_Face(
          [box_pieces[inner].piece_faces.base_face.face_item.first], [], []),
      Single_Face([new_piece_id], [], []),
      Single_Face([], [], []),
      Single_Face([], [], []),
    );

    Piece_model new_inner = Piece_model(
        pieces_id,1,false,
        'inner',
        'F',
        'inner',
        right_Distence,
        box_pieces[inner].Piece_height,
        10,
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate +
                left_Distence +
                partition_material_thickness,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate),
        new_inner_faces);
    pieces_id++;

    /// new piece partition

    List<Join_model> partition_joins = [];
    List<Join_model> partition_joins_15mm = [];

    Join_model j1    = Join_model(Point_model(35, partition_material_thickness / 2, 0), 8, 10, 'boring');
    Join_model j2    = Join_model(Point_model(65, partition_material_thickness / 2, 0), 8, 10, 'boring');
    Join_model j3    = Join_model(Point_model(depth_of_partition / 2, partition_material_thickness / 2, 0), 8, 10, 'boring');
    Join_model j4    = Join_model(Point_model(depth_of_partition - 65, partition_material_thickness / 2, 0), 8, 10, 'boring');
    Join_model j5    = Join_model(Point_model(depth_of_partition - 35, partition_material_thickness / 2, 0), 8, 10, 'boring');
    Join_model f_j_1 = Join_model(Point_model(65, 34, 0), 15, 13, 'boring');
    Join_model f_j_2 = Join_model(Point_model(depth_of_partition - 65, 34, 0), 15, 13, 'boring');
    Join_model f_j_3 = Join_model(Point_model(65, box_pieces[inner].Piece_height - 34, 0), 15, 13, 'boring');
    Join_model f_j_4 = Join_model(Point_model(depth_of_partition - 65, box_pieces[inner].Piece_height - 34, 0), 15, 13, 'boring');



    if (depth_of_partition > fix_shelf_limet) {
      partition_joins.add(j1);
      partition_joins.add(j2);
      partition_joins.add(j3);
      partition_joins.add(j4);
      partition_joins.add(j5);

      partition_joins_15mm.add(f_j_1);
      partition_joins_15mm.add(f_j_2);
      partition_joins_15mm.add(f_j_3);
      partition_joins_15mm.add(f_j_4);
    } else {
      partition_joins.add(j1);
      partition_joins.add(j3);
      partition_joins.add(j5);




      partition_joins_15mm.add(Join_model(
          Point_model(depth_of_partition / 2, 34, 0), 15, 13, 'boring'));
      partition_joins_15mm.add(Join_model(
          Point_model(
              depth_of_partition / 2, box_pieces[inner].Piece_height - 34, 0),
          15,
          13,
          'boring'));
    }

    Single_Face new_Piece_top_face = Single_Face(box_pieces[inner].piece_faces.top_face.face_item, partition_joins, []);
    Single_Face new_Piece_right_face = Single_Face([new_inner_id], partition_joins_15mm, []);
    Single_Face new_Piece_base_face = Single_Face(box_pieces[inner].piece_faces.base_face.face_item, partition_joins, []);
    Single_Face new_Piece_left_face = Single_Face([old_inner_id], [], []);
    Single_Face new_Piece_front_face = Single_Face([0], [], []);
    Single_Face new_Piece_back_face = Single_Face([0], [], []);

    Face_model new_piece_faces = Face_model(
        new_Piece_top_face,
        new_Piece_right_face,
        new_Piece_base_face,
        new_Piece_left_face,
        new_Piece_front_face,
        new_Piece_back_face);

    Piece_model new_piece = Piece_model(
        pieces_id,Partition_quantity,is_copy,
        'partition',
        'V',
        init_material_name,
        depth_of_partition,
        box_pieces[inner].Piece_height,
        partition_material_thickness,
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate + left_Distence,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate),
        new_piece_faces);

    pieces_id++;

    /// EDIT ALL SIDES
    /// 1-RIGHT
    ///edit right side

    int right_side_id = box_pieces[inner].piece_faces.right_face.face_item.first;
    Piece_model right_side_piece = box_pieces.where((element) => element.piece_id == right_side_id).first;

    List<int> right_side_new_left_face_items = [];

    for (int i = 0;
        i < right_side_piece.piece_faces.left_face.face_item.length;
        i++) {
      if (right_side_piece.piece_faces.left_face.face_item[i] ==
          box_pieces[inner].piece_id) {
        right_side_new_left_face_items.add(new_inner_id);
      } else {
        right_side_new_left_face_items
            .add(right_side_piece.piece_faces.left_face.face_item[i]);
      }
    }
    Piece_model right_piece_new = Piece_model(
        right_side_piece.piece_id,right_side_piece.piece_quantity,right_side_piece.is_copy,
        right_side_piece.piece_name,
        right_side_piece.piece_direction,
        right_side_piece.material_name,
        right_side_piece.Piece_width,
        right_side_piece.Piece_height,
        right_side_piece.Piece_thickness,
        right_side_piece.piece_origin,
        Face_model(
            right_side_piece.piece_faces.top_face,
            right_side_piece.piece_faces.right_face,
            right_side_piece.piece_faces.base_face,
            Single_Face(
                right_side_new_left_face_items,
                right_side_piece.piece_faces.left_face.join_list,
                right_side_piece.piece_faces.left_face.groove_list),
            right_side_piece.piece_faces.front_face,
            right_side_piece.piece_faces.back_face));

    ///

    /// 2_LEFT
    ///edit left side

    int left_side_id = box_pieces[inner].piece_faces.left_face.face_item.first;
    Piece_model left_side_piece =
        box_pieces.where((element) => element.piece_id == left_side_id).first;

    List<int> left_side_new_right_face_items = [];

    for (int i = 0;
        i < left_side_piece.piece_faces.right_face.face_item.length;
        i++) {
      if (left_side_piece.piece_faces.right_face.face_item[i] ==
          box_pieces[inner].piece_id) {
        left_side_new_right_face_items.add(old_inner_id);
      } else {
        left_side_new_right_face_items
            .add(left_side_piece.piece_faces.right_face.face_item[i]);
      }
    }
    Piece_model left_piece_new = Piece_model(
        left_side_piece.piece_id,left_side_piece.piece_quantity,left_side_piece.is_copy,
        left_side_piece.piece_name,
        left_side_piece.piece_direction,
        left_side_piece.material_name,
        left_side_piece.Piece_width,
        left_side_piece.Piece_height,
        left_side_piece.Piece_thickness,
        left_side_piece.piece_origin,
        Face_model(
            left_side_piece.piece_faces.top_face,
            Single_Face(
                left_side_new_right_face_items,
                left_side_piece.piece_faces.right_face.join_list,
                left_side_piece.piece_faces.right_face.groove_list),
            left_side_piece.piece_faces.base_face,
            left_side_piece.piece_faces.left_face,
            left_side_piece.piece_faces.front_face,
            left_side_piece.piece_faces.back_face));

    ///
    ///

    /// ..............................................................................
    var left_piece = box_pieces
        .where((element) =>
            element.piece_id ==
            (box_pieces[inner].piece_faces.left_face.face_item.first))
        .first;
    double left_piece_thickness = left_piece.Piece_thickness;

    double absolute_left_distence =
        box_pieces[inner].piece_origin.x_coordinate +
            left_Distence -
            left_piece_thickness +
            partition_material_thickness / 2;

    var bottom_piece = box_pieces
        .where((element) =>
            element.piece_id ==
            (box_pieces[inner].piece_faces.base_face.face_item.first))
        .first;
    double absolute_base_distence =
        bottom_piece.piece_origin.x_coordinate - left_piece_thickness;

    var top_piece = box_pieces
        .where((element) =>
            element.piece_id ==
            (box_pieces[inner].piece_faces.top_face.face_item.first))
        .first;
    double absolute_top_distence =
        top_piece.piece_origin.x_coordinate - left_piece_thickness;

    late double top_des;
    late double base_des;

    if (top_piece.piece_name == "shelf" ||
        top_piece.piece_name == "fixed_shelf") {
      top_des = absolute_left_distence - absolute_top_distence;
    } else if (top_piece.piece_name == "top") {
      top_des = absolute_left_distence;
    }

    if (bottom_piece.piece_name == "shelf" ||
        bottom_piece.piece_name == "fixed_shelf") {
      base_des = absolute_left_distence - absolute_base_distence;
    } else if (bottom_piece.piece_name == "base") {
      base_des = absolute_left_distence;
    }

    /// ..............................................................................
    /// 3_TOP
    ///edit top side

    int top_side_id = box_pieces[inner].piece_faces.top_face.face_item.first;
    Piece_model top_side_piece = box_pieces.where((element) => element.piece_id == top_side_id).first;
   late Piece_model top_side_piece_2 ;

   if(box_type!="wall_box"){
     top_side_piece_2 = box_pieces.where((element) => element.piece_id == top_side_id+1).first;
   }
    List<int> top_side_new_base_face_items = [];

    for (int i = 0;
        i < top_side_piece.piece_faces.base_face.face_item.length;
        i++) {
      if (top_side_piece.piece_faces.base_face.face_item[i] ==
          box_pieces[inner].piece_id) {
        top_side_new_base_face_items.add(old_inner_id);
        top_side_new_base_face_items.add(new_piece_id);
        top_side_new_base_face_items.add(new_inner_id);
      } else {
        top_side_new_base_face_items
            .add(top_side_piece.piece_faces.base_face.face_item[i]);
      }
    }

    List<Join_model> top_piece_bace_face = [];
    List<Join_model> top_2_piece_bace_face = [];

    if (top_side_piece.piece_name == 'shelf' ||
        top_side_piece.piece_name == "fixed_shelf") {
      if (depth_of_partition > fix_shelf_limet) {
        top_piece_bace_face.add(Join_model(Point_model(top_des, 35, 0), 8, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, 65, 0), 10, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, depth_of_partition / 2, 0), 8, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, depth_of_partition - 65, 0), 10, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, depth_of_partition - 35, 0), 8, 10, 'boring'));
      } else {
        top_piece_bace_face.add(Join_model(Point_model(top_des, 35, 0), 8, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, 24 + depth_of_partition / 2, 0), 10, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, depth_of_partition - 35, 0), 8, 10, 'boring'));
      }
      top_side_piece.piece_faces.base_face.join_list.forEach((element) {
          top_piece_bace_face.add(element);
        });

    }
    else {
      if(box_type=="wall_box"){
        top_piece_bace_face.add(Join_model(Point_model(top_des,24+ 35, 0), 8, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des,24+ 65, 0), 10, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, depth_of_partition / 2, 0), 8, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, 24+depth_of_partition - 65, 0), 10, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, 24+depth_of_partition - 35, 0), 8, 10, 'boring'));
    top_side_piece.piece_faces.base_face.join_list.forEach((element) {
    top_piece_bace_face.add(element);
    });
      }
      else{
        top_piece_bace_face.add(Join_model(Point_model(top_des, 30, 0), 8, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, 50, 0), 10, 10, 'boring'));
        top_piece_bace_face.add(Join_model(Point_model(top_des, 80, 0), 8, 10, 'boring'));


        top_2_piece_bace_face.add(Join_model(Point_model(top_des, 25, 0), 8, 10, 'boring'));
        top_2_piece_bace_face.add(Join_model(Point_model(top_des, 50, 0), 10, 10, 'boring'));
        top_2_piece_bace_face.add(Join_model(Point_model(top_des, 75, 0), 8, 10, 'boring'));

    top_side_piece.piece_faces.base_face.join_list.forEach((element) {top_piece_bace_face.add(element);});
    top_side_piece_2.piece_faces.base_face.join_list.forEach((element) {top_2_piece_bace_face.add(element);});


    }

    }



    Piece_model top_1_piece_new = Piece_model(
        top_side_piece.piece_id,1,top_side_piece.is_copy,
        top_side_piece.piece_name,
        top_side_piece.piece_direction,
        top_side_piece.material_name,
        top_side_piece.Piece_width,
        top_side_piece.Piece_height,
        top_side_piece.Piece_thickness,
        top_side_piece.piece_origin,
        Face_model(
            top_side_piece.piece_faces.top_face,
            top_side_piece.piece_faces.right_face,
            Single_Face(top_side_new_base_face_items, top_piece_bace_face,
                top_side_piece.piece_faces.base_face.groove_list),
            top_side_piece.piece_faces.left_face,
            top_side_piece.piece_faces.front_face,
            top_side_piece.piece_faces.back_face));

    late Piece_model top_2_piece_new;
    if(box_type!="wall_box") {
       top_2_piece_new = Piece_model(
          top_side_piece_2.piece_id,1,top_side_piece_2.is_copy,
          top_side_piece_2.piece_name,
          top_side_piece_2.piece_direction,
          top_side_piece_2.material_name,
          top_side_piece_2.Piece_width,
          top_side_piece_2.Piece_height,
          top_side_piece_2.Piece_thickness,
          top_side_piece_2.piece_origin,
          Face_model(
              top_side_piece_2.piece_faces.top_face,
              top_side_piece_2.piece_faces.right_face,
              Single_Face(
                  top_side_new_base_face_items, top_2_piece_bace_face, []),
              top_side_piece_2.piece_faces.left_face,
              top_side_piece_2.piece_faces.front_face,
              top_side_piece_2.piece_faces.back_face));
    }
    ///
    ///

    /// 4_BASE
    ///edit base side

    int base_side_id = box_pieces[inner].piece_faces.base_face.face_item.first;
    Piece_model base_side_piece = box_pieces.where((element) => element.piece_id == base_side_id).first;
    late Piece_model base_2_side_piece ;
    if(box_type=="inner_box"){
      base_2_side_piece = box_pieces.where((element) => element.piece_id == base_side_id+1).first;
    }

    List<int> base_side_new_base_face_items = [];

    late Piece_model base_piece_new_1;
    late Piece_model base_piece_new_2;


    for (int i = 0; i < base_side_piece.piece_faces.top_face.face_item.length; i++) {
        if (base_side_piece.piece_faces.top_face.face_item[i] == box_pieces[inner].piece_id)
        {
          base_side_new_base_face_items.add(old_inner_id);
          base_side_new_base_face_items.add(new_piece_id);
          base_side_new_base_face_items.add(new_inner_id);

        }
        else {
          base_side_new_base_face_items.add(base_side_piece.piece_faces.top_face.face_item[i]);
        }
      }


      Join_model BASE_p_j_1;
      Join_model BASE_p_j_2;
      Join_model BASE_p_j_3;
      Join_model BASE_p_j_4;
      Join_model BASE_p_j_5;

      if (base_side_piece.piece_name == 'shelf' || base_side_piece.piece_name == 'fixed_shelf') {
        BASE_p_j_1 = Join_model(Point_model(base_des, 35, 0), 8, 10, 'boring');
        BASE_p_j_2 = Join_model(Point_model(base_des, 65, 0), 10, 10, 'boring');
        BASE_p_j_3 = Join_model(
            Point_model(base_des, depth_of_partition / 2, 0), 8, 10, 'boring');
        BASE_p_j_4 = Join_model(
            Point_model(base_des, depth_of_partition - 65, 0), 10, 10, 'boring');
        BASE_p_j_5 = Join_model(
            Point_model(base_des, depth_of_partition - 35, 0), 8, 10, 'boring');


        List<Join_model> base_piece_top_face = [];
        base_side_piece.piece_faces.top_face.join_list.forEach((element) {
          base_piece_top_face.add(element);
        });

        if (depth_of_partition > fix_shelf_limet) {
          base_piece_top_face.add(BASE_p_j_1);
          base_piece_top_face.add(BASE_p_j_2);
          base_piece_top_face.add(BASE_p_j_3);
          base_piece_top_face.add(BASE_p_j_4);
          base_piece_top_face.add(BASE_p_j_5);
        } else {
          base_piece_top_face.add(BASE_p_j_1);
          base_piece_top_face.add(Join_model(
              Point_model(top_des, box_depth - 24 - depth_of_partition / 2, 0),
              10,
              10,
              'boring'));
          base_piece_top_face.add(BASE_p_j_5);
        }

         base_piece_new_1 = Piece_model(
            base_side_piece.piece_id,1,base_side_piece.is_copy,
            base_side_piece.piece_name,
            base_side_piece.piece_direction,
            base_side_piece.material_name,
            base_side_piece.Piece_width,
            base_side_piece.Piece_height,
            base_side_piece.Piece_thickness,
            base_side_piece.piece_origin,
            Face_model(
                Single_Face(base_side_new_base_face_items, base_piece_top_face,
                    base_side_piece.piece_faces.top_face.groove_list),
                base_side_piece.piece_faces.right_face,
                base_side_piece.piece_faces.base_face,
                base_side_piece.piece_faces.left_face,
                base_side_piece.piece_faces.front_face,
                base_side_piece.piece_faces.back_face));


      }

      else {

        if(box_type=="inner_box"){

          List<Join_model> base_1_piece_top_face=[];
          List<Join_model> base_2_piece_top_face=[];

          base_1_piece_top_face.add(Join_model(Point_model(base_des, 70, 0), 8, 10, 'boring'));
          base_1_piece_top_face.add(Join_model(Point_model(base_des, 50, 0), 10, 10, 'boring'));
          base_1_piece_top_face.add(Join_model(Point_model(base_des, 20, 0), 8, 10, 'boring'));

          base_2_piece_top_face.add(Join_model(Point_model(base_des, 25, 0), 8, 10, 'boring'));
          base_2_piece_top_face.add(Join_model(Point_model(base_des, 50, 0), 10, 10, 'boring'));
          base_2_piece_top_face.add(Join_model(Point_model(base_des, 75, 0), 8, 10, 'boring'));


         Join_model j_1=(Join_model(Point_model(init_material_thickness/2, 25, 0), 8, 33, 'boring'));
         Join_model j_2=(Join_model(Point_model(init_material_thickness/2, 50, 0), 8, 33, 'boring'));
         Join_model j_3=(Join_model(Point_model(init_material_thickness/2, 75, 0), 8, 33, 'boring'));


          base_piece_new_1 = Piece_model(
              base_side_piece.piece_id,1,base_side_piece.is_copy,
              base_side_piece.piece_name,
              base_side_piece.piece_direction,
              base_side_piece.material_name,
              base_side_piece.Piece_width,
              base_side_piece.Piece_height,
              base_side_piece.Piece_thickness,
              base_side_piece.piece_origin,
              Face_model(
                  Single_Face(base_side_new_base_face_items, base_1_piece_top_face,
                      base_side_piece.piece_faces.top_face.groove_list),
                  base_side_piece.piece_faces.right_face,
                  base_side_piece.piece_faces.base_face,
                  base_side_piece.piece_faces.left_face,
                  base_side_piece.piece_faces.front_face,
                  base_side_piece.piece_faces.back_face));


          base_piece_new_2 = Piece_model(
              base_side_piece.piece_id+1,1,base_side_piece.is_copy,
              base_side_piece.piece_name,
              base_side_piece.piece_direction,
              base_side_piece.material_name,
              base_side_piece.Piece_width,
              base_side_piece.Piece_height,
              base_side_piece.Piece_thickness,
              base_side_piece.piece_origin,
              Face_model(
                  Single_Face(base_side_new_base_face_items, base_2_piece_top_face,[]),
                  Single_Face(base_side_piece.piece_faces.right_face.face_item, [j_1,j_2, j_3,],[]),
                  base_side_piece.piece_faces.base_face,
                  Single_Face(base_side_piece.piece_faces.left_face.face_item,  [j_1,j_2, j_3,],[]),
                  base_side_piece.piece_faces.front_face,
                  base_side_piece.piece_faces.back_face));







        }
        else{
          BASE_p_j_1 = Join_model(Point_model(base_des, box_depth - 24 - 35, 0), 8, 10, 'boring');
          BASE_p_j_2 = Join_model(Point_model(base_des, box_depth - 24 - 65, 0), 10, 10, 'boring');
          BASE_p_j_3 = Join_model(Point_model(base_des, box_depth - 24 - depth_of_partition / 2, 0), 8, 10, 'boring');
          BASE_p_j_4 = Join_model(Point_model(base_des, box_depth - 24 - depth_of_partition + 65, 0), 10, 10, 'boring');
          BASE_p_j_5 = Join_model(Point_model(base_des, box_depth - 24 - depth_of_partition + 35, 0), 8, 10, 'boring');

          List<Join_model> base_piece_top_face = [];
          base_side_piece.piece_faces.top_face.join_list.forEach((element) {
            base_piece_top_face.add(element);
          });

          if (depth_of_partition > fix_shelf_limet) {
            base_piece_top_face.add(BASE_p_j_1);
            base_piece_top_face.add(BASE_p_j_2);
            base_piece_top_face.add(BASE_p_j_3);
            base_piece_top_face.add(BASE_p_j_4);
            base_piece_top_face.add(BASE_p_j_5);
          }
          else {
            base_piece_top_face.add(BASE_p_j_1);
            base_piece_top_face.add(Join_model(Point_model(top_des, box_depth - 24 - depth_of_partition / 2, 0), 10, 10, 'boring'));
            base_piece_top_face.add(BASE_p_j_5);
          }

          base_piece_new_1 = Piece_model(
              base_side_piece.piece_id,1,base_side_piece.is_copy,
              base_side_piece.piece_name,
              base_side_piece.piece_direction,
              base_side_piece.material_name,
              base_side_piece.Piece_width,
              base_side_piece.Piece_height,
              base_side_piece.Piece_thickness,
              base_side_piece.piece_origin,
              Face_model(
                  Single_Face(base_side_new_base_face_items, base_piece_top_face,
                      base_side_piece.piece_faces.top_face.groove_list),
                  base_side_piece.piece_faces.right_face,
                  base_side_piece.piece_faces.base_face,
                  base_side_piece.piece_faces.left_face,
                  base_side_piece.piece_faces.front_face,
                  base_side_piece.piece_faces.back_face));


        }


      }




    ///
    ///

    box_pieces.remove(box_pieces[inner]);

    box_pieces.removeWhere((element) => element.piece_id == left_side_id);
    box_pieces.removeWhere((element) => element.piece_id == right_side_id);

    if(box_type=="wall_box"){
      box_pieces.removeWhere((element) => element.piece_id == top_side_id);

    }else{
          box_pieces.removeWhere((element) => element.piece_id == top_side_id);
          box_pieces.removeWhere((element) => element.piece_id == top_side_id+1);

    }

    if(box_type=="inner_box"){
      box_pieces.removeWhere((element) => element.piece_id == base_piece_new_1.piece_id);
      box_pieces.removeWhere((element) => element.piece_id == base_piece_new_1.piece_id+1);

    }else{
      box_pieces.removeWhere((element) => element.piece_id == base_piece_new_1);

    }


    box_pieces.removeWhere((element) => element.piece_id == base_side_id);

    box_pieces.add(old_inner);
    box_pieces.add(new_piece);
    box_pieces.add(right_piece_new);
    box_pieces.add(left_piece_new);



    if(box_type=="wall_box"){
      box_pieces.add(top_1_piece_new);

    }else{
      box_pieces.add(top_1_piece_new);
      box_pieces.add(top_2_piece_new);

    }
    if(box_type=="inner_box"){
      box_pieces.add(base_piece_new_1);
      box_pieces.add(base_piece_new_2);

    }else{
      box_pieces.add(base_piece_new_1);
    }


    box_pieces.add(new_inner);


  }

  add_Partition(int inner, double left_Distence, double frontage_Gap,
      double partition_material_thickness, int Quantity) {
    if (Quantity == 1) {
      if (box_pieces[inner].Piece_width > left_Distence && left_Distence > 0) {
        add_Partition_pattern(
            inner, left_Distence, frontage_Gap, partition_material_thickness,false,Quantity);
        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }


    else {

      if (
      ( (Quantity - 1) * left_Distence + Quantity * partition_material_thickness) < box_pieces[inner].Piece_width
         )
      {
        double distance = double.parse(((box_pieces[inner].Piece_width - Quantity * partition_material_thickness) / (Quantity + 1)).toStringAsFixed(1));

          add_Partition_pattern(inner                , distance, frontage_Gap, partition_material_thickness,false,Quantity);

        for (int i = 1; i < Quantity; i++) {
          add_Partition_pattern(box_pieces.length - 1, distance, frontage_Gap, partition_material_thickness,true ,Quantity);
        }


        Navigator.of(Get.overlayContext!).pop();


      }
      else
      {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }
  }

  /// end door

  add_door(Door_Model door_model) {
    if (door_model.door_num == 1) {
      add_single_door_pattern(door_model);
    } else {
      add_double_door_pattern(door_model);
    }
  }

  add_single_door_pattern(Door_Model door_model) {
    Piece_model door_inner = box_pieces[door_model.inner_id];

    double right_thickness = box_pieces[box_pieces.indexOf(box_pieces
                .where((element) =>
                    element.piece_id ==
                    door_inner.piece_faces.right_face.face_item.first)
                .first)]
            .Piece_thickness *
        door_model.right_over_lap;

    double left_thickness = box_pieces[box_pieces.indexOf(box_pieces
                .where((element) =>
                    element.piece_id ==
                    door_inner.piece_faces.left_face.face_item.first)
                .first)]
            .Piece_thickness *
        door_model.left_over_lap;

    double top_thickness = box_pieces[box_pieces.indexOf(box_pieces
                .where((element) =>
                    element.piece_id ==
                    door_inner.piece_faces.top_face.face_item.first)
                .first)]
            .Piece_thickness *
        door_model.up_over_lap;

    double base_thickness = box_pieces[box_pieces.indexOf(box_pieces
                .where((element) =>
                    element.piece_id ==
                    door_inner.piece_faces.base_face.face_item.first)
                .first)]
            .Piece_thickness *
        door_model.down_over_lap;

    double door_width = door_inner.Piece_width +
        right_thickness +
        left_thickness -
        2 * door_model.round_gap;
    double door_hight = door_inner.Piece_height +
        top_thickness +
        base_thickness -
        2 * door_model.round_gap;

    late int hinges_quantity;
    if(door_hight<=900)
      hinges_quantity=2;
    else if(door_hight>=900 && door_hight<=1600)
      hinges_quantity=3;
    else if(door_hight>=1600 && door_hight<=2000)
      hinges_quantity=4;
    else if(door_hight>2000)
      hinges_quantity=5;

    late  double x_cord ;
    late  double x_cord_1 ;

    if(door_model.direction=="L"){
      x_cord=22.5;
      x_cord_1=22.5+6;

    }else if(door_model.direction=="R"){
      x_cord=door_width-22.5;
      x_cord_1=door_width-22.5-6;
    }

    late double intiat_distence;
    if(((door_hight)/(hinges_quantity+1))<100){
      intiat_distence=70;
    }else{
      intiat_distence=100;
    }

    double y_cord=intiat_distence ;
    List<Join_model> hinges=[];
    double dis_between_hinges=(door_hight-2*intiat_distence)/(hinges_quantity-1);

    for(int i=0;i<hinges_quantity;i++){

      Point_model point_model_1=Point_model(x_cord, y_cord, 0);
      Point_model point_model_2=Point_model(x_cord_1, y_cord+24, 0);
      Point_model point_model_3=Point_model(x_cord_1, y_cord-24, 0);

      Join_model join_model_1=Join_model(point_model_1, 35, 13, 'hinges hole');
      Join_model join_model_2=Join_model(point_model_2, 1, 2, 'hinges screw hole');
      Join_model join_model_3=Join_model(point_model_3, 1, 2, 'hinges screw hole');

      hinges.add(join_model_1);
      hinges.add(join_model_2);
      hinges.add(join_model_3);

      y_cord+=dis_between_hinges;

    }


    Point_model door_origin = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness +
            door_model.round_gap,
        door_inner.piece_origin.y_coordinate -
            base_thickness +
            door_model.round_gap,
        door_inner.piece_origin.z_coordinate - 1);
    Face_model door_faces = Face_model(
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], hinges, []));

    Piece_model door_piece = Piece_model(
        pieces_id,1,false,
        'Door',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin,
        door_faces);

    box_pieces.add(door_piece);
  }

  add_double_door_pattern(Door_Model door_model) {
    Piece_model door_inner = box_pieces[door_model.inner_id];

    double right_thickness = box_pieces[box_pieces.indexOf(box_pieces
                .where((element) =>
                    element.piece_id ==
                    door_inner.piece_faces.right_face.face_item.first)
                .first)]
            .Piece_thickness *
        door_model.right_over_lap;

    double left_thickness = box_pieces[box_pieces.indexOf(box_pieces
                .where((element) =>
                    element.piece_id ==
                    door_inner.piece_faces.left_face.face_item.first)
                .first)]
            .Piece_thickness *
        door_model.left_over_lap;

    double top_thickness = box_pieces[box_pieces.indexOf(box_pieces
                .where((element) =>
                    element.piece_id ==
                    door_inner.piece_faces.top_face.face_item.first)
                .first)]
            .Piece_thickness *
        door_model.up_over_lap;

    double base_thickness = box_pieces[box_pieces.indexOf(box_pieces
                .where((element) =>
                    element.piece_id ==
                    door_inner.piece_faces.base_face.face_item.first)
                .first)]
            .Piece_thickness *
        door_model.down_over_lap;

    double door_width = double.parse(((door_inner.Piece_width +
        right_thickness +
        left_thickness -
        2 * door_model.round_gap) /
        2 -
        door_model.round_gap / 2).toStringAsFixed(1));

    double door_hight = double.parse((door_inner.Piece_height +
        top_thickness +
        base_thickness -
        2 * door_model.round_gap).toStringAsFixed(1));

    Point_model door_origin_1 = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness +
            door_model.round_gap,
        door_inner.piece_origin.y_coordinate -
            base_thickness +
            door_model.round_gap,
        door_inner.piece_origin.z_coordinate - 1);
    Point_model door_origin_2 = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness +
            door_model.round_gap +
            door_width +
            door_model.round_gap,
        door_inner.piece_origin.y_coordinate -
            base_thickness +
            door_model.round_gap,
        door_inner.piece_origin.z_coordinate - 1);


    ///  ///////////////////////////////////////


    late int hinges_quantity;

    if(door_hight<=900)
      hinges_quantity=2;
    else if(door_hight>=900 && door_hight<=1600)
      hinges_quantity=3;
    else if(door_hight>=1600 && door_hight<=2000)
      hinges_quantity=4;
    else if(door_hight>2000)
      hinges_quantity=5;






    List<Join_model> Right_door_hinges=[];
    List<Join_model> Left_door_hinges=[];


    late double intiat_distence;
    if(((door_hight)/(hinges_quantity+1))<100){
      intiat_distence=70;
    }else{
      intiat_distence=100;
    }

    double dis_between_hinges=(door_hight-2*intiat_distence)/(hinges_quantity-1);



    double y_cord=intiat_distence;

    for(int i=0;i<hinges_quantity;i++){

      Point_model point_model_1=Point_model(door_width-22.5, y_cord, 0);
      Point_model point_model_2=Point_model(door_width-22.5-6, y_cord+24, 0);
      Point_model point_model_3=Point_model(door_width-22.5-6, y_cord-24, 0);

      Join_model join_model_1=Join_model(point_model_1, 35, 13, 'hinges hole');
      Join_model join_model_2=Join_model(point_model_2, 1, 2, 'hinges screw hole');
      Join_model join_model_3=Join_model(point_model_3, 1, 2, 'hinges screw hole');

      Right_door_hinges.add(join_model_1);
      Right_door_hinges.add(join_model_2);
      Right_door_hinges.add(join_model_3);

      y_cord+=dis_between_hinges;

    }

     y_cord=intiat_distence;
    for(int i=0;i<hinges_quantity;i++){

      Point_model point_model_1=Point_model(22.5, y_cord, 0);
      Point_model point_model_2=Point_model(22.5+6, y_cord+24, 0);
      Point_model point_model_3=Point_model(22.5+6, y_cord-24, 0);

      Join_model join_model_1=Join_model(point_model_1,35, 13, 'hinges hole');
      Join_model join_model_2=Join_model(point_model_2, 1, 2, 'hinges screw hole');
      Join_model join_model_3=Join_model(point_model_3, 1, 2, 'hinges screw hole');

      Left_door_hinges.add(join_model_1);
      Left_door_hinges.add(join_model_2);
      Left_door_hinges.add(join_model_3);

      y_cord+=dis_between_hinges;

    }


    Face_model Right_door_faces = Face_model(
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], Right_door_hinges, []));

    Face_model left_door_faces = Face_model(
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], Left_door_hinges, []));


    ///  ///////////////////////////////////////



    Piece_model door_piece_1 = Piece_model(
        pieces_id,1,false,
        'Right Door',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_1,
        Right_door_faces);
    Piece_model door_piece_2 = Piece_model(
        pieces_id,1,false,
        'Left Door',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_2,
        left_door_faces);

    box_pieces.add(door_piece_1);
    box_pieces.add(door_piece_2);
  }


  add_Join(Piece_model piece_model , Point_model p1,Point p2){

  }


}
