import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Group_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
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
  late double drawer_under_base_thickness;
  late double drawer_box_depth;

  late double drawer_face_up_distace;
  late double drawer_face_down_distace;

  late double side_gap;
  late  double drawer_slide_height;
  late bool double_face ;
  late  double front_gape;



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
      this.drawer_under_base_thickness,
      this.drawer_box_depth,
      this.drawer_face_up_distace,
      this.drawer_face_down_distace,
      this.side_gap,
      this.drawer_slide_height,
      this.double_face,
      this.front_gape);

  add_drawer()
  {

    Draw_Controller draw_controller = Get.find();

    List<Group_model> corrent_group=[];

    double deferent_between_face_Y_and_box_y=drawer_face_down_distace;

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


      box_height = double.parse((face_height - drawer_face_up_distace-drawer_face_down_distace).toStringAsFixed(1));



    double face_width = double.parse((inner.piece_width +
        left_thickness +
        right_thickness -
        left_gape -
        right_gape).toStringAsFixed(1));

    double drawer_box_width = double.parse((inner.piece_width - side_gap).toStringAsFixed(1));

    int drawer_groub_num=draw_controller.box_repository.box_model.value.drawer_groups.length+1;

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
          inner_drawer?(inner.piece_origin.z_coordinate+front_gape):
          (inner.piece_origin.z_coordinate-drawer_face_material_thickness-2));

      Point_model drawer_box_origin =
      Point_model(
          inner.piece_origin.x_coordinate + side_gap/2,
          y_distence + deferent_between_face_Y_and_box_y,
          inner_drawer?(inner.piece_origin.z_coordinate+drawer_face_material_thickness+front_gape):
          (inner.piece_origin.z_coordinate-2));

      double dx =  drawer_box_origin.x_coordinate-drawer_face_origin.x_coordinate ;
      double dy = deferent_between_face_Y_and_box_y;
      double y_space;

      if (box_height > 100) {
        y_space = 34;
      } else {
        y_space = 24;
      }


      Piece_model face=
      add_drawer_face(draw_controller.box_repository.box_model.value.get_id("Drawer Face")
          , drawer_id + 1,i+1, drawer_face_origin,
          face_height, face_width,dx,dy,y_space,box_height,drawer_box_width);

      draw_controller.box_repository.box_model.value.box_pieces.add(face);



Group_model drawer_pieces_as_group=Group_model("Drawer ${drawer_groub_num}-${i+1}", [],true);

      drawer_pieces_as_group.pieces.add(face);

      var drawer_pieces = add_drawer_box( drawer_id +1, i + 1,
          drawer_box_origin, drawer_box_width, box_height,dx,dy,y_space ,
          draw_controller.box_repository.pack_panel_grove_depth);


      drawer_pieces.forEach((element) {
        draw_controller.box_repository.box_model.value.box_pieces.add(element);
        drawer_pieces_as_group.pieces.add(element);

      });


      corrent_group.add(drawer_pieces_as_group);


    }
    draw_controller.box_repository.box_model.value.drawer_groups.add(corrent_group);


  }


  /// add drawer face
  Piece_model add_drawer_face(String id, int drawer_id,int num, Point_model face_origin,
      double height, double face_width,
      double dx,double dy,double y_space,double box_height,double box_width
      )
  {


    Piece_model piece_model = Piece_model(
        id,
        'Drawer Face ',
        'F',
        '${drawer_face_material_name}',
        face_width,
        height,
        drawer_face_material_thickness,
        face_origin,
    );

    return piece_model;

  }


  /// add drawer box pieces
  List<Piece_model> add_drawer_box( int drawer_id,int num,
      Point_model box_origin, double box_width, double box_height,
      double dx,double dy,double y_space ,double grove_depth
      )
  {

    List<Piece_model> drawer_box = [];
    Draw_Controller draw_controller = Get.find();



    /// left side

    Piece_model drawer_box_left = Piece_model(
      draw_controller.box_repository.box_model.value.get_id("DB Left"),
        'Drawer Left ',
        'V',
        "MDF",
        drawer_box_depth,
        box_height,
        drawer_box_material_thickness,
        Point_model(box_origin.x_coordinate, box_origin.y_coordinate, box_origin.z_coordinate),
       );


    /// right side
    Piece_model drawer_box_right = Piece_model(
      draw_controller.box_repository.box_model.value.get_id("DB Right"),
        'Drawer right ',
        'V',
        "MDF",
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
      draw_controller.box_repository.box_model.value.get_id("DB Front"),
        'Drawer Front ',
        'F',
        "MDF",
       correct_value( box_width - drawer_box_material_thickness * 2),
       correct_value( box_height),
       correct_value( drawer_box_material_thickness),
        Point_model(
            box_origin.x_coordinate + drawer_box_material_thickness,
            box_origin.y_coordinate,
            box_origin.z_coordinate),

        );


    /// back side

    Piece_model drawer_box_back = Piece_model(
      draw_controller.box_repository.box_model.value.get_id("DB Back"),
        'Drawer back ',
        'F',
        "MDF",
        correct_value(box_width - drawer_box_material_thickness * 2),
        correct_value(box_height),
        correct_value(drawer_box_material_thickness),
        Point_model(
            box_origin.x_coordinate + drawer_box_material_thickness,
            box_origin.y_coordinate,
            box_origin.z_coordinate+drawer_box_depth-drawer_box_material_thickness),
        );




    Piece_model drawer_box_base_panel = Piece_model(
      draw_controller.box_repository.box_model.value.get_id("Drawer Panel"),
        'Drawer base_panel',
        'H',
        "MDF",

double_face?
(drawer_box_depth-2*drawer_box_material_thickness+2*grove_depth-1):
(drawer_box_depth-drawer_box_material_thickness+2*grove_depth-1),

      drawer_box_front.piece_width +2*grove_depth+1,
        drawer_base_material_thickness,
        Point_model(box_origin.x_coordinate + drawer_box_material_thickness-  grove_depth+0.5,
            box_origin.y_coordinate+drawer_under_base_thickness,
           double_face?(box_origin.z_coordinate+drawer_box_material_thickness-grove_depth+0.5):
           (box_origin.z_coordinate-grove_depth+0.5)
        ),
         );


    Piece_model drawer_box_base_panel_Helper = Piece_model(
      draw_controller.box_repository.box_model.value.get_id("Helper"),
        'Drawer back_panel_Helper',
        'H',
        "MDF",

        double_face?(drawer_box_depth-2*drawer_box_material_thickness ):(drawer_box_depth-drawer_box_material_thickness ),
      drawer_box_front.piece_width  ,
        drawer_base_material_thickness,
        Point_model(box_origin.x_coordinate + drawer_box_material_thickness,
            box_origin.y_coordinate+drawer_under_base_thickness,
        double_face?(box_origin.z_coordinate+drawer_box_material_thickness):(box_origin.z_coordinate)
        ),
         );

    Group_model drawer_base_panel=Group_model("Helper",[drawer_box_base_panel,drawer_box_base_panel_Helper],true);
    draw_controller.box_repository.box_model.value.box_groups.add(drawer_base_panel);



    /// left side slider
    Piece_model drawer_left_slider = Piece_model(
      draw_controller.box_repository.box_model.value.get_id("Helper"),
      'Drawer_Helper',
      'H',
      "Helper",
      drawer_box_depth,
      side_gap/2,
      44,

      Point_model(box_origin.x_coordinate-side_gap/2,drawer_slide_height+ box_origin.y_coordinate-22,
          box_origin.z_coordinate-0.1),
   );

    /// right side slider
    Piece_model drawer_right_slider = Piece_model(
      draw_controller.box_repository.box_model.value.get_id("Helper"),
      'Drawer_Helper',
      'H',
      "Helper",
      drawer_box_depth,
      side_gap/2,
      44,

      Point_model(
          box_origin.x_coordinate + box_width ,
          drawer_slide_height+  box_origin.y_coordinate-22,
          box_origin.z_coordinate-0.1),
   );


    Group_model drawer_sildes=Group_model("Helper",[drawer_right_slider,drawer_left_slider],true);

    draw_controller.box_repository.box_model.value.box_groups.add(drawer_sildes);

    drawer_box.add(drawer_box_left);
    drawer_box.add(drawer_box_right);
    if (double_face) {
      drawer_box.add(drawer_box_front);
    }
    drawer_box.add(drawer_box_back);

    drawer_box.add(drawer_box_base_panel);

    drawer_box.add(drawer_box_base_panel_Helper);
    drawer_box.add(drawer_left_slider);
    drawer_box.add(drawer_right_slider);

    return drawer_box;
  }

  double  correct_value(double v){
    double resault= double.parse(v.toStringAsFixed(2));
    return resault;
  }

}
