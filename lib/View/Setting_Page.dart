import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Door_Pattern_Painter.dart';
import 'package:auto_cam/Controller/Painters/Drawer_Pattern_Painter.dart';
import 'package:auto_cam/Controller/Painters/Flexible_Shelf_Pattern_Painter.dart';
import 'package:auto_cam/Controller/Painters/Pattern_Painter.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
 import 'package:auto_cam/View/Screens_parts/Box_Fitting_Setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Setting_Page extends StatefulWidget {
  const Setting_Page({Key? key}) : super(key: key);

  @override
  State<Setting_Page> createState() => _Setting_PageState();
}

class _Setting_PageState extends State<Setting_Page> {
  Draw_Controller draw_controller = Get.find();

  String corrent_setting =
      " SETTING (KD patterns  -  cnc tools - nesting - ........)";
  bool kd_patterns_setting = true;
  bool cnc_tool_setting = false;

  String corrent_category = "Box_Fitting_DRILL";
  String correct_join_type = "Box fitting";
  bool boxes_fitting = true;
  bool Flexible_Shelves = false;
  bool Drawer_face = false;
  bool Drawer_slide = false;
  bool Doors = false;

  JoinHolePattern corrent_join_pattern =
  JoinHolePattern('name', 150, 300,0,0, [], true);

  int corrent_join_pattern_id = 0;

  List<JoinHolePattern> corrent_paterns_list = [];

  List<JoinHolePattern> list_boxes_fitting = [];
  List<JoinHolePattern> list_Flexible_Shelves = [];
  List<JoinHolePattern> list_Drawer_face = [];
  List<JoinHolePattern> list_Door_Hinges = [];
  List<JoinHolePattern> list_side_Hinges = [];

  List<JoinHolePattern> list_drawr_slide = [];
  List<JoinHolePattern> list_box_slide = [];

  List<JoinHolePattern> list_Groove = [];

  // List<CNC_Tool> cnc_tools = [];

  TextEditingController category_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController mini_distence_controller = TextEditingController();
  TextEditingController max_distence_controller = TextEditingController();

  TextEditingController pre_distence_controller = TextEditingController();
  TextEditingController diameter_controller = TextEditingController();
  TextEditingController face_diameter_controller = TextEditingController();
  TextEditingController depth_controller = TextEditingController();
  TextEditingController face_depth_controller = TextEditingController();
  TextEditingController nut_distence_controller = TextEditingController();
  TextEditingController nut_diameter_controller = TextEditingController();
  TextEditingController nut_depth_controller = TextEditingController();

  /// drawer setting
  TextEditingController drawer_pre_distance = TextEditingController();
  TextEditingController drawer_diameter = TextEditingController();
  TextEditingController drawer_depth = TextEditingController();
  TextEditingController box_pre_distance = TextEditingController();
  TextEditingController box_diameter = TextEditingController();
  TextEditingController box_depth = TextEditingController();

  TextEditingController A_controller = TextEditingController();
  TextEditingController A_depth_controller = TextEditingController();
  TextEditingController B_controller = TextEditingController();
  TextEditingController C_controller = TextEditingController();
  TextEditingController D_controller = TextEditingController();
  TextEditingController E_controller = TextEditingController();
  TextEditingController F_controller = TextEditingController();
  TextEditingController H_depth_controller = TextEditingController();
  TextEditingController H_controller = TextEditingController();
  TextEditingController J_depth_controller = TextEditingController();
  TextEditingController J_controller = TextEditingController();

  TextEditingController door_quantity_controller = TextEditingController();

  bool have_nut = false;
  bool have_mirror = true;
  bool center = false;

  double min_length = 0;
  double max_length = 0;

  List<Bore_unit> bore_units = [];
  List<Bore_unit> Paint_bore_units_min = [];
  List<Bore_unit> Paint_bore_units_max = [];

  List<Bore_unit> door_bore_units = [];
  List<Bore_unit> side_bore_units = [];

  List<Bore_unit> drawr_slide_units = [];
  List<Bore_unit> box_slide_units = [];

  TextEditingController Flexible_Shelf_A_controller = TextEditingController();
  TextEditingController Flexible_Shelf_B_controller = TextEditingController();
  TextEditingController Flexible_Shelf_C_controller = TextEditingController();
  TextEditingController Flexible_Shelf_Depth_controller =
  TextEditingController();
  TextEditingController Flexible_Shelf_Diameter_controller =
  TextEditingController();
  TextEditingController Flexible_Shelf_Quantity_controller =
  TextEditingController();

  List<Bore_unit> Flexible_Shelf_units = [];

  int selected_door_pattern = 0;

  int selected_pattern = 0;

  bool add_new_door = false;

  refresh() async {
    min_length = double.parse(mini_distence_controller.text.toString());
    max_length = double.parse(max_distence_controller.text.toString());

    bore_units = corrent_join_pattern.bores;

    Paint_bore_units_min = corrent_join_pattern.apply_pattern(min_length);
    Paint_bore_units_max = corrent_join_pattern.apply_pattern(max_length);

    category_controller.text = corrent_category;

    if (category_controller.text.toString() == "Doors") {


      if (!add_new_door) {
        door_bore_units=list_Door_Hinges[selected_pattern].bores;
        side_bore_units=list_side_Hinges[selected_pattern].bores;
      }

    }
    if (category_controller.text.toString() == "Flexible_Shelves") {
      Flexible_Shelf_units=list_Flexible_Shelves[selected_pattern].bores;

    }


    // if (!add_new_door) {
    //   door_bore_units = list_Door_Hinges[selected_door_pattern].bores;
    //   side_bore_units = list_side_Hinges[selected_door_pattern].bores;
    //
    //   /// hinges
    //   ///
    //   // if (corrent_category == "Doors") {
    //   //   A_controller.text = "${door_bore_units[0].face_bore.diameter}";
    //   //   A_depth_controller.text = "${door_bore_units[0].face_bore.depth}";
    //   //   B_controller.text =
    //   //       "${22.5 - door_bore_units[0].face_bore.origin.y_coordinate}";
    //   //   C_controller.text =
    //   //       "${door_bore_units[1].face_bore.origin.y_coordinate + (22.5 - door_bore_units[0].face_bore.origin.y_coordinate)}";
    //   //   D_controller.text = "${door_bore_units[1].correct_x * 2}";
    //   //   E_controller.text =
    //   //       "${side_bore_units[0].face_bore.origin.y_coordinate}";
    //   //   F_controller.text = "${side_bore_units[0].correct_x * 2}";
    //   //   H_depth_controller.text = "${door_bore_units[1].face_bore.diameter}";
    //   //   H_controller.text = "${door_bore_units[1].face_bore.depth}";
    //   //   J_depth_controller.text = "${side_bore_units[0].face_bore.depth}";
    //   //   J_controller.text = "${side_bore_units[0].face_bore.diameter}";
    //   // }
    // }

    // if (corrent_category == "Drawer_Slides") {
    //   drawr_slide_units = list_drawr_slide[selected_pattern].bores;
    //   box_slide_units = list_box_slide[selected_pattern].bores;
    // } else if (corrent_category == "Flexible_Shelves") {
    //   corrent_join_pattern = list_Flexible_Shelves[selected_pattern];
    //   Flexible_Shelf_units = corrent_join_pattern.bores;
    // }

    have_mirror = true;
    center = false;

    setState(() {});
  }

  add_to_pattern() {
    double pre_distance = double.parse(pre_distence_controller.text.toString());
    double diameter = double.parse(diameter_controller.text.toString());
    double face_diameter =
    double.parse(face_diameter_controller.text.toString());
    double depth = double.parse(depth_controller.text.toString());
    double face_depth = double.parse(face_depth_controller.text.toString());

    double nut_destance =
    have_nut ? double.parse(nut_distence_controller.text.toString()) : 0;
    double nut_diameter =
    have_nut ? double.parse(nut_diameter_controller.text.toString()) : 0;
    double nut_depth =
    have_nut ? double.parse(nut_depth_controller.text.toString()) : 0;

    // double min_length=double.parse(mini_distence_controller.text.toString());
    // double max_length=double.parse(max_distence_controller.text.toString());

    late Bore_model side_bore;
    late Bore_model face_bore;
    late Bore_model nut_bore;

    Point_model init_origin = Point_model(0, 0, 0);
    side_bore = Bore_model(init_origin, diameter, depth);
    face_bore = Bore_model(init_origin, face_diameter, face_depth);
    nut_bore = Bore_model(init_origin, nut_diameter, nut_depth);

    Bore_unit bore_unit = Bore_unit(pre_distance, 0, 0, side_bore, have_nut,
        nut_destance, nut_bore, face_bore, center, have_mirror);

    bore_units.add(bore_unit);
    refresh();
    setState(() {});
  }

  save_pattern() async {
    double mini_length = double.parse(mini_distence_controller.text.toString());
    double max_length = double.parse(max_distence_controller.text.toString());

    int    quantity        =double.parse(door_quantity_controller.text.toString()).toInt();
    double Pre_distance = double.parse(pre_distence_controller.text.toString());


    if (category_controller.text.toString() == "Doors") {
      JoinHolePattern door_joinHolePattern = JoinHolePattern(
          name_controller.text.toString(),
          mini_length,
          max_length,
          quantity,
          Pre_distance,
          door_bore_units,
          true);
      JoinHolePattern side_joinHolePattern = JoinHolePattern(
          name_controller.text.toString(),
          mini_length,
          max_length,
          quantity,
          Pre_distance,
          side_bore_units,
          true);


      // print("side_bore_units from settig = ${side_bore_units.length}");

      await draw_controller.save_joinHolePattern(
          door_joinHolePattern, "Door_Hinges");
      await draw_controller.save_joinHolePattern(
          side_joinHolePattern, "side_Hinges");

      await draw_controller.read_pattern_files();
      selected_door_pattern = await draw_controller
          .box_repository.join_patterns["side_Hinges"]!.length;
      add_new_door = false;
      setState(() {});
    }




    else if (category_controller.text.toString() == "Drawer_Slides") {
      JoinHolePattern drawer_joinHolePattern = JoinHolePattern(
          name_controller.text.toString(),
          mini_length,
          max_length,0,0,
          drawr_slide_units,
          true);
      JoinHolePattern box_joinHolePattern = JoinHolePattern(
          name_controller.text.toString(),
          mini_length,
          max_length,0,0,
          box_slide_units,
          true);

      await draw_controller.save_joinHolePattern(
          drawer_joinHolePattern, "Drawer_Rail_Box");
      await draw_controller.save_joinHolePattern(
          box_joinHolePattern, "Drawer_Rail_Side");

      await draw_controller.read_pattern_files();
      selected_door_pattern = await draw_controller
          .box_repository.join_patterns["Drawer_Rail_Box"]!.length;
      setState(() {});
    }
    else if (category_controller.text.toString() == "Flexible_Shelves") {
      JoinHolePattern drawer_joinHolePattern = JoinHolePattern(
          name_controller.text.toString(),
          mini_length,
          max_length,0,0,
          Flexible_Shelf_units,
          true);

      await draw_controller.save_joinHolePattern(
          drawer_joinHolePattern, "Flexible_Shelves");

      await draw_controller.read_pattern_files();

      setState(() {});
    }
    else {
      JoinHolePattern joinHolePattern = JoinHolePattern(
          name_controller.text.toString(),
          mini_length,
          max_length,0,0,
          bore_units,
          true);

      await draw_controller.save_joinHolePattern(
          joinHolePattern, category_controller.text.toString());
    }

    read_patterns();
  }

  delete_pattern() async {

    if (corrent_category == "Doors") {

      await   draw_controller.delete_joinHolePattern(list_Door_Hinges[selected_door_pattern],'Door_Hinges');
      await  draw_controller.delete_joinHolePattern(list_side_Hinges[selected_door_pattern], 'side_Hinges');


      list_Door_Hinges.removeAt((selected_pattern==0)?selected_pattern:selected_pattern-1);
      list_side_Hinges.removeAt((selected_pattern==0)?selected_pattern:selected_pattern-1);

      // list_Door_Hinges[selected_pattern].category=corrent_category;deleted_patterns.add(list_Door_Hinges[selected_pattern]);
      // list_side_Hinges[selected_pattern].category=corrent_category;deleted_patterns.add(list_side_Hinges[selected_pattern]);

      selected_door_pattern=0;
      setState(() {});


    }
    else if (corrent_category == "Drawer_Slides") {


      // list_drawr_slide[selected_pattern].category=corrent_category;deleted_patterns.add(list_drawr_slide[selected_pattern]);
      // list_box_slide  [selected_pattern].category=corrent_category;deleted_patterns.add(list_box_slide  [selected_pattern]);

      await  draw_controller.delete_joinHolePattern(list_drawr_slide[selected_pattern], "Drawer_Rail_Side");
      await  draw_controller.delete_joinHolePattern(list_box_slide[selected_pattern], "Drawer_Rail_Box" );

      list_drawr_slide.removeAt((selected_pattern==0)?selected_pattern:selected_pattern-1);
      list_box_slide.removeAt((selected_pattern==0)?selected_pattern:selected_pattern-1);

      setState(() {});


    }
    else if (corrent_category == "Box_Fitting_DRILL") {
      // list_boxes_fitting   [selected_pattern].category=corrent_category;deleted_patterns.add(list_boxes_fitting   [selected_pattern]);

      await  draw_controller.delete_joinHolePattern(
          list_boxes_fitting[selected_pattern],"Box_Fitting_DRILL");

      list_boxes_fitting.removeAt((selected_pattern==0)?selected_pattern:selected_pattern-1);


    }
    else if (corrent_category == "Flexible_Shelves") {

      // list_Flexible_Shelves[selected_pattern].category = corrent_category;
      // deleted_patterns.add(list_Flexible_Shelves[selected_pattern]);

      await  draw_controller.delete_joinHolePattern(
          list_Flexible_Shelves[selected_pattern],"Flexible_Shelves");
      list_Flexible_Shelves.removeAt((selected_pattern==0)?selected_pattern:selected_pattern-1);


    } else if (corrent_category == "Drawer_Face") {
      // list_Drawer_face[selected_pattern].category = corrent_category;
      // deleted_patterns.add(list_Drawer_face[selected_pattern]);

      await draw_controller.delete_joinHolePattern(
          list_Drawer_face[selected_pattern],"Drawer_Face");
      list_Drawer_face.removeAt((selected_pattern==0)?selected_pattern:selected_pattern-1);



    }
    //
    // selected_pattern = 0;
    // corrent_join_pattern = corrent_paterns_list[0];
    // corrent_join_pattern_id = 0;
    selected_pattern=0;

    read_patterns();
  }

  Widget painters() {
    late Widget widget;
    if (corrent_category == "Box_Fitting_DRILL") {
      widget = Column(
        children: [
          Container(
            height: 300, width: 400,
            // color: Colors.grey[200],
            child: CustomPaint(
              painter: Pattern_Painter(
                  Paint_bore_units_min,
                  [],
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  min_length,
                  400,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 300, width: 400,
            // color: Colors.grey[200],
            child: CustomPaint(
              painter: Pattern_Painter(
                  Paint_bore_units_max,
                  [],
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  max_length,
                  400,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
        ],
      );
    }
    else if (corrent_category == "Flexible_Shelves") {
      widget = Column(
        children: [
          ///photo
          Container(
            height: 270,
            child: Image.asset("lib/assets/images/flexible_shelf.png"),
          ),

          ///divider
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              height: 2,
              width: 300,
              color: Colors.grey,
            ),
          ),

          Container(
            height: 400,
            width: 500,
            color: Colors.grey[100],
            child: CustomPaint(
              painter: Flexible_Shelf_Pattern_Painter(
                  Flexible_Shelf_units,
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  max_length,
                  400,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
        ],
      );
    }
    else if (corrent_category == "Drawer_Face") {
      // List<Bore_unit> secondary_min_bore_units =detect_drawer_secondary_bore(corrent_join_pattern.min_length);
      // List<Bore_unit> secondary_max_bore_units =detect_drawer_secondary_bore(corrent_join_pattern.max_length);

      widget = Column(
        children: [
          Container(
            height: 300, width: 350,
            // color: Colors.grey[200],
            child: CustomPaint(
              painter: Pattern_Painter(
                  Paint_bore_units_min,
                  [],
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  min_length,
                  400,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 300, width: 350,
            // color: Colors.grey[200],
            child: CustomPaint(
              painter: Pattern_Painter(
                  Paint_bore_units_max,
                  [],
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  max_length,
                  400,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
        ],
      );
    }
    else if (corrent_category == "Drawer_Slides") {
      widget = Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey[200],
            child: CustomPaint(
              painter: Drawer_Pattern_Painter(
                  drawr_slide_units,
                  box_slide_units,
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  max_length,
                  400,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
          SizedBox(
            height: 32,
          ),
        ],
      );
    }
    else if (corrent_category == "Doors") {
      widget = Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey[200],
            child: CustomPaint(
              painter: Door_Pattern_Painter(
                  door_bore_units,
                  side_bore_units,
                  draw_controller.box_repository.box_model.value.init_material_thickness,
                  max_length,
                  400,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          // Container(
          //   height: 300,
          //   color: Colors.grey[200],
          //   child: CustomPaint(
          //     painter: Door_Pattern_Painter(
          //         Paint_bore_units_max,
          //         [],
          //         draw_controller
          //             .box_repository.box_model.value.init_material_thickness,
          //         max_length,
          //         500,
          //         max_length,
          //         corrent_category),
          //     child: Container(),
          //   ),
          // ),
        ],
      );
    }
    else {
      widget = Container();
    }

    return widget;
  }

  add_door_unit() async {
    double Pre_distance = double.parse(pre_distence_controller.text.toString());
    double A_value = double.parse(A_controller.text.toString());
    double A_depth_value = double.parse(A_depth_controller.text.toString());
    double B_value = double.parse(B_controller.text.toString());
    double C_value = double.parse(C_controller.text.toString());
    double D_value = double.parse(D_controller.text.toString());
    double E_value = double.parse(E_controller.text.toString());
    double F_value = double.parse(F_controller.text.toString());

    double H_depth_value = double.parse(H_depth_controller.text.toString());
    double H_value = double.parse(H_controller.text.toString());
    double J_depth_value = double.parse(J_depth_controller.text.toString());
    double J_value = double.parse(J_controller.text.toString());

    Bore_model main_hole =
    Bore_model(Point_model(0, 22.5 - B_value, 0), A_value, A_depth_value);
    Bore_model main_hole_support_1 = Bore_model(
        Point_model(0, C_value - B_value, 0), H_value, H_depth_value);
    Bore_model main_hole_support_2 = Bore_model(
        Point_model(0, C_value - B_value, 0), H_value, H_depth_value);

    Bore_model side_hole_1 =
    Bore_model(Point_model(0, E_value, 0), J_value, J_depth_value);
    Bore_model side_hole_2 =
    Bore_model(Point_model(0, E_value, 0), J_value, J_depth_value);

    Bore_model emety_bore = Bore_model(Point_model(0, 22, 0), 0, 0);

    Bore_unit Door_unit_1 = Bore_unit(Pre_distance, 0, 0, emety_bore, false, 0,
        emety_bore, main_hole, center, false);

    Bore_unit Door_unit_2 = Bore_unit(
        Pre_distance,C_value - B_value,
        D_value / 2,

        emety_bore,
        false,
        0,
        emety_bore,
        main_hole_support_1,
        center,
        false);

    Bore_unit Door_unit_3 = Bore_unit(
        Pre_distance,(C_value - B_value),
        D_value / 2,

        emety_bore,
        false,
        0,
        emety_bore,
        main_hole_support_2,
        center,
        false);

    Bore_unit side_unit_1 = Bore_unit(Pre_distance,37 - E_value, F_value / 2,
        emety_bore, false, 0, emety_bore, side_hole_1, center, false);

    Bore_unit side_unit_2 = Bore_unit(Pre_distance, 37 - E_value, F_value / 2,
        emety_bore, false, 0, emety_bore, side_hole_2, center, false);

    door_bore_units.add(Door_unit_1);
    door_bore_units.add(Door_unit_2);
    door_bore_units.add(Door_unit_3);

    side_bore_units.add(side_unit_1);
    side_bore_units.add(side_unit_2);


    ///
    if (add_new_door) {
      int    quantity        =double.parse(door_quantity_controller.text.toString()).toInt();
      double Pre_distance = double.parse(pre_distence_controller.text.toString());



      JoinHolePattern doorJoinHolePattern=JoinHolePattern(
            name_controller.text.toString(),
            min_length,
            max_length,
             quantity,Pre_distance,
            [
              Door_unit_1,
              Door_unit_2,
              Door_unit_3
            ],
            true);

      JoinHolePattern sideJoinHolePattern=JoinHolePattern(
            name_controller.text.toString(),
            min_length,
            max_length,
          quantity,Pre_distance,

            [
              side_unit_1,
              side_unit_2
            ],
            true);


      door_bore_units=doorJoinHolePattern.apply_pattern_on_door(max_length);
        side_bore_units=sideJoinHolePattern.apply_pattern_on_side(max_length);


    }

setState(() {

});

    ///



    // selected_door_pattern=draw_controller.box_repository.join_patterns["Door_Hinges"]!.length+1;

    // save_pattern();
    refresh();
  }

  add_slide_unit() {
    double value_drawer_pre_distance =
    double.parse(drawer_pre_distance.text.toString());
    double value_drawer_diameter =
    double.parse(drawer_diameter.text.toString());
    double value_drawer_depth = double.parse(drawer_depth.text.toString());
    double value_box_pre_distance =
    double.parse(box_pre_distance.text.toString());
    double value_box_diameter = double.parse(box_diameter.text.toString());
    double value_box_depth = double.parse(box_depth.text.toString());

    Bore_model emety_bore = Bore_model(Point_model(0, 22, 0), 0, 0);

    Bore_model drawer_bore = Bore_model(
        Point_model(0, 0, 0), value_drawer_diameter, value_drawer_depth);
    Bore_model box_bore =
    Bore_model(Point_model(0, 0, 0), value_box_diameter, value_box_depth);

    Bore_unit drawer_unit = Bore_unit(value_drawer_pre_distance, 0, 0,
        emety_bore, false, 0, emety_bore, drawer_bore, false, false);
    Bore_unit box_unit = Bore_unit(value_box_pre_distance, 0, 0, emety_bore,
        false, 0, emety_bore, box_bore, false, false);

    drawr_slide_units.add(drawer_unit);
    box_slide_units.add(box_unit);

    setState(() {});
    // print("drawr_slide_units.length = ${drawr_slide_units.length}");
    // print("box_slide_units.length = ${box_slide_units.length}");

    refresh();
  }

  add_to_Flexible_shelf_pattern() {
    double Shelf_A = double.parse(Flexible_Shelf_A_controller.text.toString());
    double Shelf_B = double.parse(Flexible_Shelf_B_controller.text.toString()) +
        draw_controller.box_repository.box_model.value.init_material_thickness /
            2;
    double Shelf_C = double.parse(Flexible_Shelf_C_controller.text.toString());
    double Depth =
    double.parse(Flexible_Shelf_Depth_controller.text.toString());
    double Diameter =
    double.parse(Flexible_Shelf_Diameter_controller.text.toString());
    double Quantity =
    double.parse(Flexible_Shelf_Quantity_controller.text.toString());

    Bore_model bore_model = Bore_model(Point_model(0, 0, 0), Diameter, Depth);
    Bore_model emety_bore = Bore_model(Point_model(0, 0, 0), 0, 0);

    if (Quantity == 1) {
      Bore_unit bore_unit = Bore_unit(Shelf_A, 0, Shelf_B, emety_bore, false, 0,
          emety_bore, bore_model, center, true);
      Flexible_Shelf_units.add(bore_unit);
    } else if (Quantity % 2 == 0) {
      for (int i = 0; i < Quantity; i++) {
        Bore_unit bore_unit_1 = Bore_unit(
            Shelf_A,
            0,
            Shelf_B + ((Quantity / 2 - 1) * Shelf_C) - i * Shelf_C,
            emety_bore,
            false,
            0,
            emety_bore,
            bore_model,
            center,
            true);
        Flexible_Shelf_units.add(bore_unit_1);
      }
    } else if (Quantity % 2 != 0) {
      Bore_unit bore_unit_0 = Bore_unit(Shelf_A, 0, Shelf_B, emety_bore, false,
          0, emety_bore, bore_model, center, true);
      Flexible_Shelf_units.add(bore_unit_0);

      for (int i = 1; i < (Quantity) / 2; i++) {
        Bore_unit bore_unit_1 = Bore_unit(Shelf_A, 0, Shelf_B + -i * Shelf_C,
            emety_bore, false, 0, emety_bore, bore_model, center, true);
        Bore_unit bore_unit_2 = Bore_unit(Shelf_A, 0, Shelf_B + i * Shelf_C,
            emety_bore, false, 0, emety_bore, bore_model, center, true);
        Flexible_Shelf_units.add(bore_unit_1);
        Flexible_Shelf_units.add(bore_unit_2);
      }
    }
  }

  Widget parameter_editor() {
    late Widget widget;
    if (corrent_category == "Box_Fitting_DRILL") {
      widget = Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
            width: 300,
            child: ListView(
              children: [
                SizedBox(
                  height: 70,
                ),

                /// pattern category
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern category',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: category_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        enabled: false,
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// pattern name
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern name',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: name_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// minimum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Minimum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: mini_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// maximum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Maximum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: max_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),

                /// Pre Distance
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'Pre Distance',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: pre_distence_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Diameter
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: diameter_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Face Diameter
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Face Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: face_diameter_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Depth
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///face Depth
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Face Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: face_depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// have mirror
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'have mirror??',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Checkbox(
                        value: have_mirror,
                        onChanged: (v) {
                          have_mirror = !have_mirror;

                          setState(() {});
                        }),
                  ],
                ),

                /// center
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Center??',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Checkbox(
                        value: center,
                        onChanged: (v) {
                          if (!center) {
                            have_mirror = false;
                            pre_distence_controller.text =
                            "${double.parse(mini_distence_controller.text.toString()) / 2}";
                          }
                          center = !center;

                          setState(() {});
                        }),
                  ],
                ),

                /// have face hole
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'have nut??',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Checkbox(
                        value: have_nut,
                        onChanged: (v) {
                          have_nut = !have_nut;
                          setState(() {});
                        }),
                  ],
                ),

                /// nut Distance
                have_nut
                    ? Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'nut Distance',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: nut_distence_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : SizedBox(
                  height: 35,
                ),

                ///
                /// nut Diameter
                have_nut
                    ? Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'nut Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: nut_diameter_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : SizedBox(
                  height: 35,
                ),

                /// nut Depth
                have_nut
                    ? Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'nut Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: nut_depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : SizedBox(
                  height: 35,
                ),

                SizedBox(
                  height: 12,
                ),

                /// add to pattern button
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          add_to_pattern();
                          setState(() {});
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'ADD TO PATTERN',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          if (corrent_join_pattern.bores.length != 0) {
                            corrent_join_pattern.bores.removeAt(
                                corrent_join_pattern.bores.length - 1);
                          }
                          refresh();
                        },
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Icon(
                                Icons.undo,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 12,
                ),

                /// save pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      save_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'save pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),

                /// delete pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      delete_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.redAccent[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'delete pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 32,
                ),
              ],
            )),
      );
    }
    else if (corrent_category == "Flexible_Shelves") {
      widget = Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
            width: 300,
            child: ListView(
              children: [
                SizedBox(
                  height: 32,
                ),

                /// pattern category
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern category',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: category_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        enabled: false,
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// pattern name
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern name',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: name_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// minimum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Minimum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: mini_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// maximum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Maximum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: max_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// DIVIDER
                /// DIVIDER
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),

                /// Pre Distance
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'Pre Distance (A)',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: Flexible_Shelf_A_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// hole distance : B
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'B',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: Flexible_Shelf_B_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///C
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'C',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: Flexible_Shelf_C_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ///D
                // Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       height: 35,
                //       child: Center(
                //         child: Text(
                //           'Quantity',
                //           style: TextStyle(fontSize: 12),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 12,
                //     ),
                //     Container(
                //       width: 75,
                //       height: 25,
                //       child: TextFormField(
                //         keyboardType: TextInputType.number,
                //         inputFormatters: [DecimalTextInputFormatter(2)],
                //         controller: face_depth_controller,
                //         onChanged: (_) {},
                //         validator: (d) {
                //           if (d!.isEmpty) {
                //             return 'add value please';
                //           }
                //         },
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(4),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                ///Quantity
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Quantity',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: Flexible_Shelf_Quantity_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///  Diameter
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: Flexible_Shelf_Diameter_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Depth
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: Flexible_Shelf_Depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // /// have mirror
                // Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       height: 35,
                //       child: Center(
                //         child: Text(
                //           'have mirror??',
                //           style: TextStyle(fontSize: 12),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 12,
                //     ),
                //     Checkbox(
                //         value: have_mirror,
                //         onChanged: (v) {
                //           have_mirror = !have_mirror;
                //
                //           setState(() {});
                //         }),
                //   ],
                // ),

                /// center
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Center??',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Checkbox(
                        value: center,
                        onChanged: (v) {
                          if (!center) {
                            have_mirror = false;
                            pre_distence_controller.text =
                            "${double.parse(mini_distence_controller.text.toString()) / 2}";
                          }
                          center = !center;

                          setState(() {});
                        }),
                  ],
                ),

                SizedBox(
                  height: 12,
                ),

                /// add to pattern button
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          add_to_Flexible_shelf_pattern();
                          setState(() {});
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'ADD TO PATTERN',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          if (Flexible_Shelf_units.length != 0) {
                            Flexible_Shelf_units.removeAt(
                                Flexible_Shelf_units.length - 1);
                          }
                          refresh();
                        },
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Icon(
                                Icons.undo,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 12,
                ),

                /// save pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      save_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'save pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),

                /// delete pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      delete_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.redAccent[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'delete pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 32,
                ),
              ],
            )),
      );
    }
    else if (corrent_category == "Drawer_Face") {
      widget = Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
            width: 300,
            child: ListView(
              children: [
                SizedBox(
                  height: 70,
                ),

                /// pattern category
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern category',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: category_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        enabled: false,
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// pattern name
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern name',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: name_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// minimum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Minimum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: mini_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// maximum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Maximum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: max_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),

                /// Pre Distance
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'Pre Distance',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: pre_distence_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Diameter
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: diameter_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Face Diameter
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Face Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: face_diameter_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Depth
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///face Depth
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Face Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: face_depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// have mirror
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'have mirror??',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Checkbox(
                        value: have_mirror,
                        onChanged: (v) {
                          have_mirror = !have_mirror;

                          setState(() {});
                        }),
                  ],
                ),

                /// center
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Center??',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Checkbox(
                        value: center,
                        onChanged: (v) {
                          if (!center) {
                            have_mirror = false;
                            pre_distence_controller.text =
                            "${double.parse(mini_distence_controller.text.toString()) / 2}";
                          }
                          center = !center;

                          setState(() {});
                        }),
                  ],
                ),

                /// have face hole
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'have nut??',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Checkbox(
                        value: have_nut,
                        onChanged: (v) {
                          have_nut = !have_nut;
                          setState(() {});
                        }),
                  ],
                ),

                /// nut Distance
                have_nut
                    ? Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'nut Distance',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: nut_distence_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : SizedBox(
                  height: 35,
                ),

                ///
                /// nut Diameter
                have_nut
                    ? Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'nut Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: nut_diameter_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : SizedBox(
                  height: 35,
                ),

                /// nut Depth
                have_nut
                    ? Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'nut Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: nut_depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : SizedBox(
                  height: 35,
                ),

                SizedBox(
                  height: 12,
                ),

                /// add to pattern button
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          add_to_pattern();
                          setState(() {});
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'ADD TO PATTERN',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          if (corrent_join_pattern.bores.length != 0) {
                            corrent_join_pattern.bores.removeAt(
                                corrent_join_pattern.bores.length - 1);
                          }
                          refresh();
                        },
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Icon(
                                Icons.undo,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 12,
                ),

                /// save pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      save_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'save pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),

                /// delete pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      delete_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.redAccent[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'delete pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 32,
                ),
              ],
            )),
      );
    }
    else if (corrent_category == "Drawer_Slides") {
      widget = Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
            width: 300,
            child: ListView(
              children: [
                SizedBox(
                  height: 70,
                ),

                /// pattern category
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern category',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: category_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        enabled: false,
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// pattern name
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern name',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: name_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// minimum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Minimum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: mini_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// maximum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Maximum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: max_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),

                ///Box side setting
                Text("Box side setting"),
                SizedBox(
                  height: 12,
                ),

                Container(width: 300,height: 100,child: Image.asset("lib/assets/images/box_slide.png"),),
                /// Pre Distance
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'Pre Distance',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: drawer_pre_distance,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Diameter
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: drawer_diameter,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Depth
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: drawer_depth,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),

                ///Box side setting
                Text("Drawer side setting"),
                SizedBox(
                  height: 12,
                ),

                /// Pre Distance
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'Pre Distance',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: box_pre_distance,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Diameter
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Diameter',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: box_diameter,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Depth
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Depth',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: box_depth,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),

                /// add to pattern button
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          add_slide_unit();
                          setState(() {});
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'ADD TO PATTERN',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          if (drawr_slide_units.length != 0) {
                            drawr_slide_units
                                .removeAt(drawr_slide_units.length - 1);
                            box_slide_units
                                .removeAt(box_slide_units.length - 1);
                          }
                          refresh();
                        },
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Icon(
                                Icons.undo,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 12,
                ),

                /// save pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      save_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'save pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),

                /// delete pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      delete_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.redAccent[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'delete pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 32,
                ),
              ],
            )),
      );
    }
    else if (corrent_category == "Doors") {
      widget = Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
            width: 300,
            child: ListView(
              children: [
                ///photo
                Container(
                  width: 300,
                  child: Image.asset("lib/assets/images/hinges.png"),
                ),

                ///divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),

                /// pattern category
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern category',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: category_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        enabled: false,
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// pattern name
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'pattern name',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        controller: name_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// minimum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Minimum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: mini_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                /// maximum length
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Text(
                          'Maximum length',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: max_distence_controller,
                        style: TextStyle(fontSize: 12),
                        onChanged: (_) {
                          refresh();
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),

                /// title
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            ' ',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'distance',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'deoth',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///A
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'A',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: A_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: A_depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                ///B
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'B',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: B_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(width: 100, height: 35, child: Container()),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                ///C
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'C',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: C_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(width: 100, height: 35, child: Container()),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                ///H
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'H',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: H_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: H_depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                ///D
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'D',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: D_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                ///E
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'E',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: E_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(width: 100, height: 35, child: Container()),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                ///J
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'J',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: J_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: J_depth_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                ///F
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'F',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: F_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ///divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 300,
                    color: Colors.grey,
                  ),
                ),

                ///pre distance
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'quantity',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: door_quantity_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),

                ///pre distance
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 35,
                      child: Center(
                        child: Center(
                          child: Text(
                            'pre distance',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: pre_distence_controller,
                        onChanged: (_) {},
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              

                ///correction
                // center?  Row(
                //     children: [
                //       Container(
                //         width: 50,
                //         height: 35,
                //         child: Center(
                //           child: Center(
                //             child: Text(
                //               'v 1',
                //               style: TextStyle(fontSize: 16),
                //             ),
                //           ),
                //         ),
                //       ),
                //
                //       Container(
                //         width: 75,
                //         height: 35,
                //         child: TextFormField(
                //           keyboardType: TextInputType.number,
                //           inputFormatters: [DecimalTextInputFormatter(2)],
                //           controller: correct_1_controller,
                //           onChanged: (_) {
                //             correct_1=double.parse(correct_1_controller.text.toString());
                //
                //           },
                //           validator: (d) {
                //             if (d!.isEmpty) {
                //               return 'add value please';
                //             }
                //           },
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(4),
                //             ),
                //           ),
                //         ),
                //       ),   Container(
                //         width: 50,
                //         height: 35,
                //         child: Center(
                //           child: Center(
                //             child: Text(
                //               'v 2',
                //               style: TextStyle(fontSize: 16),
                //             ),
                //           ),
                //         ),
                //       ),
                //
                //       Container(
                //         width: 100,
                //         height: 35,
                //         child: TextFormField(
                //           keyboardType: TextInputType.number,
                //           inputFormatters: [DecimalTextInputFormatter(2)],
                //           controller: correct_2_controller,
                //           onChanged: (_) {
                //             correct_2=double.parse(correct_2_controller.text.toString());
                //           },
                //           validator: (d) {
                //             if (d!.isEmpty) {
                //               return 'add value please';
                //             }
                //           },
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(4),
                //             ),
                //           ),
                //         ),
                //       ),
                //
                //     ],
                //   ):SizedBox(),

                SizedBox(
                  height: 12,
                ),

                /// add to pattern button
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          add_door_unit();
                          setState(() {});
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'ADD TO PATTERN',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          if (door_bore_units.length > 0) {
                            door_bore_units
                                .removeAt(door_bore_units.length - 1);
                            side_bore_units
                                .removeAt(side_bore_units.length - 1);
                          }

                          refresh();
                        },
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Icon(
                                Icons.undo,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 12,
                ),

                /// save pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      save_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'save pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),

                /// delete pattern
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      delete_pattern();
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.redAccent[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                            'delete pattern',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 32,
                ),
              ],
            )),
      );
    }
    else {
      widget = Container();
    }

    return widget;
  }

  List<Bore_unit> detect_drawer_secondary_bore(double d) {
    List<Bore_unit> secondary_bore_units = [];

    List<JoinHolePattern>? my_patterns =
    draw_controller.box_repository.join_patterns[corrent_category];

    for (JoinHolePattern pattern in my_patterns!) {
      if (d > pattern.min_length && d <= pattern.max_length) {
        secondary_bore_units = pattern.apply_pattern(d);

        print(" d = $d");
        print(" secondary_bore_units = ${secondary_bore_units.length}");
      }
    }

    return secondary_bore_units;
  }

  add_new_pattern() {
    name_controller.text = '0';
    category_controller.text = corrent_category;
    mini_distence_controller.text = '0';
    max_distence_controller.text = '0';
    pre_distence_controller.text = '0';
    diameter_controller.text = '0';
    face_diameter_controller.text = '0';
    depth_controller.text = '0';
    face_depth_controller.text = '0';
    nut_distence_controller.text = '0';
    nut_diameter_controller.text = '0';
    nut_depth_controller.text = '0';

    /// hinges
    A_controller.text = "35";
    A_depth_controller.text = "13";
    B_controller.text = "22.5";
    C_controller.text = "32";
    D_controller.text = "45";
    E_controller.text = "37";
    F_controller.text = "32";

    H_depth_controller.text = "3";
    H_controller.text = "3";
    J_depth_controller.text = "3";
    J_controller.text = "3";

    bore_units = [];
    Paint_bore_units_min = [];
    Paint_bore_units_max = [];
    door_bore_units = [];
    side_bore_units = [];

    Flexible_Shelf_units = [];

    selected_door_pattern = 1000;

    corrent_join_pattern = JoinHolePattern('name', 150, 300,0,0, [], true);
    add_new_door = true;
    // initState();
    // refresh();
    setState(() {});
  }

  read_patterns() async {
    list_boxes_fitting = [];
    list_Flexible_Shelves = [];
    list_Drawer_face = [];
    list_box_slide = [];
    list_drawr_slide = [];
    list_Door_Hinges = [];
    list_side_Hinges = [];
    list_Groove = [];

    await draw_controller.read_pattern_files();

    Map<String, List<JoinHolePattern>> join_patterns =
        draw_controller.box_repository.join_patterns;

    list_boxes_fitting = join_patterns["Box_Fitting_DRILL"]!;
    list_Flexible_Shelves = join_patterns["Flexible_Shelves"]!;
    list_Drawer_face = join_patterns["Drawer_Face"]!;
    list_box_slide = join_patterns[  "Drawer_Rail_Box"  ]!;
    list_drawr_slide = join_patterns["Drawer_Rail_Side"]!;
    list_Door_Hinges = join_patterns["Door_Hinges"]!;
    list_side_Hinges = join_patterns["side_Hinges"]!;
    list_Groove = join_patterns["Groove"]!;

    setState(() {});
  }

  enable_or_diable_pattern() {
    if (corrent_category == "Doors") {
      list_Door_Hinges[selected_pattern].pattern_enable =
      !list_Door_Hinges[selected_pattern].pattern_enable;
      list_side_Hinges[selected_pattern].pattern_enable =
      !list_side_Hinges[selected_pattern].pattern_enable;

      setState(() {});
    } else if (corrent_category == "Drawer_Slides") {
      list_drawr_slide[selected_pattern].pattern_enable =
      !list_drawr_slide[selected_pattern].pattern_enable;
      list_box_slide[selected_pattern].pattern_enable =
      !list_box_slide[selected_pattern].pattern_enable;

      setState(() {});
    } else if (corrent_category == "Box_Fitting_DRILL") {
      list_boxes_fitting[selected_pattern].pattern_enable =
      !list_boxes_fitting[selected_pattern].pattern_enable;
    } else if (corrent_category == "Flexible_Shelves") {
      list_Flexible_Shelves[selected_pattern].pattern_enable =
      !list_Flexible_Shelves[selected_pattern].pattern_enable;
    } else if (corrent_category == "Drawer_Face") {
      list_Drawer_face[selected_pattern].pattern_enable =
      !list_Drawer_face[selected_pattern].pattern_enable;
    }

    refresh();
  }

  /// save change dialog and method
  // Widget save_dialog() {
  //   Widget widget = Container(
  //     width: 400,
  //     height: 200,
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 32,
  //         ),
  //         Text(
  //           "do you want to save the chang",
  //           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 24,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             InkWell(
  //               onTap: () {
  //                 save_patterns_changes();
  //                 Navigator.of(Get.overlayContext!).pop();
  //                 Get.to(Main_Screen());
  //               },
  //               child: Container(
  //                 width: 80,
  //                 height: 52,
  //                 color: Colors.red[300],
  //                 child: Center(
  //                     child: Text(
  //                   "SAVE",
  //                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //                 )),
  //               ),
  //             ),
  //             SizedBox(
  //               width: 24,
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 Navigator.of(Get.overlayContext!).pop();
  //                 Get.to(Main_Screen());
  //               },
  //               child: Container(
  //                 width: 80,
  //                 height: 52,
  //                 color: Colors.teal[200],
  //                 child: Center(
  //                     child: Text(
  //                   "CANCEL",
  //                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //                 )),
  //               ),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  //
  //   return widget;
  // }

  // save_patterns_changes() async {
  //   await draw_controller.save_joinHolePattern_list(
  //       list_boxes_fitting, "Box_Fitting_DRILL");
  //   await draw_controller.save_joinHolePattern_list(
  //       list_Flexible_Shelves, "Flexible_Shelves");
  //   await draw_controller.save_joinHolePattern_list(
  //       list_Drawer_face, "Drawer_Face");
  //   await draw_controller.save_joinHolePattern_list(
  //       list_box_slide, "Drawer_Rail_Box");
  //   await draw_controller.save_joinHolePattern_list(
  //       list_drawr_slide, "Drawer_Rail_Side");
  //   await draw_controller.save_joinHolePattern_list(
  //       list_Door_Hinges, "Door_Hinges");
  //   await draw_controller.save_joinHolePattern_list(
  //       list_side_Hinges, "side_Hinges");
  //   await draw_controller.save_joinHolePattern_list(list_Groove, "Groove");
  //
  //   // for (JoinHolePattern joinHolePattern in deleted_patterns) {
  //   //   await draw_controller.delete_joinHolePattern(
  //   //       joinHolePattern, joinHolePattern.category);
  //   // }
  // }

  List<JoinHolePattern> deleted_patterns = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_patterns();

    name_controller.text = '0';
    category_controller.text = 'Box_Fitting_DRILL';
    mini_distence_controller.text = '0';
    max_distence_controller.text = '0';
    pre_distence_controller.text = '0';
    diameter_controller.text = '0';
    face_diameter_controller.text = '0';
    depth_controller.text = '0';
    face_depth_controller.text = '0';
    nut_distence_controller.text = '0';
    nut_diameter_controller.text = '0';
    nut_depth_controller.text = '0';
    door_quantity_controller.text = '2';

    /// hinges
    A_controller.text = "35";
    A_depth_controller.text = "13";
    B_controller.text = "22.5";
    C_controller.text = "32";
    D_controller.text = "45";
    E_controller.text = "37";
    F_controller.text = "32";

    H_depth_controller.text = "3";
    H_controller.text = "3";
    J_depth_controller.text = "3";
    J_controller.text = "3";

    ///

    min_length = corrent_join_pattern.min_length;
    max_length = corrent_join_pattern.max_length;

  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: Text(corrent_setting),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Get.dialog(Dialog(child: save_dialog())),
        // ),
      ),
      body: Container(
        height: h - 50,
        width: w,
        child: Container(
          child: Row(children: [
            /// main chois : cnc tool setting \ kd fitting patterns
            // Container(
            //   width: w / 10,
            //   height: h - 50,
            //   color: Colors.grey[300],
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 70,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(16.0),
            //         child: InkWell(
            //           onTap: () {
            //             corrent_setting = "KD patters setting";
            //             kd_patterns_setting = true;
            //             cnc_tool_setting = false;
            //             setState(() {});
            //           },
            //           child: Container(
            //             width: kd_patterns_setting ? 150 : 100,
            //             height: kd_patterns_setting ? 65 : 45,
            //             color: kd_patterns_setting
            //                 ? Colors.teal[300]
            //                 : Colors.grey,
            //             child: Center(
            //               child: Text(
            //                 'KD patterns',
            //                 style: TextStyle(
            //                     fontSize: kd_patterns_setting ? 18 : 12),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(16.0),
            //         child: InkWell(
            //           onTap: () {
            //             // corrent_setting="cnc tool setting";
            //             // kd_patterns_setting=false;
            //             // cnc_tool_setting=true;
            //             // setState(() {
            //             //
            //             // });
            //           },
            //           child: Container(
            //             width: cnc_tool_setting ? 150 : 100,
            //             height: cnc_tool_setting ? 65 : 45,
            //             color: cnc_tool_setting
            //                 ? Colors.teal[300]
            //                 : Colors.grey[300],
            //             child: Center(
            //               child: Text(
            //                 'cnc tools',
            //                 style:
            //                     TextStyle(fontSize: cnc_tool_setting ? 22 : 12),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            /// second choices :  kd pattern to set
            Container(
              width: w / 10,
              height: h - 50,
              color: Colors.grey[200],
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),

                  ///Box fitting
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        // corrent_setting = "Box fitting";
                        //
                        // boxes_fitting = true;
                        // Flexible_Shelves = false;
                        // Drawer_face = false;
                        // Drawer_slide = false;
                        // Doors = false;
                        // corrent_paterns_list = list_boxes_fitting;
                        // corrent_join_pattern_id = 0;
                        //
                        // corrent_category = "Box_Fitting_DRILL";
                        // refresh();
                        // setState(() {});

Get.to(Box_Fitting_Setting());



                      },
                      child: Container(
                        width: boxes_fitting ? 150 : 100,
                        height: boxes_fitting ? 65 : 45,
                        color:
                        boxes_fitting ? Colors.teal[300] : Colors.grey[200],
                        child: Center(
                          child: Text(
                            'box fitting',
                            style: TextStyle(fontSize: boxes_fitting ? 18 : 14),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Flexible_Shelves
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        corrent_setting = " Flexible Shelves";

                        boxes_fitting = false;
                        Flexible_Shelves = true;
                        Drawer_face = false;
                        Drawer_slide = false;
                        Doors = false;
                        corrent_paterns_list = list_Flexible_Shelves;
                        corrent_join_pattern_id = 0;

                        corrent_category = "Flexible_Shelves";
                        refresh();
                        setState(() {});
                      },
                      child: Container(
                        width: Flexible_Shelves ? 150 : 100,
                        height: Flexible_Shelves ? 65 : 45,
                        color: Flexible_Shelves
                            ? Colors.teal[300]
                            : Colors.grey[200],
                        child: Center(
                          child: Text(
                            'Flexible Shelves',
                            style:
                            TextStyle(fontSize: Flexible_Shelves ? 18 : 14),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///Drawer face
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        corrent_setting = "Drawer face";
                        boxes_fitting = false;
                        Flexible_Shelves = false;
                        Drawer_face = true;
                        Drawer_slide = false;
                        Doors = false;
                        corrent_paterns_list = list_Drawer_face;
                        corrent_join_pattern_id = 0;
                        corrent_category = "Drawer_Face";
                        refresh();

                        setState(() {});
                      },
                      child: Container(
                        width: Drawer_face ? 150 : 100,
                        height: Drawer_face ? 65 : 45,
                        color:
                        Drawer_face ? Colors.teal[300] : Colors.grey[200],
                        child: Center(
                          child: Text(
                            'Drawer face',
                            style: TextStyle(fontSize: Drawer_face ? 18 : 14),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///Drawer slide
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        corrent_setting = "Drawer Slides";
                        boxes_fitting = false;
                        Flexible_Shelves = false;
                        Drawer_face = false;
                        Drawer_slide = true;
                        Doors = false;
                        corrent_paterns_list = list_drawr_slide;
                        corrent_join_pattern_id = 0;
                        corrent_category = "Drawer_Slides";
                        refresh();

                        setState(() {});
                      },
                      child: Container(
                        width: Drawer_slide ? 150 : 100,
                        height: Drawer_slide ? 65 : 45,
                        color:
                        Drawer_slide ? Colors.teal[300] : Colors.grey[200],
                        child: Center(
                          child: Text(
                            'Drawer Slides',
                            style: TextStyle(fontSize: Drawer_slide ? 18 : 14),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///Doors
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        corrent_setting = "Doors";
                        boxes_fitting = false;
                        Flexible_Shelves = false;
                        Drawer_face = false;
                        Drawer_slide = false;

                        Doors = true;
                        corrent_paterns_list = list_Door_Hinges;
                        corrent_join_pattern_id = 0;
                        corrent_category = "Doors";
                        door_bore_units = [];
                        side_bore_units = [];

                        refresh();

                        setState(() {});
                      },
                      child: Container(
                        width: Doors ? 150 : 100,
                        height: Doors ? 65 : 45,
                        color: Doors ? Colors.teal[300] : Colors.grey[200],
                        child: Center(
                          child: Text(
                            'Doors',
                            style: TextStyle(fontSize: Doors ? 22 : 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// join patterns list
            Column(
              children: [
                Container(
                    width: 300,
                    height: h - 350,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: ListView.builder(
                          itemCount: corrent_paterns_list.length,
                          itemBuilder: (context, i) {

                            bool corrent = (corrent_join_pattern_id == i);
                            bool enable_pattern =
                                corrent_paterns_list[i].pattern_enable;
                            String pattern_name = corrent_paterns_list[i].name;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 300,
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: enable_pattern,
                                        onChanged: (v) {
                                          corrent_join_pattern =
                                          corrent_paterns_list[i];
                                          corrent_join_pattern_id = i;
                                          selected_pattern = i;
                                          setState(() {});
                                          enable_or_diable_pattern();
                                        }),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        corrent_join_pattern =
                                        corrent_paterns_list[i];
                                        corrent_join_pattern_id = i;
                                        min_length =
                                            corrent_join_pattern.min_length;
                                        max_length =
                                            corrent_join_pattern.max_length;

                                        name_controller.text =
                                            corrent_join_pattern.name;
                                        mini_distence_controller.text =
                                        '$min_length';
                                        max_distence_controller.text =
                                        '$max_length';
                                        selected_door_pattern = i;
                                        selected_pattern = i;
                                        door_bore_units = [];
                                        side_bore_units = [];

                                        refresh();

                                        setState(() {});
                                      },
                                      child: Container(
                                        width: corrent ? 200 : 150,
                                        color: corrent
                                            ? Colors.teal[200]
                                            : Colors.grey[100],
                                        child: Center(
                                          child: Text(
                                            "$pattern_name",
                                            style: TextStyle(
                                                fontSize: corrent ? 20 : 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),

                SizedBox(
                  height: 32,
                ),

                /// add new pattern
                Container(
                  width: 65,
                  height: 65,
                  child: InkWell(
                    onTap: () {
                      add_new_pattern();
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.teal,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),

            /// parameter editor
            parameter_editor(),

            Container(
              width: 3,
              height: h - 50,
              color: Colors.grey,
            ),

            painters(),
          ]),
        ),
      ),
    );
  }
}
