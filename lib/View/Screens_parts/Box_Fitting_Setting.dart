import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/View/Screens_parts/Box_Fitting_Editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Box_Fitting_Setting extends StatefulWidget {
  const Box_Fitting_Setting({Key? key}) : super(key: key);

  @override
  State<Box_Fitting_Setting> createState() => _Box_Fitting_SettingState();
}

class _Box_Fitting_SettingState extends State<Box_Fitting_Setting> {
  ScrollController crt = ScrollController();

  final my_setting_data = GetStorage();

  double screw_length = 30.0;
  double screw_diameter = 8.0;
  double blastic_nut_diameeter = 10.0;
  double blastic_nut_depth = 11.0;
  double nut_diameter = 15.0;
  double nut_depth = 14.0;
  double nut_distance = 33.0;
  double dowel_diameter =8.0;
  double dowel_depth = 30.0;

  bool screw = false;

  double d1 = 46;
  double d2 = 150;
  double d3 = 46;

  Draw_Controller draw_controller = Get.find();

  String corrent_setting = " SETTING - KD patterns ";
  String category = "Box_Fitting_DRILL";

  List<JoinHolePattern> list_boxes_fitting = [];

  int pattern_index = 0;

  late JoinHolePattern corrent_join_pattern;

  read_patterns() async {
    list_boxes_fitting = [];

    await draw_controller.read_pattern_files();

    Map<String, List<JoinHolePattern>> join_patterns =
        draw_controller.box_repository.join_patterns;

    list_boxes_fitting = join_patterns["Box_Fitting_DRILL"]!;

    setState(() {});
  }

  add_new_pattern() {

    JoinHolePattern corrent_join_pattern = JoinHolePattern('name', 150, 760, 0, 0, [], true);

    TextEditingController pattern_name_controller = TextEditingController();
    TextEditingController pattern_min_controller = TextEditingController();
    TextEditingController pattern_max_controller = TextEditingController();

    Get.defaultDialog(
      title: "add new join pattern",
      content: Container(
        width: 400,
        height: 300,
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: ListView(children: [
              SizedBox(
                height: 32,
              ),
              Row(children: [
                Container(width: 100, child: Text("pattern name ")),
                Container(
                  width: 200,
                  height: 32,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [DecimalTextInputFormatter(2)],
                    controller: pattern_name_controller,
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
              ]),
              SizedBox(
                height: 12,
              ),
              Row(children: [
                Container(width: 100, child: Text("mini length ")),
                Container(
                  width: 100,
                  height: 32,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [DecimalTextInputFormatter(2)],
                    controller: pattern_min_controller,
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
              ]),
              SizedBox(
                height: 12,
              ),
              Row(children: [
                Container(width: 100, child: Text("max length ")),
                Container(
                  width: 100,
                  height: 32,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [DecimalTextInputFormatter(2)],
                    controller: pattern_max_controller,
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
              ]),
              SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () async {
                  corrent_join_pattern.name =
                      pattern_name_controller.text.toString();
                  corrent_join_pattern.max_length =
                      double.parse(pattern_max_controller.text.toString());
                  corrent_join_pattern.min_length =
                      double.parse(pattern_min_controller.text.toString());

                  list_boxes_fitting.add(corrent_join_pattern);

                  await draw_controller.save_joinHolePattern(
                      corrent_join_pattern, category);
                  setState(() {});

                  Navigator.of(Get.overlayContext!).pop();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.teal[200],
                    ),
                    width: 150,
                    height: 36,
                    child: Center(child: Text("Add Pattern")),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );

  }

  edit_pattern(int i) {
    TextEditingController pattern_name_controller = TextEditingController();
    TextEditingController pattern_min_controller = TextEditingController();
    TextEditingController pattern_max_controller = TextEditingController();

    pattern_name_controller.text = "${list_boxes_fitting[i].name}";
    pattern_min_controller.text = "${list_boxes_fitting[i].min_length}";
    pattern_max_controller.text = "${list_boxes_fitting[i].max_length}";

    Get.defaultDialog(
      title: "add new join pattern",
      content: Container(
        width: 400,
        height: 300,
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: ListView(children: [
              SizedBox(
                height: 32,
              ),
              Row(children: [
                Container(width: 100, child: Text("pattern name ")),
                Container(
                  width: 200,
                  height: 32,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [DecimalTextInputFormatter(2)],
                    controller: pattern_name_controller,
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
              ]),
              SizedBox(
                height: 12,
              ),
              Row(children: [
                Container(width: 100, child: Text("mini length ")),
                Container(
                  width: 100,
                  height: 32,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [DecimalTextInputFormatter(2)],
                    controller: pattern_min_controller,
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
              ]),
              SizedBox(
                height: 12,
              ),
              Row(children: [
                Container(width: 100, child: Text("max length ")),
                Container(
                  width: 100,
                  height: 32,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [DecimalTextInputFormatter(2)],
                    controller: pattern_max_controller,
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
              ]),
              SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () {
                  list_boxes_fitting[i].name =
                      pattern_name_controller.text.toString();
                  list_boxes_fitting[i].max_length =
                      double.parse(pattern_max_controller.text.toString());
                  list_boxes_fitting[i].min_length =
                      double.parse(pattern_min_controller.text.toString());

                  save_changes();
                  setState(() {});

                  Navigator.of(Get.overlayContext!).pop();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.teal[200],
                    ),
                    width: 150,
                    height: 36,
                    child: Center(child: Text("save changes")),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () {
                  draw_controller.delete_joinHolePattern(
                      list_boxes_fitting[pattern_index], category);

                  list_boxes_fitting.removeAt(i);
                  pattern_index = 0;

                  setState(() {});

                  Navigator.of(Get.overlayContext!).pop();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red[200],
                    ),
                    width: 100,
                    height: 24,
                    child: Center(
                        child: Text(
                      "delete Pattern",
                      style: TextStyle(fontSize: 12),
                    )),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  save_changes() async {

    draw_controller.save_joinHolePattern(list_boxes_fitting[pattern_index], category);

    List<Bore_unit> bores=[];
    for(int i=0;i<list_boxes_fitting[pattern_index].bores.length;i++){
      if(list_boxes_fitting[pattern_index].bores[i].center){
        continue;
      }
      else{
        Bore_unit bore_unit = Bore_unit(
            list_boxes_fitting[pattern_index].bores[i].pre_distence-10,
            list_boxes_fitting[pattern_index].bores[i].correct_x,
            list_boxes_fitting[pattern_index].bores[i].correct_y,
            list_boxes_fitting[pattern_index].bores[i].side_bore,
            list_boxes_fitting[pattern_index].bores[i].have_nut_bore,
            list_boxes_fitting[pattern_index].bores[i].nut_bore_distence,
            list_boxes_fitting[pattern_index].bores[i].nut_bore,
            list_boxes_fitting[pattern_index].bores[i].face_bore,
            list_boxes_fitting[pattern_index].bores[i].center,
            list_boxes_fitting[pattern_index].bores[i].mirror
        );
        bores.add(bore_unit);
      }
    }

    JoinHolePattern drawer_face_pattern=JoinHolePattern(
        list_boxes_fitting[pattern_index].name,
        list_boxes_fitting[pattern_index].min_length,
        list_boxes_fitting[pattern_index].max_length,
        list_boxes_fitting[pattern_index].quantity,
        list_boxes_fitting[pattern_index].main_pre_distance,
        bores,
        list_boxes_fitting[pattern_index].pattern_enable
    );
    draw_controller.save_joinHolePattern(drawer_face_pattern, "Drawer_Face");

    Get.defaultDialog(
      title: "save change",
      content: Container(child: Text("The setting for corrent selected pattern are saved"),)
    );
  }

  add_dowel(Offset offset) {
    double pre_distance = offset.dx - 100;

    bool center = false;

    if ((pre_distance -
                (list_boxes_fitting[pattern_index].max_length / 2 + 300))
            .abs() <=
        50) {
      center = true;
      pre_distance = list_boxes_fitting[pattern_index].max_length / 2;
    } else {
      pre_distance = offset.dx - 300;
    }

    Bore_unit bore_unit = Bore_unit(
        pre_distance,
        0,
        0,
        Bore_model(Point_model(0, 0, 0), dowel_diameter, dowel_depth),
        false,
        0,
        Bore_model(Point_model(0, 0, 0), 0, 0),
        Bore_model(Point_model(0, 0, 0), dowel_diameter, 10),
        center,
        true);
    list_boxes_fitting[pattern_index].bores.add(bore_unit);

    setState(() {});
  }

  add_minifix(Offset offset) {
    double pre_distance = offset.dx - 100;

    bool center = false;

    if ((pre_distance -
                (list_boxes_fitting[pattern_index].max_length / 2 + 300))
            .abs() <=
        50) {
      center = true;
      pre_distance = list_boxes_fitting[pattern_index].max_length / 2;
    } else {
      pre_distance = offset.dx - 300;
    }

    Bore_unit bore_unit = Bore_unit(
        pre_distance,
        0,
        0,
        Bore_model(Point_model(0, 0, 0), screw_diameter, screw_length),
        true,
        nut_distance,
        Bore_model(Point_model(0, 0, 0), nut_diameter, nut_depth),
        Bore_model(
            Point_model(0, 0, 0), blastic_nut_diameeter, blastic_nut_depth),
        center,
        true);

    list_boxes_fitting[pattern_index].bores.add(bore_unit);

    setState(() {});
  }

  read_minifix_setting() {


    if (my_setting_data.read("mini_fix_setting")==true) {
      screw_length           = double.parse("${my_setting_data.read("screw_length")}");
      screw_diameter         = double.parse("${my_setting_data.read("screw_diameter")}");
      blastic_nut_diameeter  = double.parse("${my_setting_data.read("blastic_nut_diameter")}");
      blastic_nut_depth      = double.parse("${my_setting_data.read("blastic_nut_depth")}");
      nut_diameter           = double.parse("${my_setting_data.read("nut_diameter")}");
      nut_depth              = double.parse("${my_setting_data.read("nut_depth")}");
      nut_distance           = double.parse("${my_setting_data.read("nut_distance")}");
      dowel_diameter         = double.parse("${my_setting_data.read("dowel_diameter")}");
      dowel_depth            = double.parse("${my_setting_data.read("dowel_depth")}");
    }
    else{


      my_setting_data.write("screw_length", screw_length);
      my_setting_data.write("screw_diameter", screw_diameter);
      my_setting_data.write("blastic_nut_diameter", blastic_nut_diameeter);
      my_setting_data.write("blastic_nut_depth", blastic_nut_depth);
      my_setting_data.write("nut_diameter", nut_diameter);
      my_setting_data.write("nut_depth", nut_depth);
      my_setting_data.write("nut_distance", nut_distance);
      my_setting_data.write("dowel_diameter", dowel_diameter);
      my_setting_data.write("dowel_depth", dowel_depth);

      my_setting_data.write("mini_fix_setting", true);


    }

  }

  minifix_setting_dialog() {
    TextEditingController screw_length_controller = TextEditingController();
    TextEditingController screw_diameter_controller = TextEditingController();
    TextEditingController blastic_nut_diameeter_controller =
        TextEditingController();
    TextEditingController blastic_nut_depth_controller =
        TextEditingController();
    TextEditingController nut_diameter_controller = TextEditingController();
    TextEditingController nut_depth_controller = TextEditingController();
    TextEditingController nut_distance_controller = TextEditingController();

    screw_length_controller.text = "$screw_length";
    screw_diameter_controller.text = "$screw_diameter";
    blastic_nut_diameeter_controller.text = "$blastic_nut_diameeter";
    blastic_nut_depth_controller.text = "$blastic_nut_depth";
    nut_diameter_controller.text = "$nut_diameter";
    nut_depth_controller.text = "$nut_depth";
    nut_distance_controller.text = "$nut_distance";

    Get.defaultDialog(
      title: "mini fix setting ",
      content: Container(
        width: 600,
        height: 450,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 300,
                height: 450,
                child: ListView(children: [
                  SizedBox(
                    height: 32,
                  ),


                  ///blastic nut diameeter
                  Row(children: [
                    Container(width: 200, child: Text("blastic nut diameeter   A")),
                    Container(
                      width: 100,
                      height: 32,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: blastic_nut_diameeter_controller,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),


                  ///blastic nut depth
                  Row(children: [
                    Container(width: 200, child: Text("blastic nut depth          B")),
                    Container(
                      width: 100,
                      height: 32,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: blastic_nut_depth_controller,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),

                  ///screw diameter
                  Row(children: [
                    Container(width: 200, child: Text("screw diameter            D")),
                    Container(
                      width: 100,
                      height: 32,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: screw_diameter_controller,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),



                  ///screw length
                  Row(children: [
                    Container(width: 200, child: Text("screw length                E")),
                    Container(
                      width: 100,
                      height: 32,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: screw_length_controller,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),

                  ///face nut distance
                  Row(children: [
                    Container(width: 200, child: Text("face nut distance          ")),
                    Container(
                      width: 100,
                      height: 32,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: nut_distance_controller,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),

                  ///face nut diameter
                  Row(children: [
                    Container(width: 200, child: Text("face nut diameter         F")),
                    Container(
                      width: 100,
                      height: 32,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),

                  ///face nut depth
                  Row(children: [
                    Container(width: 200, child: Text("face nut depth             G")),
                    Container(
                      width: 100,
                      height: 32,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),



                  SizedBox(
                    height: 12,
                  ),

                  /// save button
                  InkWell(
                    onTap: () {
                      screw_length = double.parse(screw_length_controller.text.toString());
                      screw_diameter = double.parse(screw_diameter_controller.text.toString());
                      blastic_nut_diameeter = double.parse(
                          blastic_nut_diameeter_controller.text.toString());
                      blastic_nut_depth = double.parse(
                          blastic_nut_depth_controller.text.toString());
                      nut_diameter =
                          double.parse(nut_diameter_controller.text.toString());
                      nut_depth =
                          double.parse(nut_depth_controller.text.toString());
                      nut_distance =
                          double.parse(nut_distance_controller.text.toString());

                      my_setting_data.write("screw_length", screw_length);
                      my_setting_data.write("screw_diameter", screw_diameter);
                      my_setting_data.write("blastic_nut_diameter", blastic_nut_diameeter);
                      my_setting_data.write("blastic_nut_depth", blastic_nut_depth);
                      my_setting_data.write("nut_diameter", nut_diameter);
                      my_setting_data.write("nut_depth", nut_depth);
                      my_setting_data.write("nut_distance", nut_distance);

                      my_setting_data.write("mini_fix_setting", true);

                      setState(() {});

                      Navigator.of(Get.overlayContext!).pop();
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.teal[200],
                        ),
                        width: 150,
                        height: 36,
                        child: Center(child: Text("save changes")),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 32,
                  ),
                ]),
              ),
              Container(
                width: 270,
                height: 600,
                child: Image.asset("lib/assets/images/mini_fix_setting.png"),
              )
            ],
          ),
        ),
      ),
    );
  }


  dowel_setting_dialog() {

    TextEditingController dowel_diameter_controller = TextEditingController();
    TextEditingController dowel_depth_controller = TextEditingController();


    dowel_diameter_controller.text = "$dowel_diameter";
    dowel_depth_controller.text = "$dowel_depth";

    Get.defaultDialog(
      title: "mini fix setting ",
      content: Container(
        width: 450,
        height: 400,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 250,
                height: 400,
                child: ListView(children: [
                  SizedBox(
                    height: 32,
                  ),



                  ///dowel diameter
                  Row(children: [
                    Container(width: 150, child: Text("dowel diameter")),
                    Container(
                      width: 100,
                      height: 32,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: dowel_diameter_controller,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),

                  ///dowel depth
                  Row(children: [
                    Container(width:150, child: Text("dowel length")),
                    Container(
                      width: 100,
                      height: 32,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        controller: dowel_depth_controller,
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
                  ]),
                  SizedBox(
                    height: 12,
                  ),

                  SizedBox(
                    height: 12,
                  ),

                  /// save button
                  InkWell(
                    onTap: () {
                    dowel_diameter = double.parse(
                          dowel_diameter_controller.text.toString());
                      dowel_depth =
                          double.parse(dowel_depth_controller.text.toString());

                      my_setting_data.write("dowel_diameter", dowel_diameter);
                      my_setting_data.write("dowel_depth", dowel_depth);


                      setState(() {});

                      Navigator.of(Get.overlayContext!).pop();
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.teal[200],
                        ),
                        width: 150,
                        height: 36,
                        child: Center(child: Text("save changes")),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 32,
                  ),
                ]),
              ),
              Container(
                width: 150,
                height: 300,
                child: Image.asset("lib/assets/images/dowel.png"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {

    // my_setting_data.write("mini_fix_setting", false);


    read_patterns();
    read_minifix_setting();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    if (list_boxes_fitting.length > 0) {
      corrent_join_pattern = list_boxes_fitting[pattern_index];
    } else {
      corrent_join_pattern = JoinHolePattern('name', 150, 500, 0, 0, [], true);
    }
    return Scaffold(
      appBar: AppBar(title: Text(corrent_setting)),
      body: Row(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    width: 250,
                    height: h,
                    color: Colors.grey[100],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),

                        ///title : List of patterns
                        Text(
                          "List of patterns ",
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 24,
                        ),

                        /// pattern listview builder
                        Container(
                          width: 250,
                          height: h - 300,
                          child: ListView.builder(
                            itemCount: list_boxes_fitting.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: (pattern_index == index)
                                    ? Colors.blue[100]
                                    : Colors.grey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          edit_pattern(index);
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 24,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                        width: 150,
                                        child: InkWell(
                                          /// chose pattern
                                          onTap: () {
                                            pattern_index = index;

                                            setState(() {});
                                          },

                                          child: Text(
                                            "${list_boxes_fitting[index].name}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Checkbox(
                                          value: list_boxes_fitting[index]
                                              .pattern_enable,
                                          onChanged: (v) {
                                            list_boxes_fitting[index]
                                                    .pattern_enable =
                                                !list_boxes_fitting[index]
                                                    .pattern_enable;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        /// add new pattern button
                        InkWell(
                          onTap: () {
                            add_new_pattern();
                          },
                          child: Container(
                            width: 200,
                            height: 32,
                            child: Center(child: Text("NEW PATTERN")),
                            decoration: BoxDecoration(
                                color: Colors.teal[200],
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),

                        SizedBox(
                          height: 32,
                        ),


                        /// save change
                        InkWell(
                          onTap: () {
                            save_changes();
                          },
                          child: Container(
                            width: 200,
                            height: 32,
                            child: Center(child: Text("save pattern")),
                            decoration: BoxDecoration(
                                color: Colors.red[300],
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    )),
                Container(
                    width: w - 250,
                    height: h,
                    child: Column(
                      children: [
                        Container(
                          width: w - 200,
                          height: 142,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              /// mini fix draggable
                              Draggable(
                                feedback: Transform.scale(
                                  scale: 0.7,
                                  child: Transform.rotate(
                                    angle: -3.14 / 2,
                                    child: Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset(
                                                  "lib/assets/images/nut.png")),
                                          Container(
                                              width: 120,
                                              height: 120,
                                              child: Transform.rotate(
                                                  angle: 3.14 / 2,
                                                  child: Image.asset(
                                                      "lib/assets/images/screw.png"))),
                                          Container(
                                              width: 50,
                                              height: 50,
                                              child: Transform.rotate(
                                                  angle: 3.14 / 2,
                                                  child: Image.asset(
                                                      "lib/assets/images/blastic_nut.png"))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    width: 300,
                                    color: Colors.grey[200],
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 50,
                                            height: 50,
                                            child: Image.asset(
                                                "lib/assets/images/nut.png")),
                                        Container(
                                            width: 120,
                                            height: 120,
                                            child: Transform.rotate(
                                                angle: 3.14 / 2,
                                                child: Image.asset(
                                                    "lib/assets/images/screw.png"))),
                                        Container(
                                            width: 50,
                                            height: 50,
                                            child: Transform.rotate(
                                                angle: 3.14 / 2,
                                                child: Image.asset(
                                                    "lib/assets/images/blastic_nut.png"))),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              minifix_setting_dialog();
                                            },
                                            child: Container(
                                                width: 50,
                                                height: 50,
                                                child: Icon(
                                                  Icons.settings,
                                                  size: 32,
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                                onDragEnd: (v) {
                                  add_minifix(v.offset);
                                  setState(() {});
                                },
                              ),

                              /// dowel draggable
                              Draggable(
                                feedback: Transform.scale(
                                  scale: 0.7,
                                  child: Transform.rotate(
                                    angle: -3.14 / 2,
                                    child: Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 120,
                                              height: 120,
                                              child: Transform.rotate(
                                                  angle: 3.14 / 2,
                                                  child: Image.asset(
                                                      "lib/assets/images/dowel.png"))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    width: 262,
                                    color: Colors.grey[200],
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 200,
                                            height: 200,
                                            child: Transform.rotate(
                                                angle: 3.14 / 2,
                                                child: Image.asset(
                                                    "lib/assets/images/dowel.png"))),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              dowel_setting_dialog();
                                            },
                                            child: Container(
                                                width: 50,
                                                height: 50,
                                                child: Icon(
                                                  Icons.settings,
                                                  size: 32,
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                                onDragEnd: (v) {
                                  add_dowel(v.offset);

                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: h - 200,
                            width: w - 200,
                            color: Colors.grey[300],
                            child: Box_Fitting_Editor(
                                w - 200,
                                h - 200,
                                corrent_join_pattern,
                                draw_controller.box_repository.box_model.value
                                    .init_material_thickness
                            )
                        ),

                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
