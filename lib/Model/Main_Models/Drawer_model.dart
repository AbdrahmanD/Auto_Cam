import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Face_model.dart';
import 'package:auto_cam/Model/Main_Models/Groove_model.dart';
import 'package:auto_cam/Model/Main_Models/Join_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Model/Main_Models/Point_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Drawer_model {
  late int drawer_id;
  late int inner_id;
  late int drawer_type;

  late int drawer_quantity;

  late double All_base_gape;

  late double each_top_gape;
  late double left_gape;
  late double right_gape;

  late double drawer_face_material_thickness;
  late String drawer_face_material_name;

  late double drawer_box_material_thickness;
  late double drawer_base_material_thickness;
  late double drawer_box_height;
  late double drawer_box_depth;

  List<Join_model> right_rail_joins=[];
  List<Join_model> left_rail_joins=[];


  Drawer_model(
      this.drawer_id,
      this.inner_id,
      this.drawer_type,
      this.drawer_quantity,
      this.All_base_gape,
      this.each_top_gape,
      this.left_gape,
      this.right_gape,
      this.drawer_face_material_thickness,
      this.drawer_face_material_name,
      this.drawer_box_material_thickness,
      this.drawer_base_material_thickness,
      this.drawer_box_height,
      this.drawer_box_depth) {

    Draw_Controller draw_controller = Get.find();

    int drawer_id = draw_controller.box_repository.box_model.value.box_drawers.length;
    int piece_id  = draw_controller.box_repository.box_model.value.pieces_id;



    add_drawer(
      piece_id,
      drawer_id,
    );
    edit_sides();
    draw_controller.box_repository.box_model.value.box_drawers.add(this);
  }

  edit_sides(){

    Draw_Controller draw_controller = Get.find();


    int right_side_id = draw_controller.box_repository.box_model.value. box_pieces[inner_id].piece_faces.right_face.face_item.first;
    int left_side_id = draw_controller.box_repository.box_model.value. box_pieces[inner_id].piece_faces.left_face.face_item.first;

    Piece_model right_side_piece = draw_controller.box_repository.box_model.value.box_pieces.where((element) => element.piece_id == right_side_id).first;
    Piece_model left_side_piece = draw_controller.box_repository.box_model.value.box_pieces.where((element) => element.piece_id == left_side_id).first;





    for(int i=0;i<right_rail_joins.length;i++){

      right_side_piece.piece_faces.left_face.join_list.add(right_rail_joins[i]);

    }
    for(int i=0;i<left_rail_joins.length;i++){

      left_side_piece.piece_faces.right_face.join_list.add(left_rail_joins[i]);

    }




    ///
  }

  add_drawer(int piece_id, int drawer_id) {

    Draw_Controller draw_controller = Get.find();

    var inner =
        draw_controller.box_repository.box_model.value.box_pieces[inner_id];

    var my_right = draw_controller.box_repository.box_model.value.box_pieces
        .where((element) =>
            element.piece_id == inner.piece_faces.right_face.face_item.first);

    var my_left = draw_controller.box_repository.box_model.value.box_pieces
        .where((element) =>
            element.piece_id == inner.piece_faces.left_face.face_item.first);

    var my_base = draw_controller.box_repository.box_model.value.box_pieces
        .where((element) =>
            element.piece_id == inner.piece_faces.base_face.face_item.first);

    var my_top = draw_controller.box_repository.box_model.value.box_pieces
        .where((element) =>
            element.piece_id == inner.piece_faces.top_face.face_item.first);

    double right_thickness = my_right.first.Piece_thickness;
    double left_thickness = my_left.first.Piece_thickness;
    double top_thickness = my_top.first.Piece_thickness;
    double base_thickness = my_base.first.Piece_thickness;

    double total_inners = inner.Piece_height -
        (All_base_gape + each_top_gape * drawer_quantity) +
        top_thickness +
        base_thickness;

    double single_inner = double.parse((total_inners / drawer_quantity).toStringAsFixed(1));
    double face_height = single_inner;
    double box_height;

    if (drawer_box_height + 40 < face_height) {
      box_height = drawer_box_height;
    } else {
      box_height = double.parse((single_inner - 40).toStringAsFixed(1));

    }
    print(box_height);

    double face_width = double.parse((inner.Piece_width +
        left_thickness +
        right_thickness -
        left_gape -
        right_gape).toStringAsFixed(1));
    double drawer_box_width = double.parse((inner.Piece_width - 26).toStringAsFixed(1));

    for (int i = 0; i < drawer_quantity; i++) {
     late  bool is_copy;
      if(i==0)
        is_copy=false;
      else
        is_copy=true;

      late double y_distence;
      if (drawer_quantity == 1) {
        y_distence =
            All_base_gape + inner.piece_origin.y_coordinate - base_thickness;
      }
      else {
        y_distence = All_base_gape+ inner.piece_origin.y_coordinate- base_thickness + (face_height + each_top_gape) * i;
      }
      Point_model drawer_face_origin = Point_model(
          inner.piece_origin.x_coordinate - left_thickness + left_gape,
          y_distence,
          0);
      Point_model drawer_box_origin =
          Point_model(inner.piece_origin.x_coordinate + 13, y_distence + 20, 0);

      double dx =  drawer_box_origin.x_coordinate-drawer_face_origin.x_coordinate ;
      double dy = 20;
      double y_space;

      if (box_height > 100) {
        y_space = 34;
      } else {
        y_space = 24;
      }

      draw_controller.box_repository.box_model.value.box_pieces.add(
          add_drawer_face(piece_id + 1, drawer_id + 1,i+1, drawer_face_origin,
              face_height, face_width,dx,dy,y_space,box_height,drawer_box_width,is_copy));

      draw_controller.box_repository.box_model.value.pieces_id++;

      var drawer_pieces = add_drawer_box(piece_id + 2, drawer_id +1, i + 1,
          drawer_box_origin, drawer_box_width, box_height,dx,dy,y_space,is_copy);

      draw_controller.box_repository.box_model.value.pieces_id += 4;
      drawer_pieces.forEach((element) {
        draw_controller.box_repository.box_model.value.box_pieces.add(element);
      });

      double side_width=draw_controller.box_repository.box_model.value.box_depth;

     Join_model drawer_rail_r_1;
     Join_model drawer_rail_r_2;
     Join_model drawer_rail_r_3;

     Join_model drawer_rail_l_1;
     Join_model drawer_rail_l_2;
     Join_model drawer_rail_l_3;


      if(my_right.first.piece_name=='partition'){

        drawer_rail_r_1=Join_model(Point_model(side_width-8-24 , y_distence+45, 0), 3,1, 'boring');
        drawer_rail_r_2=Join_model(Point_model(side_width-182-24,y_distence+45, 0), 3,1, 'boring');
        drawer_rail_r_3=Join_model(Point_model(side_width-252-24,y_distence+45, 0), 3,1, 'boring');


      }else{

      drawer_rail_r_1=Join_model(Point_model(side_width-8 , y_distence+45, 0), 3,1, 'boring');
      drawer_rail_r_2=Join_model(Point_model(side_width-182,y_distence+45, 0), 3,1, 'boring');
      drawer_rail_r_3=Join_model(Point_model(side_width-252,y_distence+45, 0), 3,1, 'boring');
      }
     if(my_left.first.piece_name=='partition'){

        drawer_rail_l_1=Join_model(Point_model(side_width-8  -24, y_distence+45, 0), 3,1, 'boring');
        drawer_rail_l_2=Join_model(Point_model(side_width-182-24,y_distence+45, 0), 3,1, 'boring');
        drawer_rail_l_3=Join_model(Point_model(side_width-252-24,y_distence+45, 0), 3,1, 'boring');
     }else{
        drawer_rail_l_1=Join_model(Point_model(side_width-8 , y_distence+45, 0), 3,1, 'boring');
        drawer_rail_l_2=Join_model(Point_model(side_width-182,y_distence+45, 0), 3,1, 'boring');
        drawer_rail_l_3=Join_model(Point_model(side_width-252,y_distence+45, 0), 3,1, 'boring');
     }


      right_rail_joins.add(drawer_rail_r_1);
      right_rail_joins.add(drawer_rail_r_2);
      right_rail_joins.add(drawer_rail_r_3);



      left_rail_joins.add(drawer_rail_l_1);
     left_rail_joins.add(drawer_rail_l_2);
     left_rail_joins.add(drawer_rail_l_3);


    }
  }


  /// add drawer face
  Piece_model add_drawer_face(int id, int drawer_id,int num, Point_model face_origin,
      double height, double face_width,
      double dx,double dy,double y_space,double box_height,double box_width,bool is_copy
      ) {

    Point_model p1=Point_model(dx+drawer_box_material_thickness/2,                                         dy+y_space, 0);
    Point_model p2=Point_model(dx+drawer_box_material_thickness/2,                                         dy+box_height/2, 0);
    Point_model p3=Point_model(dx+drawer_box_material_thickness/2,                                         dy+(box_height-y_space), 0);
    Point_model p4=Point_model(dx+drawer_box_material_thickness/2+box_width-drawer_box_material_thickness, dy+y_space, 0);
    Point_model p5=Point_model(dx+drawer_box_material_thickness/2+box_width-drawer_box_material_thickness, dy+box_height/2, 0);
    Point_model p6=Point_model(dx+drawer_box_material_thickness/2+box_width-drawer_box_material_thickness, dy+(box_height-y_space), 0);








    Piece_model piece_model = Piece_model(
        id,drawer_quantity,is_copy,
        'drawer ${drawer_id} Face ',
        'F',
        '${drawer_face_material_thickness} mm ${drawer_face_material_name}',
        face_width,
        height,
        drawer_face_material_thickness,
        face_origin,
        Face_model(
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [
            Join_model(p1, 8,10, 'boring'),
            Join_model(p2, 10,10, 'boring'),
            Join_model(p3, 8,10, 'boring'),
            Join_model(p4, 8,10, 'boring'),
            Join_model(p5, 10,10, 'boring'),
            Join_model(p6, 8,10, 'boring'),
          ], []),
        ));

    return piece_model;

  }


  /// add drawer box pieces
  List<Piece_model> add_drawer_box(int piece_id, int drawer_id,int num,
      Point_model box_origin, double box_width, double box_height,
      double dx,double dy,double y_space,bool is_cope
      ) {

    List<Piece_model> drawer_box = [];

    Join_model join_1=Join_model(Point_model(drawer_box_material_thickness/2,y_space, 0), 8,10, 'boring');
    Join_model join_2=Join_model(Point_model(drawer_box_material_thickness/2,box_height/2, 0), 10,11, 'boring');
    Join_model join_3=Join_model(Point_model(drawer_box_material_thickness/2,(box_height-y_space), 0), 8,10, 'boring');

    Join_model join_4=Join_model(Point_model(drawer_box_depth-drawer_box_material_thickness/2,15+y_space, 0), 8,10, 'boring');
    Join_model join_5=Join_model(Point_model(drawer_box_depth-drawer_box_material_thickness/2,15+box_height/2, 0), 10,11, 'boring');
    Join_model join_6=Join_model(Point_model(drawer_box_depth-drawer_box_material_thickness/2,15+(box_height-y_space), 0), 8,10, 'boring');

    Join_model join_7_r=Join_model(Point_model(drawer_box_depth-34, box_height/2, 0), 15,13, 'boring');

    Join_model join_8 =Join_model(Point_model(drawer_box_material_thickness/2,y_space, 0), 8,32, 'boring');
    Join_model join_9 =Join_model(Point_model(drawer_box_material_thickness/2,box_height/2, 0), 8,32, 'boring');
    Join_model join_10=Join_model(Point_model(drawer_box_material_thickness/2,(box_height-y_space), 0), 8,32, 'boring');

    Groove_model groove_model=Groove_model(Point_model(0,12+drawer_base_material_thickness/2,0),
        Point_model(drawer_box_depth,12+drawer_base_material_thickness/2,0), drawer_base_material_thickness+0.1, 10);


    Join_model drawer_rail_1=Join_model(Point_model(drawer_box_depth-8  ,25, 0), 3,1, 'boring');
    Join_model drawer_rail_2=Join_model(Point_model(drawer_box_depth-182,25, 0), 3,1, 'boring');
    Join_model drawer_rail_3=Join_model(Point_model(drawer_box_depth-252,25, 0), 3,1, 'boring');



    /// left side

    Piece_model drawer_box_left = Piece_model(
        piece_id,drawer_quantity,is_cope,
        'drawer ${drawer_id} left ',
        'V',
        "${drawer_box_material_thickness} mm",
        drawer_box_depth,
        box_height,
        drawer_box_material_thickness,
        Point_model(box_origin.x_coordinate, box_origin.y_coordinate, 0),
        Face_model(
          Single_Face([], [], []),
          Single_Face([], [
            join_1,
            join_2,
            join_3,
            join_4,
            join_5,
            join_6,
          ], [groove_model]),
          Single_Face([], [], []),
          Single_Face([], [
            join_7_r,
            drawer_rail_1,
            drawer_rail_2,
            drawer_rail_3,
          ], []),
          Single_Face([], [
            join_8,
            join_9,
            join_10,
          ], []),
          Single_Face([], [], []),
        ));


    /// right side
    Piece_model drawer_box_right = Piece_model(
        piece_id + 1,drawer_quantity,is_cope,
        'drawer ${drawer_id} right ',
        'V',
        "${drawer_box_material_thickness} mm",
        drawer_box_depth,
        box_height,
        drawer_box_material_thickness,
        Point_model(
            box_origin.x_coordinate + box_width - drawer_box_material_thickness,
            box_origin.y_coordinate,
            0),
        Face_model(
          Single_Face([], [], []),
          Single_Face([], [
            join_7_r,
            drawer_rail_1,
            drawer_rail_2,
            drawer_rail_3,], []),
          Single_Face([], [], []),
          Single_Face([], [
            join_1,
            join_2,
            join_3,
            join_4,
            join_5,
            join_6,
          ], [groove_model]),
          Single_Face([], [
                join_8 ,
                join_9 ,
                join_10,
          ], []),
          Single_Face([], [], []),
        ));


    /// front side


    Join_model front_join_1=Join_model(Point_model(drawer_box_material_thickness/2,15+y_space, 0), 8,30, 'boring');
    Join_model front_join_2=Join_model(Point_model(drawer_box_material_thickness/2,15+box_height/2, 0), 8,30, 'boring');
    Join_model front_join_3=Join_model(Point_model(drawer_box_material_thickness/2,15+(box_height-y_space), 0), 8,30, 'boring');

    Join_model front_face_join_1=Join_model(Point_model(34, 15+box_height/2, 0), 15,13, 'boring');
    Join_model front_face_join_2=Join_model(Point_model(box_width-34-drawer_box_material_thickness*2,15+ box_height/2, 0), 15,13, 'boring');

    Groove_model front_back_grove=Groove_model(Point_model(0,12+drawer_base_material_thickness/2,0),
        Point_model(box_width-drawer_box_material_thickness*2,12+drawer_base_material_thickness/2,0),
        drawer_base_material_thickness+0.1, 10);

    Piece_model drawer_box_front = Piece_model(
        piece_id + 2,drawer_quantity,is_cope,
        'drawer ${drawer_id} front ',
        'F',
        "${drawer_box_material_thickness} mm",
        box_width - drawer_box_material_thickness * 2,
        box_height,
        drawer_box_material_thickness,
        Point_model(box_origin.x_coordinate + drawer_box_material_thickness,
            box_origin.y_coordinate, 0),
        Face_model(
          Single_Face([], [], []),
          Single_Face([], [
            front_join_1,
            front_join_2,
            front_join_3,
          ], []),
          Single_Face([], [], []),
          Single_Face([], [
            front_join_1,
            front_join_2,
            front_join_3,
          ], []),
          Single_Face([], [
            front_face_join_1,
            front_face_join_2
          ], []),
          Single_Face([], [], [front_back_grove]),
        ));


    /// back side

    Join_model back_join_1=Join_model(Point_model(drawer_box_material_thickness/2,y_space, 0), 8,30, 'boring');
    Join_model back_join_2=Join_model(Point_model(drawer_box_material_thickness/2,box_height/2, 0), 8,30, 'boring');
    Join_model back_join_3=Join_model(Point_model(drawer_box_material_thickness/2,(box_height-y_space), 0), 8,30, 'boring');

    Join_model back_face_join_1=Join_model(Point_model(34, box_height/2, 0), 15,13, 'boring');
    Join_model back_face_join_2=Join_model(Point_model(box_width-34-drawer_box_material_thickness*2, box_height/2, 0), 15, 13,'boring');


    Piece_model drawer_box_back = Piece_model(
        piece_id + 3,drawer_quantity,is_cope,
        'drawer ${drawer_id} back ',
        'F',
        "${drawer_box_material_thickness} mm",
        box_width - drawer_box_material_thickness * 2,
        box_height,
        drawer_box_material_thickness,
        Point_model(box_origin.x_coordinate + drawer_box_material_thickness,
            box_origin.y_coordinate, 0),
        Face_model(
          Single_Face([], [], []),
          Single_Face([], [
            back_join_1,
            back_join_2,
            back_join_3,
          ], []),
          Single_Face([], [], []),
          Single_Face([], [
            back_join_1,
            back_join_2,
            back_join_3,
          ], []),
          Single_Face([], [

          ], [front_back_grove]),
          Single_Face([], [back_face_join_1,
            back_face_join_2], []),
        ));

    Piece_model drawer_box_base_panel = Piece_model(
        piece_id + 4,drawer_quantity,is_cope,
        'drawer ${drawer_id} base_panel',
        'H',
        "${drawer_base_material_thickness} mm",

        drawer_box_depth-20,drawer_box_front.Piece_width + 20,
        drawer_base_material_thickness,
        Point_model(box_origin.x_coordinate + drawer_box_material_thickness-10,
            box_origin.y_coordinate+drawer_base_material_thickness/2+12, 0),
        Face_model(
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [], []),
          Single_Face([], [ ], []),
          Single_Face([], [], []),
        ));



    drawer_box.add(drawer_box_left);
    drawer_box.add(drawer_box_right);
    drawer_box.add(drawer_box_front);
    drawer_box.add(drawer_box_back);
    drawer_box.add(drawer_box_base_panel);

    return drawer_box;
  }


}
