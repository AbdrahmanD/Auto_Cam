import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateJoinholepatternDialog extends StatefulWidget {
  const CreateJoinholepatternDialog({Key? key}) : super(key: key);

  @override
  State<CreateJoinholepatternDialog> createState() =>
      _CreateJoinholepatternDialogState();
}

class _CreateJoinholepatternDialogState extends State<CreateJoinholepatternDialog> {
  
  Draw_Controller draw_controller = Get.find();

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

  bool have_nut = false;
  bool have_mirror = true;
  bool center = false;

  double min_length = 0;
  double max_length = 0;

  List<Bore_unit> bore_units = [];
  List<Bore_unit> Paint_bore_units_min = [];
  List<Bore_unit> Paint_bore_units_max = [];

  String corrent_category_name = "Box_Fitting_DRILL";
  List<JoinHolePattern> corrent_category_patterns = [];

  JoinHolePattern corrent_join_pattern =
  JoinHolePattern( 'name', 150, 300, [],true);

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

    Bore_unit bore_unit = Bore_unit(
        pre_distance,0,0,
        side_bore,
        have_nut,
        nut_destance,
        nut_bore,
        face_bore,
        center,
        have_mirror);
    bore_units.add(bore_unit);

    refresh();
  }

  save_pattern() async {

    double mini_length = double.parse(mini_distence_controller.text.toString());
    double max_length = double.parse(max_distence_controller.text.toString());

    JoinHolePattern joinHolePattern = JoinHolePattern(
        name_controller.text.toString(),
        mini_length,
        max_length,
        bore_units,true);

    await draw_controller.save_joinHolePattern(joinHolePattern,category_controller.text.toString());
    await draw_controller.read_pattern_files();

    refresh();
  }

  void delete_pattern()async {
    await draw_controller.delete_joinHolePattern(corrent_join_pattern,category_controller.text.toString());

    refresh();
  }

  pattern_from_history(JoinHolePattern pattern) {
    bore_units = [];
    Paint_bore_units_min = [];
    Paint_bore_units_max = [];

    min_length = pattern.min_length;
    max_length = pattern.max_length;

    mini_distence_controller.text = '$min_length';
    max_distence_controller.text = '$max_length';
    name_controller.text = '${pattern.name}';
    // category_controller.text = '${pattern.category}';

    bore_units = pattern.bores;

    corrent_join_pattern=pattern;
    Paint_bore_units_min = corrent_join_pattern.apply_pattern(min_length);
    Paint_bore_units_max = corrent_join_pattern.apply_pattern(max_length);


    refresh();
  }

  read_patterns() async {
    await draw_controller.read_pattern_files();
    refresh();
    setState(() {});
  }


  refresh() async{
    // print("center : $center");
    // print("mirror : $have_mirror");
    corrent_category_patterns = [];
    min_length = double.parse(mini_distence_controller.text.toString());
    max_length = double.parse(max_distence_controller.text.toString());

    corrent_join_pattern.bores = bore_units;

    Paint_bore_units_min = corrent_join_pattern.apply_pattern(min_length);
    Paint_bore_units_max = corrent_join_pattern.apply_pattern(max_length);
    category_controller.text = corrent_category_name;


    corrent_category_patterns =
    await (draw_controller.box_repository.join_patterns
    [category_controller.text.toString()]!);


    setState(() {});

  }





  @override
  void initState() {
    super.initState();

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
    read_patterns();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 800,
      height: 700,
      color: Colors.grey[100],
      child: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Row(
            children: [

              /// pattern category
              Container(
                width: 60,
                child: Center(
                  child: Text(
                    'pattern category',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 50,
                child: TextFormField(
                  controller: category_controller,
                  style: TextStyle(fontSize: 12),
                  onChanged: (_) {
                    refresh();
                  },
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

              /// pattern name
              Container(
                width: 60,
                child: Center(
                  child: Text(
                    'pattern name',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 50,
                child: TextFormField(
                  controller: name_controller,
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

              /// minimum length
              Container(
                width: 90,
                child: Center(
                  child: Text(
                    'Minimum length',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 75,
                height: 50,
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

              /// maximum length

              Container(
                width: 90,
                child: Center(
                  child: Text(
                    'Maximum length',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 75,
                height: 50,
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
          SizedBox(
            height: 32,
          ),
          Row(
            children: [

              /// parameter editor
              Container(
                  width: 200,
                  height: 550,
                  child: ListView(
                    children: [

                      ///  undo
                      Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                        ],
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
                                  "${double.parse(mini_distence_controller.text
                                      .toString()) / 2}";
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
                                bore_units.removeAt(bore_units.length - 1);
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
                            read_patterns();
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

              ///Devider
              Container(
                height: 500,
                width: 2,
                color: Colors.grey,
              ),

              Column(
                children: [

                  /// MIN Painter
                  // Container(
                  //   height: 250,
                  //   width: 400,
                  //   child: CustomPaint(
                  //     painter: draw_controller.draw_Pattern(
                  //         Paint_bore_units_min, min_length, 300, max_length),
                  //   ),
                  // ),

                  ///MAX Painter
                  // Container(
                  //   height: 250,
                  //   width: 400,
                  //   child: CustomPaint(
                  //     painter: draw_controller.draw_Pattern(
                  //         Paint_bore_units_max, max_length, 300, max_length),
                  //   ),
                  // ),
                ],
              ),

              ///Devider
              Container(
                height: 500,
                width: 2,
                color: Colors.grey,
              ),

              /// patterns listview
              Column(
                children: [
                  Text('categories List'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 150,
                      height: 250,
                      child: ListView.builder(
                          itemCount: draw_controller.box_repository
                              .join_patterns.keys
                              .toList()
                              .length,
                          itemBuilder: (context, i) {
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // pattern_from_history(draw_controller
                                        //     .box_repository
                                        //     .join_patterns
                                        //     );

                                        corrent_category_name =
                                        draw_controller.box_repository
                                            .join_patterns.keys.toList()[i];
                                        refresh();
                                      },
                                      child: Center(
                                        child: Text(
                                          '${draw_controller.box_repository
                                              .join_patterns.keys.toList()[i]}'
                                          , style: (corrent_category_name ==
                                            draw_controller.box_repository
                                                .join_patterns.keys.toList()[i]
                                        ) ? TextStyle(

                                            fontWeight: FontWeight.bold,
                                            color: Colors.red) : TextStyle(),),

                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      height: 1,
                                      width: 100,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                  SizedBox(
                    height: 24,
                  ),
                  Text('patterns List'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 150,
                      height: 250,
                      child: ListView.builder(
                          itemCount: corrent_category_patterns.length,
                          itemBuilder: (context, i) {
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          pattern_from_history(
                                              corrent_category_patterns[i]);
                                        },
                                        child: Center(
                                            child: Text(
                                                '${corrent_category_patterns[i]
                                                    .name}',
                                            style:
                                            (corrent_category_patterns[i]
                                                .name==corrent_join_pattern.name)?
                                            TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red) : TextStyle(),

                                            ))),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      height: 1,
                                      width: 100,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

}
