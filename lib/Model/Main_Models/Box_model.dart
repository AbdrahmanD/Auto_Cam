import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam/Model/Main_Models/Drawer_model.dart';
import 'package:auto_cam/Model/Main_Models/Face_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Model/Main_Models/Point_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Box_model {
  late int box_id;
  late double box_width;
  late double box_height;
  late double box_depth;
  late double init_material_thickness;
  late double backpanel_thickness;
  late Point_model box_origin;
  late List<Piece_model> box_pieces;
  late List<Drawer_model> box_drawers;
  int pieces_id = 1;

  Box_model(this.box_width, this.box_height, this.box_depth,
      this.init_material_thickness, this.backpanel_thickness) {
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

    Single_Face top_Piece_top_face = Single_Face([0], [], []);
    Single_Face top_Piece_right_face = Single_Face([2], [], []);
    Single_Face top_Piece_base_face = Single_Face([5], [], []);
    Single_Face top_Piece_left_face = Single_Face([4], [], []);
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
    Piece_model top_piece = Piece_model(
        pieces_id,
        'top',
        'H',
        'box_material',
        box_depth,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness, 0),
        top_faces);
    pieces_id++;
    ////////////////////////////////////////////////////////////////////////////

    /// 2- initiate the (right) piece of the box
    /// 2-1 initiate the Faces of the right piece
    ///

    Single_Face right_Piece_top_face = Single_Face([0], [], []);
    Single_Face right_Piece_right_face = Single_Face([0], [], []);
    Single_Face right_Piece_base_face = Single_Face([0], [], []);
    Single_Face right_Piece_left_face = Single_Face([1, 5, 3], [], []);
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
        pieces_id,
        'right',
        'V',
        'box_material',
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(
            box_origin.x_coordinate + box_width - init_material_thickness,
            box_origin.y_coordinate,
            0),
        right_faces);
    pieces_id++;
    ////////////////////////////////////////////////////////////////////////////

    /// 4- initiate the (base) piece of the box
    /// 4-1 initiate the Faces of the base piece

    Single_Face base_Piece_top_face = Single_Face([5], [], []);
    Single_Face base_Piece_right_face = Single_Face([2], [], []);
    Single_Face base_Piece_base_face = Single_Face([0], [], []);
    Single_Face base_Piece_left_face = Single_Face([4], [], []);
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
    Piece_model base_piece = Piece_model(
        pieces_id,
        'base',
        'H',
        'box_material',
        box_depth,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate, 0),
        base_faces);
    pieces_id++;
    ////////////////////////////////////////////////////////////////////////////

    /// 3- initiate the (left) piece of the box
    /// 3-1 initiate the Faces of the left piece

    Single_Face left_Piece_top_face = Single_Face([0], [], []);
    Single_Face left_Piece_right_face = Single_Face([1, 5, 3], [], []);
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
        pieces_id,
        'left',
        'V',
        'box_material',
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate, box_origin.y_coordinate, 0),
        left_faces);
    pieces_id++;

    ////////////////////////////////////////////////////////////////////////////

    /// 6- initiate the (main inner) piece of the box
    /// 6-1 initiate the Faces of the inner piece

    Single_Face inner_Piece_top_face = Single_Face([1], [], []);
    Single_Face inner_Piece_right_face = Single_Face([2], [], []);
    Single_Face inner_Piece_base_face = Single_Face([3], [], []);
    Single_Face inner_Piece_left_face = Single_Face([4], [], []);
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
        pieces_id,
        'inner',
        'F',
        'inner_id_material',
        box_width - init_material_thickness * 2,
        box_height - init_material_thickness * 2,
        backpanel_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + init_material_thickness, 0),
        inner_panel_faces);
    pieces_id++;
    ////////////////////////////////////////////////////////////////////////////

    box_pieces = [];

    box_pieces.add(top_piece);
    box_pieces.add(right_piece);
    box_pieces.add(base_piece);
    box_pieces.add(left_piece);
    box_pieces.add(inner_piece);

    ////////////////////////////////////////////////////////////////////////////

    /// 5- initiate the (back_panel) piece of the box
    /// 5-1 initiate the Faces of the back_panel piece

    Single_Face back_panel_Piece_top_face = Single_Face([1], [], []);
    Single_Face back_panel_Piece_right_face = Single_Face([2], [], []);
    Single_Face back_panel_Piece_base_face = Single_Face([3], [], []);
    Single_Face back_panel_Piece_left_face = Single_Face([4], [], []);
    Single_Face back_panel_Piece_front_face = Single_Face([0], [], []);
    Single_Face back_panel_Piece_back_face = Single_Face([0], [], []);

    Face_model back_panel_faces = Face_model(
        back_panel_Piece_top_face,
        back_panel_Piece_right_face,
        back_panel_Piece_base_face,
        back_panel_Piece_left_face,
        back_panel_Piece_front_face,
        back_panel_Piece_back_face);

    Piece_model back_panel_piece = Piece_model(
        pieces_id,
        'back_panel',
        'F',
        'back_panel_id_material',
        box_width -
            (left_piece.Piece_thickness + right_piece.Piece_thickness) +
            18,
        box_height -
            (top_piece.Piece_thickness + base_piece.Piece_thickness) +
            18,
        backpanel_thickness,
        Point_model(
            left_piece.Piece_thickness - 9, base_piece.Piece_thickness - 9, 0),
        back_panel_faces);

    pieces_id++;
    box_pieces.add(back_panel_piece);
  }

  add_Shelf_pattern(int inner, double top_Distence, double frontage_Gap,
      double shelf_material_thickness) {
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
        pieces_id,
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
        pieces_id,
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

    Single_Face new_Piece_top_face = Single_Face([old_inner_id], [], []);
    Single_Face new_Piece_right_face = box_pieces[inner].piece_faces.right_face;
    Single_Face new_Piece_base_face = Single_Face([new_inner_id], [], []);
    Single_Face new_Piece_left_face = box_pieces[inner].piece_faces.left_face;
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
        pieces_id,
        'shelf',
        'H',
        'material_name',
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
    Piece_model right_piece_new = Piece_model(
        right_side_piece.piece_id,
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
            Single_Face(right_side_new_left_face_items, [], []),
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
    Piece_model left_piece_new = Piece_model(
        left_side_piece.piece_id,
        left_side_piece.piece_name,
        left_side_piece.piece_direction,
        left_side_piece.material_name,
        left_side_piece.Piece_width,
        left_side_piece.Piece_height,
        left_side_piece.Piece_thickness,
        left_side_piece.piece_origin,
        Face_model(
            left_side_piece.piece_faces.top_face,
            Single_Face(left_side_new_right_face_items, [], []),
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
        top_side_piece.piece_id,
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
            Single_Face(top_side_new_base_face_items, [], []),
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
        base_side_piece.piece_id,
        base_side_piece.piece_name,
        base_side_piece.piece_direction,
        base_side_piece.material_name,
        base_side_piece.Piece_width,
        base_side_piece.Piece_height,
        base_side_piece.Piece_thickness,
        base_side_piece.piece_origin,
        Face_model(
            Single_Face(base_side_new_base_face_items, [], []),
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
      double shelf_material_thickness, int Quantity) {
    if (Quantity == 1) {
      if (box_pieces[inner].Piece_height > top_Distence && top_Distence > 0) {
        add_Shelf_pattern(
            inner, top_Distence, frontage_Gap, shelf_material_thickness);
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
        double distance = (box_pieces[inner].Piece_height -
                Quantity * shelf_material_thickness) /
            (Quantity + 1);

        add_Shelf_pattern(
            inner, distance, frontage_Gap, shelf_material_thickness);

        for (int i = 1; i < Quantity; i++) {
          add_Shelf_pattern(box_pieces.length - 1, distance, frontage_Gap,
              shelf_material_thickness);
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
      double partition_material_thickness) {
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
        pieces_id,
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
        pieces_id,
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

    Single_Face new_Piece_top_face = box_pieces[inner].piece_faces.top_face;
    Single_Face new_Piece_right_face = Single_Face([new_inner_id], [], []);
    Single_Face new_Piece_base_face = box_pieces[inner].piece_faces.base_face;
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
        pieces_id,
        'partition',
        'V',
        'material_name',
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
        right_side_new_left_face_items.add(new_inner_id);
      } else {
        right_side_new_left_face_items
            .add(right_side_piece.piece_faces.left_face.face_item[i]);
      }
    }
    Piece_model right_piece_new = Piece_model(
        right_side_piece.piece_id,
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
            Single_Face(right_side_new_left_face_items, [], []),
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
        left_side_piece.piece_id,
        left_side_piece.piece_name,
        left_side_piece.piece_direction,
        left_side_piece.material_name,
        left_side_piece.Piece_width,
        left_side_piece.Piece_height,
        left_side_piece.Piece_thickness,
        left_side_piece.piece_origin,
        Face_model(
            left_side_piece.piece_faces.top_face,
            Single_Face(left_side_new_right_face_items, [], []),
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
        top_side_new_base_face_items.add(new_piece_id);
        top_side_new_base_face_items.add(new_inner_id);
      } else {
        top_side_new_base_face_items
            .add(top_side_piece.piece_faces.base_face.face_item[i]);
      }
    }
    Piece_model top_piece_new = Piece_model(
        top_side_piece.piece_id,
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
            Single_Face(top_side_new_base_face_items, [], []),
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
        base_side_new_base_face_items.add(old_inner_id);
        base_side_new_base_face_items.add(new_piece_id);
        base_side_new_base_face_items.add(new_inner_id);
      } else {
        base_side_new_base_face_items
            .add(base_side_piece.piece_faces.top_face.face_item[i]);
      }
    }
    Piece_model base_piece_new = Piece_model(
        base_side_piece.piece_id,
        base_side_piece.piece_name,
        base_side_piece.piece_direction,
        base_side_piece.material_name,
        base_side_piece.Piece_width,
        base_side_piece.Piece_height,
        base_side_piece.Piece_thickness,
        base_side_piece.piece_origin,
        Face_model(
            Single_Face(base_side_new_base_face_items, [], []),
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

  add_Partition(int inner, double left_Distence, double frontage_Gap,
      double partition_material_thickness, int Quantity) {
    if (Quantity == 1) {
      if (box_pieces[inner].Piece_width > left_Distence && left_Distence > 0) {
        add_Partition_pattern(
            inner, left_Distence, frontage_Gap, partition_material_thickness);
        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    } else {
      if (((Quantity - 1) * left_Distence +
              Quantity * partition_material_thickness) <
          box_pieces[inner].Piece_width) {
        double distance = (box_pieces[inner].Piece_width -
                Quantity * partition_material_thickness) /
            (Quantity + 1);

        add_Partition_pattern(
            inner, distance, frontage_Gap, partition_material_thickness);

        for (int i = 1; i < Quantity; i++) {
          add_Partition_pattern(box_pieces.length - 1, distance, frontage_Gap,
              partition_material_thickness);
        }

        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }
  }

  /// end partition

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
        Single_Face([], [], []));

    Piece_model door_piece = Piece_model(
        pieces_id,
        'Door',
        'F',
        'material_name',
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

    double door_width = (door_inner.Piece_width +
                right_thickness +
                left_thickness -
                2 * door_model.round_gap) /
            2 -
        door_model.round_gap / 2;
    double door_hight = door_inner.Piece_height +
        top_thickness +
        base_thickness -
        2 * door_model.round_gap;

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

    Face_model door_faces = Face_model(
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []),
        Single_Face([], [], []));

    Piece_model door_piece_1 = Piece_model(
        pieces_id,
        'Door',
        'F',
        'material_name',
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_1,
        door_faces);
    Piece_model door_piece_2 = Piece_model(
        pieces_id,
        'Door',
        'F',
        'material_name',
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_2,
        door_faces);

    box_pieces.add(door_piece_1);
    box_pieces.add(door_piece_2);
  }

  add_horisontal_door_pattern(Door_Model door_model) {

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

    /// calculate the width and height

    double door_width = (door_inner.Piece_width +
                right_thickness +
                left_thickness -
                2 * door_model.round_gap) ;

    double door_hight = door_inner.Piece_height +
        top_thickness +
        base_thickness -
        2 * door_model.round_gap;

    ///

    double single_height=(door_hight-(door_model.door_num-1)*door_model.round_gap)/door_model.door_num;
    print("single_height :$single_height");


    for(int i=0;i<door_model.door_num;i++){


      Point_model door_origin = Point_model(
          door_inner.piece_origin.x_coordinate -
              left_thickness +
              door_model.round_gap,
          door_inner.piece_origin.y_coordinate -
              base_thickness +
              door_model.round_gap
          +(single_height+door_model.round_gap)*i,
          door_inner.piece_origin.z_coordinate - 1);

      Face_model door_faces = Face_model(
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []));

      Piece_model door_piece = Piece_model(
          pieces_id,
          'Door',
          'F',
          'material_name',
          door_width,
          single_height,
          door_model.material_thickness,
          door_origin,
          door_faces);

      box_pieces.add(door_piece);

      pieces_id++;

    }



  }
}
