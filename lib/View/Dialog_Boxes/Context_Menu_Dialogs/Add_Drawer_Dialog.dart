import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Add_Drawer_Dialog extends StatefulWidget {
  @override
  State<Add_Drawer_Dialog> createState() => _Add_Drawer_DialogState();
}

class _Add_Drawer_DialogState extends State<Add_Drawer_Dialog> {
  TextEditingController drawer_box_material_thickness = TextEditingController();

  TextEditingController drawer_box_height = TextEditingController();

  TextEditingController drawer_box_depth = TextEditingController();

  TextEditingController drawer_quantity = TextEditingController();

  Draw_Controller draw_controller = Get.find();

  int drawer_type = 1;

  ///

  TextEditingController material_controller = TextEditingController();

  TextEditingController round_gap_controller = TextEditingController();

  bool single_door = true;
  double up_over_lap = 1;
  double down_over_lap = 1;
  double left_over_lap = 1;
  double right_over_lap = 1;
  bool bool_up_over_lap_o = true;
  bool bool_up_over_lap_h = false;
  bool bool_up_over_lap_i = false;
  bool bool_down_over_lap_o = true;
  bool bool_down_over_lap_h = false;
  bool bool_down_over_lap_i = false;
  bool bool_left_over_lap_o = true;
  bool bool_left_over_lap_h = false;
  bool bool_left_over_lap_i = false;
  bool bool_right_over_lap_o = true;
  bool bool_right_over_lap_h = false;
  bool bool_right_over_lap_i = false;

  ///

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 500,
      child: Row(
        children: [

          Container(
            width: 300,
            height: 500,
            child: Column(
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
                    double double_drawer_box_material_thickness = double.parse(
                        drawer_box_material_thickness.text.toString());
                    double double_drawer_box_height =
                        double.parse(drawer_box_height.text.toString());
                    double double_drawer_box_depth =
                        double.parse(drawer_box_depth.text.toString());
                    int double_drawer_quantity =
                        double.parse(drawer_quantity.text.toString()).toInt();

                    if ((draw_controller
                                .box_repository
                                .box_model
                                .value
                                .box_pieces[draw_controller.hover_id]
                                .Piece_height -
                            double_drawer_quantity * double_drawer_box_height) >
                        (double_drawer_quantity + 1) * 5) {
                      draw_controller.add_drawer(
                          double_drawer_box_material_thickness,
                          double_drawer_box_height,
                          double_drawer_box_depth,
                          drawer_type,
                          double_drawer_quantity,
                      [up_over_lap,right_over_lap,down_over_lap,left_over_lap]
                      );

                      Navigator.of(context).pop();
                    } else {
                      Get.defaultDialog(
                          title: 'ERROR',
                          content: Text('You inter big value for drawer side'));
                    }
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

