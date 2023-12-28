import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Door_Pattern_Painter.dart';
import 'package:auto_cam/Controller/Painters/Pattern_Painter.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
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
  bool Drawer_face = false;
  bool Doors = false;

  JoinHolePattern corrent_join_pattern = JoinHolePattern('name', 150, 300, []);

  int corrent_join_pattern_id = 0;

  List<JoinHolePattern> corrent_paterns_list = [];

  List<JoinHolePattern> list_boxes_fitting = [];
  List<JoinHolePattern> list_Drawer_face = [];
  List<JoinHolePattern> list_Drawer_Rail_Box = [];
  List<JoinHolePattern> list_Drawer_Rail_Side = [];
  List<JoinHolePattern> list_Door_Hinges = [];
  List<JoinHolePattern> list_side_Hinges = [];
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

  List<Bore_unit> door_bore_units = [];
  List<Bore_unit> side_bore_units = [];





  bool have_nut = false;
  bool have_mirror = true;
  bool center = false;

  double min_length = 0;
  double max_length = 0;

  List<Bore_unit> bore_units = [];
  List<Bore_unit> Paint_bore_units_min = [];
  List<Bore_unit> Paint_bore_units_max = [];

  refresh() async {
    // Paint_bore_units_min=[];
    // Paint_bore_units_max=[];
    // corrent_category_patterns = [];

    min_length = double.parse(mini_distence_controller.text.toString());
    max_length = double.parse(max_distence_controller.text.toString());

    bore_units = corrent_join_pattern.bores;

    Paint_bore_units_min = corrent_join_pattern.apply_pattern(min_length);
    Paint_bore_units_max = corrent_join_pattern.apply_pattern(max_length);
    // category_controller.text = corrent_category_name;

    // corrent_category_patterns =
    //     await (draw_controller.box_repository.join_patterns
    //     [category_controller.text.toString()]!);

    category_controller.text = corrent_category;


    // print("list_Door_Hinges = ${list_Door_Hinges.length}");
    // print("list_side_Hinges = ${list_side_Hinges.length}");

    door_bore_units=list_Door_Hinges[0].bores;
    side_bore_units=list_side_Hinges[0].bores;






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

    Bore_unit bore_unit = Bore_unit(pre_distance, side_bore, have_nut,
        nut_destance, nut_bore, face_bore, center, have_mirror);

    bore_units.add(bore_unit);
    refresh();
    setState(() {});
  }

  save_pattern() async {

    double mini_length = double.parse(mini_distence_controller.text.toString());
    double max_length = double.parse(max_distence_controller.text.toString());


    if (category_controller.text.toString()!="Doors") {

      JoinHolePattern joinHolePattern = JoinHolePattern(name_controller.text.toString(), mini_length, max_length, bore_units);

      await draw_controller.save_joinHolePattern(joinHolePattern, category_controller.text.toString());

      await draw_controller.read_pattern_files();

    }
    else{
      JoinHolePattern door_joinHolePattern = JoinHolePattern(name_controller.text.toString(), mini_length, max_length, door_bore_units);
      JoinHolePattern side_joinHolePattern = JoinHolePattern(name_controller.text.toString(), mini_length, max_length, side_bore_units);

      await draw_controller.save_joinHolePattern(door_joinHolePattern, "Door_Hinges".toString());
      await draw_controller.save_joinHolePattern(side_joinHolePattern, "side_Hinges".toString());

      await draw_controller.read_pattern_files();

     }

    refresh();
  }

  void delete_pattern() async {
    await draw_controller.delete_joinHolePattern(
        corrent_join_pattern, category_controller.text.toString());

    refresh();
  }

  Widget painters() {
    late Widget widget;
    if (corrent_category == "Box_Fitting_DRILL")
    {
      widget = Column(
        children: [
          Container(
            height: 400,
            color: Colors.grey[200],
            child: CustomPaint(
              painter: Pattern_Painter(
                  Paint_bore_units_min,
                  [],
                  draw_controller.box_repository.box_model.value.init_material_thickness,
                  min_length,
                  500,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 400,
            color: Colors.grey[200],
            child: CustomPaint(
              painter: Pattern_Painter(
                  Paint_bore_units_max,
                  [],
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  max_length,
                  500,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
        ],
      );
    }
    else if (corrent_category == "Drawer_Face")
    {

      // List<Bore_unit> secondary_min_bore_units =detect_drawer_secondary_bore(corrent_join_pattern.min_length);
      // List<Bore_unit> secondary_max_bore_units =detect_drawer_secondary_bore(corrent_join_pattern.max_length);

      widget = Column(
        children: [
          Container(
            height: 400,
            color: Colors.grey[200],
            child: CustomPaint(
              painter: Pattern_Painter(
                  Paint_bore_units_min,
                  [],
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  min_length,
                  500,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 400,
            color: Colors.grey[200],
            child: CustomPaint(
              painter: Pattern_Painter(
                  Paint_bore_units_max,
                  [],
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  max_length,
                  500,
                  max_length,
                  corrent_category),
              child: Container(),
            ),
          ),
        ],
      );
    }
    else if (corrent_category == "Doors")
    {


      widget = Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey[200],
            child: CustomPaint(
              painter: Door_Pattern_Painter(
                  door_bore_units,
                  side_bore_units,
                  draw_controller
                      .box_repository.box_model.value.init_material_thickness,
                  min_length,
                  600,
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
    else
    {
      widget = Container();
    }

    return widget;
  }

  add_door_unit()async{


    double Pre_distance =double.parse(pre_distence_controller.text.toString());
    double A_value =double.parse(A_controller.text.toString());
    double A_depth_value =double.parse(A_depth_controller.text.toString());
    double B_value =double.parse(B_controller.text.toString());
    double C_value =double.parse(C_controller.text.toString());
    double D_value =double.parse(D_controller.text.toString());
    double E_value =double.parse(E_controller.text.toString());
    double F_value =double.parse(F_controller.text.toString());

    double H_depth_value =double.parse(H_depth_controller.text.toString());
    double H_value =double.parse(H_controller.text.toString());
    double J_depth_value =double.parse(J_depth_controller.text.toString());
    double J_value =double.parse(J_controller.text.toString());

    Bore_model main_hole=          Bore_model(Point_model(0,22.5-B_value,0), A_value, A_depth_value);
    Bore_model main_hole_support_1=Bore_model(Point_model(0,C_value-B_value,0), H_value,H_depth_value);
    Bore_model main_hole_support_2=Bore_model(Point_model(0,C_value-B_value,0),H_value,H_depth_value);

    Bore_model side_hole_1=        Bore_model(Point_model(0,E_value,0), J_value, J_depth_value);
    Bore_model side_hole_2=        Bore_model(Point_model(0,E_value,0), J_value, J_depth_value);


    Bore_model emety_bore=        Bore_model(Point_model(0,22,0), 0, 0);



    // Bore_model door_test_bore =  Bore_model(Point_model(0,22,0),35, 14);
    // Bore_model door_test_bore1 =  Bore_model(Point_model(33,33,0),3, 3);
    // Bore_model door_test_bore2 =  Bore_model(Point_model(-33,33,0),3, 3);
    //
    // Bore_model side_test_bore =  Bore_model(Point_model(10,22,0),3, 3);
    // Bore_model side_test_bore2 =  Bore_model(Point_model(-10,22,0),3, 3);


    Bore_unit Door_unit_1=Bore_unit(Pre_distance, emety_bore , false, 0, emety_bore,  main_hole          , center, have_mirror);
    Bore_unit Door_unit_2=Bore_unit(Pre_distance-D_value/2, emety_bore , false, 0, emety_bore,  main_hole_support_1, center, have_mirror);
    Bore_unit Door_unit_3=Bore_unit(Pre_distance+D_value/2, emety_bore , false, 0, emety_bore,  main_hole_support_2, center, have_mirror);


    Bore_unit side_unit_1=Bore_unit(Pre_distance-F_value/2, emety_bore , false, 0,  emety_bore,  side_hole_1        , center, have_mirror);
    Bore_unit side_unit_2=Bore_unit(Pre_distance+F_value/2, emety_bore , false, 0,  emety_bore,  side_hole_2        , center, have_mirror);

    //
    // Bore_unit Door_unit_1=Bore_unit(Pre_distance, emety_bore , true, 0, emety_bore,  door_test_bore , center, have_mirror);
    // Bore_unit Door_unit_2=Bore_unit(Pre_distance, emety_bore , true, 0, emety_bore,  door_test_bore1 , center, have_mirror);
    // Bore_unit Door_unit_3=Bore_unit(Pre_distance, emety_bore , true, 0, emety_bore,  door_test_bore2, center, have_mirror);
    //
    //
    //
    //
    // Bore_unit side_unit_2=Bore_unit(Pre_distance, emety_bore , true, 0, emety_bore,  side_test_bore , center, have_mirror);
    // Bore_unit side_unit_22=Bore_unit(Pre_distance, emety_bore , true, 0, emety_bore,  side_test_bore2 , center, have_mirror);
    //
    //
    //
    door_bore_units.add( Door_unit_1 );
    door_bore_units.add( Door_unit_2 );
    door_bore_units.add( Door_unit_3 );
    // door_bore_units.add( Door_unit_2 );
    // door_bore_units.add( Door_unit_3 );
    //
    side_bore_units.add(side_unit_1);
    side_bore_units.add(side_unit_2);
    // side_bore_units.add(side_unit_22);

    refresh();

  }

  Widget parameter_editor() {
    late Widget widget;
    if (corrent_category == "Box_Fitting_DRILL")
    {
      widget =  Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
            width: 300,
            child: ListView(
              children: [
                SizedBox(height: 70,),
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
                        inputFormatters: [
                          DecimalTextInputFormatter(2)
                        ],
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
                        inputFormatters: [
                          DecimalTextInputFormatter(2)
                        ],
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
                        inputFormatters: [
                          DecimalTextInputFormatter(2)
                        ],
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
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8, bottom: 8),
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
    else if (corrent_category == "Drawer_Face")
    {

      widget =  Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
            width: 300,
            child: ListView(
              children: [

                SizedBox(height: 70,),
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
                        inputFormatters: [
                          DecimalTextInputFormatter(2)
                        ],
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
                        inputFormatters: [
                          DecimalTextInputFormatter(2)
                        ],
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
                        inputFormatters: [
                          DecimalTextInputFormatter(2)
                        ],
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
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8, bottom: 8),
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
    else if (corrent_category == "Doors")
    {
      widget =    Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
            width: 300,
            child: ListView(
              children: [

                ///photo
                Container(width: 300,
                  child: Image.asset("lib/assets/images/hinges.png"),),

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
                    Container(
                        width: 100,
                        height: 35,
                        child: Container()
                    ),
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
                    Container(
                        width: 100,
                        height: 35,
                        child: Container()
                    ),
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
                    ),  SizedBox(
                      width: 12,
                    ),
                    Container(
                        width: 100,
                        height: 35,
                        child: Container()
                    ),

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
                    ),  SizedBox(
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
                          center = !center;

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

                          center = !center;
                          have_mirror = !have_mirror;

                          pre_distence_controller.text="${min_length/2}";

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
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {

                          if (door_bore_units.length>0) {
                            door_bore_units.removeAt(door_bore_units.length-1);
                            side_bore_units.removeAt(side_bore_units.length-1);
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
    else
    {
      widget = Container();
    }

    return widget;
  }

  List<Bore_unit> detect_drawer_secondary_bore(double d) {
    List<Bore_unit> secondary_bore_units=[];


    List<JoinHolePattern>? my_patterns =
    draw_controller.box_repository.join_patterns[corrent_category];

    for (JoinHolePattern pattern in my_patterns!) {
      if (d > pattern.min_length && d <= pattern.max_length) {

        secondary_bore_units= pattern.apply_pattern(d);


        print(" d = $d");
        print(" secondary_bore_units = ${secondary_bore_units.length}");


      }
    }

    return secondary_bore_units;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    draw_controller.read_pattern_files();

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

    /// hinges
    A_controller.text="35";
    A_depth_controller.text="13";
    B_controller.text="22.5";
    C_controller.text="32";
    D_controller.text="45";
     E_controller.text="37";
     F_controller.text="32";

    H_depth_controller.text="3";
    H_controller.text="3";
    J_depth_controller.text="3";
    J_controller.text="3";


    ///



    min_length = corrent_join_pattern.min_length;
    max_length = corrent_join_pattern.max_length;

    list_boxes_fitting = draw_controller.box_repository.join_patterns["Box_Fitting_DRILL"]!;
    list_Drawer_face = draw_controller.box_repository.join_patterns["Drawer_Face"]!;
    list_Drawer_Rail_Box = draw_controller.box_repository.join_patterns["Drawer_Rail_Box"]!;
    list_Drawer_Rail_Side = draw_controller.box_repository.join_patterns["Drawer_Rail_Side"]!;



    list_Door_Hinges = draw_controller.box_repository.join_patterns["Door_Hinges"]!;
    list_side_Hinges = draw_controller.box_repository.join_patterns["side_Hinges"]!;

    list_Groove = draw_controller.box_repository.join_patterns["Groove"]!;
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: Text(corrent_setting),
      ),
      body: Container(
        height: h - 50,
        width: w,
        child: Container(
          child: Row(children: [
            /// main chois : cnc tool setting \ kd fitting patterns
            Container(
              width: w / 10,
              height: h - 50,
              color: Colors.grey[300],
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        corrent_setting = "KD patters setting";
                        kd_patterns_setting = true;
                        cnc_tool_setting = false;
                        setState(() {});
                      },
                      child: Container(
                        width: kd_patterns_setting ? 150 : 100,
                        height: kd_patterns_setting ? 65 : 45,
                        color: kd_patterns_setting
                            ? Colors.teal[300]
                            : Colors.grey,
                        child: Center(
                          child: Text(
                            'KD patterns',
                            style: TextStyle(
                                fontSize: kd_patterns_setting ? 18 : 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        // corrent_setting="cnc tool setting";
                        // kd_patterns_setting=false;
                        // cnc_tool_setting=true;
                        // setState(() {
                        //
                        // });
                      },
                      child: Container(
                        width: cnc_tool_setting ? 150 : 100,
                        height: cnc_tool_setting ? 65 : 45,
                        color: cnc_tool_setting
                            ? Colors.teal[300]
                            : Colors.grey[300],
                        child: Center(
                          child: Text(
                            'cnc tools',
                            style:
                                TextStyle(fontSize: cnc_tool_setting ? 22 : 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
                        corrent_setting = "Box fitting";

                        boxes_fitting = true;
                        Drawer_face = false;
                        Doors = false;
                        corrent_paterns_list = list_boxes_fitting;
                        corrent_join_pattern_id = 0;

                        corrent_category = "Box_Fitting_DRILL";
refresh();
                        setState(() {});
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

                  ///Drawer face
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        corrent_setting = "Drawer face";
                        boxes_fitting = false;
                        Drawer_face = true;
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

                  ///Doors
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        corrent_setting = "Doors";
                        boxes_fitting = false;
                        Drawer_face = false;
                        Doors = true;
                        corrent_paterns_list = list_Door_Hinges;
                        corrent_join_pattern_id = 0;
                        corrent_category = "Doors";
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
            Container(
                width: w / 8,
                height: h - 50,
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: ListView.builder(
                      itemCount: corrent_paterns_list.length,
                      itemBuilder: (context, i) {
                        bool corrent = (corrent_join_pattern_id == i);
                        String pattern_name = corrent_paterns_list[i].name;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              corrent_join_pattern = corrent_paterns_list[i];
                              corrent_join_pattern_id = i;
                              min_length = corrent_join_pattern.min_length;
                              max_length = corrent_join_pattern.max_length;

                              name_controller.text = corrent_join_pattern.name;
                              mini_distence_controller.text = '$min_length';
                              max_distence_controller.text = '$max_length';

                              refresh();

                              setState(() {});
                            },
                            child: Container(
                              width: corrent ? 100 : 750,
                              color:
                                  corrent ? Colors.teal[300] : Colors.grey[100],
                              child: Center(
                                child: Text(
                                  pattern_name,
                                  style: TextStyle(fontSize: corrent ? 24 : 12),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )),

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
