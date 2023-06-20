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
  TextEditingController drawer_face_material_thickness = TextEditingController();
  TextEditingController drawer_base_material_thickness = TextEditingController();

  TextEditingController drawer_box_height = TextEditingController();

  TextEditingController drawer_box_depth = TextEditingController();

  TextEditingController drawer_quantity = TextEditingController();

  Draw_Controller draw_controller = Get.find();

  int drawer_type = 1;

  ///

  TextEditingController All_base_gape_controller = TextEditingController();
  TextEditingController each_top_gape_controller = TextEditingController();
  TextEditingController left_gape_controller     = TextEditingController();
  TextEditingController right_gape_controller    = TextEditingController();

  bool single_door = true;


  ///
  ///
  @override
  void initState() {

    super.initState();

    drawer_box_material_thickness.text='${draw_controller.box_repository.box_model.value.init_material_thickness}';
    drawer_box_height.text='${140}';
    drawer_box_depth.text='${400}';
    drawer_quantity.text='${1}';
    drawer_face_material_thickness.text='18';
    drawer_base_material_thickness.text='5';
    All_base_gape_controller.text='4';
    // All_top_gape_controller.text='2';
    each_top_gape_controller.text='2';
    left_gape_controller.text='1';
    right_gape_controller.text='1';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 500,
      child: Row(
        children: [

          Column(
            children: [
              Row(children: [Text('All_base'),Container(height: 32,width: 100,child:   TextFormField(controller: All_base_gape_controller,inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
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
                        } ,),)],),
              SizedBox(height: 4,),
              // Row(children: [Text('All_top'),Container(height: 32,width: 100,child: TextFormField(controller: All_top_gape_controller  ,inputFormatters: [
              //             FilteringTextInputFormatter.digitsOnly
              //           ],
              //           decoration: InputDecoration(
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(4),
              //             ),
              //           ),
              //           validator: (d) {
              //             if (d!.isEmpty) {
              //               return 'add value please';
              //             }
              //           } ,),)],),
              SizedBox(height: 4,),
              Row(children: [Text('each_top'),Container(height: 32,width: 100,child: TextFormField(controller: each_top_gape_controller,inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
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
                        } ,),)],),
              SizedBox(height: 4,),
              Row(children: [Text('left_gape'),Container(height: 32,width: 100,child: TextFormField(controller: left_gape_controller   ,inputFormatters: [
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
                        },),)],),
              SizedBox(height: 4,),
              Row(children: [Text('right_gape'),Container(height: 32,width: 100,
                child: TextFormField(controller: right_gape_controller ,
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
                        }, ),)],),
            ],
          ),

          //divider
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                    Text('Material thickness '),
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
                Row(
                  children: [
                    Text('face thickness '),
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
                Row(
                  children: [
                    Text('Drawer side height:'),
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
                    Text('base panel:'),
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

                Row(
                  children: [
                    Text('Drawer side depth :'),
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
                    Text('Drawers quantity :'),
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
                SizedBox(
                  height: 6,
                ),
                InkWell(
                  onTap: () {

                    double double_drawer_box_material_thickness  = double.parse(drawer_box_material_thickness.text.toString());
                    double double_drawer_face_material_thickness = double.parse(drawer_face_material_thickness.text.toString());
                    double double_All_base_gape_controller       = double.parse(All_base_gape_controller.text.toString());
                    double double_drawer_base_material_thickness        = double.parse(drawer_base_material_thickness.text.toString());
                    double double_each_top_gape_controller       = double.parse(each_top_gape_controller.text.toString());
                    double double_left_gape_controller           = double.parse(left_gape_controller    .text.toString());
                    double double_right_gape_controller          = double.parse(right_gape_controller   .text.toString());

                    double double_drawer_box_height =
                        double.parse(drawer_box_height.text.toString());
                    double double_drawer_box_depth =
                        double.parse(drawer_box_depth.text.toString());
                    int double_drawer_quantity =
                        double.parse(drawer_quantity.text.toString()).toInt();

                    Drawer_model my_drawer=Drawer_model(1, draw_controller.hover_id, 1, double_drawer_quantity,
                       double_All_base_gape_controller ,
                       // double_All_top_gape_controller  ,
                       double_each_top_gape_controller ,
                       double_left_gape_controller     ,
                       double_right_gape_controller    ,
                        double_drawer_face_material_thickness,
                        double_drawer_box_material_thickness,
                        double_drawer_base_material_thickness,
                        double_drawer_box_height, double_drawer_box_depth);

                    Navigator.of(context).pop();

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.teal),
                    width: 80,
                    height: 40,
                    child: Center(
                        child: Text(
                      'ok',
                      style: TextStyle(fontSize: 14),
                    )),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}

/*
 Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                Text('declare overlaping for every edge'),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('up :  '),
                    Checkbox(
                        value: bool_up_over_lap_o,
                        onChanged: (_) {
                          bool_up_over_lap_o = true;
                          bool_up_over_lap_h = false;
                          bool_up_over_lap_i = false;
                          up_over_lap = 1;
                          setState(() {});
                        }),
                    Text('over'),
                    SizedBox(
                      width: 4,
                    ),
                    Checkbox(
                        value: bool_up_over_lap_h,
                        onChanged: (_) {
                          bool_up_over_lap_h = true;
                          bool_up_over_lap_o = false;
                          bool_up_over_lap_i = false;
                          up_over_lap = 0.5;
                          setState(() {});
                        }),
                    Text('half'),
                    SizedBox(
                      width: 4,
                    ),
                    Checkbox(
                        value: bool_up_over_lap_i,
                        onChanged: (_) {
                          bool_up_over_lap_i = true;
                          bool_up_over_lap_o = false;
                          bool_up_over_lap_h = false;
                          up_over_lap = 0;
                          setState(() {});
                        }),
                    Text('inner'),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                Row(children: [
                  Column(
                    children: [
                      Text('left :  '),
                      Row(
                        children: [
                          Checkbox(
                              value: bool_left_over_lap_o,
                              onChanged: (_) {
                                bool_left_over_lap_o = true;
                                bool_left_over_lap_h = false;
                                bool_left_over_lap_i = false;
                                left_over_lap = 1;
                                setState(() {});
                              }),
                          Text('over'),
                          SizedBox(
                            width: 12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: bool_left_over_lap_h,
                              onChanged: (_) {
                                bool_left_over_lap_h = true;
                                bool_left_over_lap_o = false;
                                bool_left_over_lap_i = false;
                                left_over_lap = 0.5;
                                setState(() {});
                              }),
                          Text('half'),
                          SizedBox(
                            width: 12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: bool_left_over_lap_i,
                              onChanged: (_) {
                                bool_left_over_lap_i = true;
                                bool_left_over_lap_h = false;
                                bool_left_over_lap_o = false;
                                left_over_lap = 0;
                                setState(() {});
                              }),
                          Text('inner'),
                          SizedBox(
                            width: 12,
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 132,
                    height: 224,
                    color: Colors.yellow,
                    child: Text('ok'),
                  ),
                  Column(
                    children: [
                      Text('right :  '),
                      Row(
                        children: [
                          Checkbox(
                              value: bool_right_over_lap_o,
                              onChanged: (_) {
                                bool_right_over_lap_o = true;
                                bool_right_over_lap_h = false;
                                bool_right_over_lap_i = false;
                                right_over_lap = 1;
                                setState(() {});
                              }),
                          Text('over'),
                          SizedBox(
                            width: 12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: bool_right_over_lap_h,
                              onChanged: (_) {
                                bool_right_over_lap_h = true;
                                bool_right_over_lap_o = false;
                                bool_right_over_lap_i = false;
                                right_over_lap = 0.5;
                                setState(() {});
                              }),
                          Text('half'),
                          SizedBox(
                            width: 12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: bool_right_over_lap_i,
                              onChanged: (_) {
                                bool_right_over_lap_i = true;
                                bool_right_over_lap_o = false;
                                bool_right_over_lap_h = false;
                                right_over_lap = 0;
                                setState(() {});
                              }),
                          Text('inner'),
                          SizedBox(
                            width: 12,
                          )
                        ],
                      ),
                    ],
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('down :  '),
                    Checkbox(
                        value: bool_down_over_lap_o,
                        onChanged: (_) {
                          bool_down_over_lap_o = true;
                          bool_down_over_lap_i = false;
                          bool_down_over_lap_h = false;
                          down_over_lap = 1;
                          setState(() {});
                        }),
                    Text('over'),
                    SizedBox(
                      width: 4,
                    ),
                    Checkbox(
                        value: bool_down_over_lap_h,
                        onChanged: (_) {
                          bool_down_over_lap_h = true;
                          bool_down_over_lap_o = false;
                          bool_down_over_lap_i = false;
                          down_over_lap = 0.5;
                          setState(() {});
                        }),
                    Text('half'),
                    SizedBox(
                      width: 4,
                    ),
                    Checkbox(
                        value: bool_down_over_lap_i,
                        onChanged: (_) {
                          bool_down_over_lap_i = true;
                          bool_down_over_lap_o = false;
                          bool_down_over_lap_h = false;
                          down_over_lap = 0;
                          setState(() {});
                        }),
                    Text('inner'),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ],
            ),
 */