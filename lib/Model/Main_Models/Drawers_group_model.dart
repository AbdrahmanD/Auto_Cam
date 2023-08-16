import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Join_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:get/get.dart';

class Drawers_group_model {
  late int drawer_id;
  late int inner_id;
  late String drawer_type;
late bool inner_drawer;
  late int drawer_quantity;

  late double All_base_gape;
  late double All_top_gape;
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


  Drawers_group_model(
      this.drawer_id,
      this.inner_id,
      this.drawer_type,
      this.inner_drawer,
      this.drawer_quantity,
      this.All_base_gape,
      this.All_top_gape,
      this.each_top_gape,
      this.left_gape,
      this.right_gape,
      this.drawer_face_material_thickness,
      this.drawer_face_material_name,
      this.drawer_box_material_thickness,
      this.drawer_base_material_thickness,
      this.drawer_box_height,
      this.drawer_box_depth
      );

  add_drawer()
  {

    Draw_Controller draw_controller = Get.find();

    double side_gap=10;
    if(drawer_type=='normal_side'){
      side_gap=26;
    }
    else if(drawer_type=='concealed_hafle_1'){
      side_gap=10;
    }

    double deferent_between_face_Y_and_box_y=20;
    var inner =
    draw_controller.box_repository.box_model.value.box_pieces[inner_id];

    double right_thickness = draw_controller.box_repository.box_model.value.init_material_thickness;
    double left_thickness  = draw_controller.box_repository.box_model.value.init_material_thickness;
    double top_thickness   = draw_controller.box_repository.box_model.value.init_material_thickness;
    double base_thickness  = draw_controller.box_repository.box_model.value.init_material_thickness;

    double total_inners = inner.piece_height -
        (All_base_gape +All_top_gape+ (each_top_gape * (drawer_quantity-1))) +
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
    // print(box_height);

    double face_width = double.parse((inner.piece_width +
        left_thickness +
        right_thickness -
        left_gape -
        right_gape).toStringAsFixed(1));

    double drawer_box_width = double.parse((inner.piece_width - side_gap).toStringAsFixed(1));

    for (int i = 0; i < drawer_quantity; i++) {


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
          inner_drawer?(inner.piece_origin.z_coordinate):(inner.piece_origin.z_coordinate-drawer_face_material_thickness));
      Point_model drawer_box_origin =
      Point_model(inner.piece_origin.x_coordinate + side_gap/2, y_distence + deferent_between_face_Y_and_box_y,
          inner_drawer?inner.piece_origin.z_coordinate+drawer_face_material_thickness:inner.piece_origin.z_coordinate);

      double dx =  drawer_box_origin.x_coordinate-drawer_face_origin.x_coordinate ;
      double dy = deferent_between_face_Y_and_box_y;
      double y_space;

      if (box_height > 100) {
        y_space = 34;
      } else {
        y_space = 24;
      }

      int piece_id=draw_controller.box_repository.box_model.value.box_pieces.length;

      draw_controller.box_repository.box_model.value.box_pieces.add(
          add_drawer_face(piece_id + 1, drawer_id + 1,i+1, drawer_face_origin,
              face_height, face_width,dx,dy,y_space,box_height,drawer_box_width));


      var drawer_pieces = add_drawer_box(piece_id + 2, drawer_id +1, i + 1,
          drawer_box_origin, drawer_box_width, box_height,dx,dy,y_space ,draw_controller.box_repository.pack_panel_grove_depth);


      drawer_pieces.forEach((element) {
        draw_controller.box_repository.box_model.value.box_pieces.add(element);
      });


    }
  }


  /// add drawer face
  Piece_model add_drawer_face(int id, int drawer_id,int num, Point_model face_origin,
      double height, double face_width,
      double dx,double dy,double y_space,double box_height,double box_width
      )
  {


    Piece_model piece_model = Piece_model(
        id,
        'drawer ${drawer_id} Face ',
        'F',
        '${drawer_face_material_thickness} mm ${drawer_face_material_name}',
        face_width,
        height,
        drawer_face_material_thickness,
        face_origin
    );

    return piece_model;

  }


  /// add drawer box pieces
  List<Piece_model> add_drawer_box(int piece_id, int drawer_id,int num,
      Point_model box_origin, double box_width, double box_height,
      double dx,double dy,double y_space ,double grove_depth
      )
  {

    List<Piece_model> drawer_box = [];



    /// left side

    Piece_model drawer_box_left = Piece_model(
        piece_id,
        'drawer ${drawer_id} left ',
        'V',
        "${drawer_box_material_thickness} mm",
        drawer_box_depth,
        box_height,
        drawer_box_material_thickness,
        Point_model(box_origin.x_coordinate, box_origin.y_coordinate, box_origin.z_coordinate),
       );


    /// right side
    Piece_model drawer_box_right = Piece_model(
        piece_id + 1,
        'drawer ${drawer_id} right ',
        'V',
        "${drawer_box_material_thickness} mm",
        drawer_box_depth,
        box_height,
        drawer_box_material_thickness,
        Point_model(
            box_origin.x_coordinate + box_width - drawer_box_material_thickness,
            box_origin.y_coordinate,
            box_origin.z_coordinate),
        );


    /// front side



    Piece_model drawer_box_front = Piece_model(
        piece_id + 2,
        'drawer ${drawer_id} front ',
        'F',
        "${drawer_box_material_thickness} mm",
        box_width - drawer_box_material_thickness * 2,
        box_height,
        drawer_box_material_thickness,
        Point_model(box_origin.x_coordinate + drawer_box_material_thickness,
            box_origin.y_coordinate, box_origin.z_coordinate),
        );


    /// back side

    Piece_model drawer_box_back = Piece_model(
        piece_id + 3,
        'drawer ${drawer_id} back ',
        'F',
        "${drawer_box_material_thickness} mm",
        box_width - drawer_box_material_thickness * 2,
        box_height,
        drawer_box_material_thickness,
        Point_model(box_origin.x_coordinate + drawer_box_material_thickness,
            box_origin.y_coordinate, box_origin.z_coordinate+drawer_box_depth-drawer_box_material_thickness),
        );

    Piece_model drawer_box_base_panel = Piece_model(
        piece_id + 4,
        'drawer ${drawer_id} base_panel',
        'H',
        "${drawer_base_material_thickness} mm",

        drawer_box_depth-20,drawer_box_front.piece_width + 20,
        drawer_base_material_thickness,
        Point_model(box_origin.x_coordinate + drawer_box_material_thickness-10,
            box_origin.y_coordinate+drawer_base_material_thickness/2+12,
            box_origin.z_coordinate+drawer_box_material_thickness-grove_depth),
        );



    drawer_box.add(drawer_box_left);
    drawer_box.add(drawer_box_right);
    drawer_box.add(drawer_box_front);
    drawer_box.add(drawer_box_back);
    drawer_box.add(drawer_box_base_panel);

    return drawer_box;
  }


}
