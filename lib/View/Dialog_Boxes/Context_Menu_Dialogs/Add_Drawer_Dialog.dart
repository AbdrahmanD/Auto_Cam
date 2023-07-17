import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Drawer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Add_Drawer_Dialog extends StatefulWidget {
  @override
  State<Add_Drawer_Dialog> createState() => _Add_Drawer_DialogState();
}

class _Add_Drawer_DialogState extends State<Add_Drawer_Dialog> {
  TextEditingController drawer_box_material_thickness = TextEditingController();
  TextEditingController drawer_face_material_thickness =
      TextEditingController();
  TextEditingController drawer_base_material_thickness = TextEditingController();
  TextEditingController drawer_face_material_name = TextEditingController();

  TextEditingController drawer_box_height = TextEditingController();

  TextEditingController drawer_box_depth = TextEditingController();

  TextEditingController drawer_quantity = TextEditingController();

  Draw_Controller draw_controller = Get.find();

  int drawer_type = 1;

  ///

  TextEditingController All_base_gape_controller = TextEditingController();
  TextEditingController each_top_gape_controller = TextEditingController();
  TextEditingController left_gape_controller = TextEditingController();
  TextEditingController right_gape_controller = TextEditingController();

  bool single_door = true;

  ///
  ///
  @override
  void initState() {
    super.initState();

    drawer_box_material_thickness.text =
        '${draw_controller.box_repository.box_model.value.init_material_thickness}';
    drawer_box_height.text = '${140}';
    drawer_box_depth.text = '${400}';
    drawer_quantity.text = '${1}';
    drawer_face_material_thickness.text = '18';
    drawer_base_material_thickness.text = '5';
    All_base_gape_controller.text = '4';
    // All_top_gape_controller.text='2';
    each_top_gape_controller.text = '2';
    left_gape_controller.text = '1';
    right_gape_controller.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 280,
      child: Row(
        children: [
          SizedBox(width: 16,),
          Column(
            children: [
              Text('All Sides Gap '),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text('All_base    '),
                  Container(
                    height: 32,
                    width: 60,
                    child: TextFormField(
                      controller: All_base_gape_controller,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      validator: (d) {
                        if (d!.isEmpty) {
                          return 'add value please';
                        }
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),

              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('each_top   ' ),
                  Container(
                    height: 32,
                    width: 60,
                    child: TextFormField(
                      controller: each_top_gape_controller,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      validator: (d) {
                        if (d!.isEmpty) {
                          return 'add value please';
                        }
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('left_gape   '),
                  Container(
                    height: 32,
                    width: 60,
                    child: TextFormField(
                      controller: left_gape_controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9 -]')),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      validator: (d) {
                        if (d!.isEmpty) {
                          return 'add value please';
                        }
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('right_gape '),
                  Container(
                    height: 32,
                    width: 60,
                    child: TextFormField(
                      controller: right_gape_controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9 -]')),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      validator: (d) {
                        if (d!.isEmpty) {
                          return 'add value please';
                        }
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () {
                  double double_drawer_box_material_thickness = double.parse(
                      drawer_box_material_thickness.text.toString());
                  double double_drawer_face_material_thickness = double.parse(
                      drawer_face_material_thickness.text.toString());
                  double double_All_base_gape_controller =
                  double.parse(All_base_gape_controller.text.toString());
                  double double_drawer_base_material_thickness = double.parse(
                      drawer_base_material_thickness.text.toString());
                  double double_each_top_gape_controller =
                  double.parse(each_top_gape_controller.text.toString());
                  double double_left_gape_controller =
                  double.parse(left_gape_controller.text.toString());
                  double double_right_gape_controller =
                  double.parse(right_gape_controller.text.toString());

                  double double_drawer_box_height =
                  double.parse(drawer_box_height.text.toString());
                  double double_drawer_box_depth =
                  double.parse(drawer_box_depth.text.toString());
                  int double_drawer_quantity =
                  double.parse(drawer_quantity.text.toString()).toInt();

                  Drawer_model my_drawer = Drawer_model(
                      1,
                      draw_controller.hover_id,
                      1,
                      double_drawer_quantity,
                      double_All_base_gape_controller,
                      double_each_top_gape_controller,
                      double_left_gape_controller,
                      double_right_gape_controller,
                      double_drawer_face_material_thickness,
                      drawer_face_material_name.text.toString(),
                      double_drawer_box_material_thickness,
                      double_drawer_base_material_thickness,
                      double_drawer_box_height,
                      double_drawer_box_depth);

                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.teal),
                  width: 140,
                  height: 40,
                  child: Center(
                      child: Text(
                        'ok',
                        style: TextStyle(fontSize: 18),
                      )),
                ),
              ),
            ],
          ),

          //divider
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: 2,
              color: Colors.grey,
            ),
          ),

          Container(
            width: 282,
            height: 500,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Material thickness     '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: drawer_box_material_thickness,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                ///face material thickness
                Row(
                  children: [
                    Text('face thickness           '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: drawer_face_material_thickness,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                ///face material name
                Row(
                  children: [
                    Text('Face Material name   '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        controller: drawer_face_material_name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                ///base panel thickness
                Row(
                  children: [
                    Text('base panel thickness'),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: drawer_base_material_thickness,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),



                Divider(height: 4,color: Colors.black,),
                SizedBox(
                  height: 6,
                ),

                Row(
                  children: [
                    Text('Drawer side height    '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: drawer_box_height,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),




                Row(
                  children: [
                    Text('Drawer side depth     '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: drawer_box_depth,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text('Drawers quantity       '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: drawer_quantity,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

