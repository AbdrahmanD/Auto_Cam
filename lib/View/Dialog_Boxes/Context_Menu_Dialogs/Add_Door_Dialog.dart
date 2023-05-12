import 'dart:math';

import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Add_Door_Dialog extends StatefulWidget {


  @override
  State<Add_Door_Dialog> createState() => _Add_Door_DialogState();
}

class _Add_Door_DialogState extends State<Add_Door_Dialog> {

  TextEditingController material_controller = TextEditingController();

  TextEditingController round_gap_controller = TextEditingController();
  Draw_Controller draw_controller=Get.find();

  bool single_door=true;

  double up_over_lap    =1;

  double down_over_lap  =1;

  double left_over_lap =1;

  double right_over_lap=1;

  bool bool_up_over_lap_o  =true;

  bool bool_up_over_lap_h   =false;

  bool bool_up_over_lap_i   =false;

  bool bool_down_over_lap_o =true;

  bool bool_down_over_lap_h =false;

  bool bool_down_over_lap_i =false;

  bool bool_left_over_lap_o =true;

  bool bool_left_over_lap_h =false;

  bool bool_left_over_lap_i =false;

  bool bool_right_over_lap_o=true;

  bool bool_right_over_lap_h=false;

  bool bool_right_over_lap_i=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 518,
      height: 325,
      child: Row(
        children: [
          SizedBox(
            height: 12,
          ),

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

                    Checkbox(value: bool_up_over_lap_o, onChanged: (_) {
                      bool_up_over_lap_o=true;
                      bool_up_over_lap_h=false;
                      bool_up_over_lap_i=false;
                      up_over_lap=1;
                      setState(() {});

                    }),
                    Text('over'),
                    SizedBox(
                      width: 4,
                    ),
                    Checkbox(value: bool_up_over_lap_h, onChanged: (_) {
                      bool_up_over_lap_h=true;
                      bool_up_over_lap_o=false;
                      bool_up_over_lap_i=false;
                      up_over_lap=0.5;
                      setState(() {});

                    }),
                    Text('half'),
                    SizedBox(
                      width: 4,
                    ),
                    Checkbox(value: bool_up_over_lap_i, onChanged: (_) {
                      bool_up_over_lap_i=true;
                      bool_up_over_lap_o=false;
                      bool_up_over_lap_h=false;
                      up_over_lap=0;
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
                          Checkbox(value: bool_left_over_lap_o, onChanged: (_) {
                            bool_left_over_lap_o=true;
                            bool_left_over_lap_h=false;
                            bool_left_over_lap_i=false;
                            left_over_lap=1;
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
                          Checkbox(value: bool_left_over_lap_h, onChanged: (_) {
                            bool_left_over_lap_h=true;
                            bool_left_over_lap_o=false;
                            bool_left_over_lap_i=false;
                            left_over_lap=0.5;
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
                          Checkbox(value: bool_left_over_lap_i, onChanged: (_) {
                            bool_left_over_lap_i=true;
                            bool_left_over_lap_h=false;
                            bool_left_over_lap_o=false;
                            left_over_lap=0;
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

                          Checkbox(value: bool_right_over_lap_o, onChanged: (_) {
                            bool_right_over_lap_o=true;
                            bool_right_over_lap_h=false;
                            bool_right_over_lap_i=false;
                            right_over_lap=1;
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
                          Checkbox(value: bool_right_over_lap_h, onChanged: (_) {
                            bool_right_over_lap_h=true;
                            bool_right_over_lap_o=false;
                            bool_right_over_lap_i=false;
                            right_over_lap=0.5;
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
                          Checkbox(value: bool_right_over_lap_i, onChanged: (_) {
                            bool_right_over_lap_i=true;
                            bool_right_over_lap_o=false;
                            bool_right_over_lap_h=false;
                            right_over_lap=0;
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
                    Checkbox(value: bool_down_over_lap_o, onChanged: (_) {
                      bool_down_over_lap_o=true;
                      bool_down_over_lap_i=false;
                      bool_down_over_lap_h=false;
                      down_over_lap=1;
                      setState(() {});

                    }),
                    Text('over'),
                    SizedBox(
                      width: 4,
                    ),
                    Checkbox(value: bool_down_over_lap_h, onChanged: (_) {
                      bool_down_over_lap_h=true;
                      bool_down_over_lap_o=false;
                      bool_down_over_lap_i=false;
                      down_over_lap=0.5;
                      setState(() {});

                    }),
                    Text('half'),
                    SizedBox(
                      width: 4,
                    ),
                    Checkbox(value: bool_down_over_lap_i, onChanged: (_) {
                      bool_down_over_lap_i=true;
                      bool_down_over_lap_o=false;
                      bool_down_over_lap_h=false;
                      down_over_lap=0;
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
            width: 200,
            height: 500,
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),

                Row(
                  children: [
                    Checkbox(value: single_door, onChanged: (_) {
                      single_door=!single_door;
                      setState(() {

                      });
                    }),
                    Text('Single Door'),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Checkbox(value: !single_door, onChanged: (_) {
                      single_door=!single_door;
                      setState(() {

                      });
                    }),
                    Text('Double Door'),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),

                //divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),

                Row(
                  children: [
                    Text('material      '),
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
                        controller: material_controller,
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
                  height: 12,
                ),
                Row(
                  children: [
                    Text('Round Gap '),
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
                        controller: round_gap_controller,
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
                //divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {

                       Door_Model door_model=Door_Model(single_door?1:2,
                           double.parse(material_controller.text.toString()),
                           double.parse(round_gap_controller.text.toString()),draw_controller.hover_id,
                           up_over_lap, right_over_lap, down_over_lap, left_over_lap);
                       draw_controller.add_door(door_model);
                       Navigator.of(Get.overlayContext!).pop();

                      },
                      child: Container(
                        width: 80,
                        height: 32,
                        child: Center(child: Text('ok')),
                        color: Colors.teal[200],
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(Get.overlayContext!).pop();
                      },
                      child: Container(
                        width: 80,
                        height: 32,
                        child: Center(child: Text('cancle')),
                        color: Colors.redAccent[100],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
