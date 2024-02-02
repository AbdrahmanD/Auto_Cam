import 'dart:math';

import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
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
  TextEditingController material_name_controller = TextEditingController();

  TextEditingController up_gap_controller     = TextEditingController();
  TextEditingController right_gap_controller  = TextEditingController();
  TextEditingController down_gap_controller   = TextEditingController();
  TextEditingController left_gap_controller   = TextEditingController();
  TextEditingController center_gap_controller = TextEditingController();



  Draw_Controller draw_controller=Get.find();

  bool single_door=true;
  bool inner_door=false;

  bool right_door=true;
  bool left_door=false;
  bool fix_door=false;

  double up_gap       =1;
  double down_gap    =1;
  double left_gap   =1;
  double right_gap   =1;
  double center_gap  =2;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    material_controller.text="${draw_controller.box_repository.box_model.value.init_material_thickness}";

    up_gap_controller.text='1';
    right_gap_controller.text='1';
    down_gap_controller.text='1';
    left_gap_controller.text='1';
    center_gap_controller.text='1';
    material_name_controller.text='MDF';

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 540,
      height: 600,
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

                /// up
                Container(
                  child:
                  single_door?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('up  gap :  '),

                      /// text form field for up gap
                      Container(
                        width: 80,
                        height: 32,
                        child: TextFormField(
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          controller: up_gap_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),


                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ):

                  /// if double door show up gap and center gap
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('up gap:',style: TextStyle(fontSize: 12),),
                      SizedBox(
                        width: 4,
                      ),
                      /// text form field for up gap
                      Container(
                        width: 60,
                        height: 24,
                        child: TextFormField(
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          controller: up_gap_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 4,
                      ),

                      Text('center gap:',style: TextStyle(fontSize: 12),),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 64,
                        height: 24,
                        child: TextFormField(
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          controller: center_gap_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),



                    ],
                  ) ,
                ),
                SizedBox(
                  height: 12,
                ),
                /// left foto right
                Row(children: [
                 Column(
                    children: [
                      Text('left :  '),

                      Container(
                        width: 80,
                        height: 32,
                        child: TextFormField(
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          controller: left_gap_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
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

                      Container(
                        width: 80,
                        height: 32,
                        child: TextFormField(
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          controller: right_gap_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ]),

                ///down
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('down :  '),
                    Container(
                      width: 80,
                      height: 32,
                      child: TextFormField(
                        inputFormatters: [DecimalTextInputFormatter(2)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: down_gap_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),

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
            child: Column(
              children: [
                SizedBox(
                  height: 4,
                ),


                /// inner  door
                Row(
                  children: [
                    Checkbox(value: inner_door, onChanged: (_) {
                      inner_door=!inner_door;
                      setState(() {

                      });
                    }),
                    Text('Inner Door'),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),

                ///Single Door
                Row(
                  children: [
                    Checkbox(value: single_door, onChanged: (_) {
                      single_door=!single_door;
                      if(single_door){
                        right_door=true;
                        left_door=false;
                      }else{
                        right_door=true;
                        left_door=true;
                      }
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
                  height: 4,
                ),

                ///Double Door
                Row(
                  children: [
                    Checkbox(value: !single_door, onChanged: (_) {
                      single_door=!single_door;
                      if(!single_door){
                        right_door=true;
                        left_door=true;
                      }
                      setState(() {

                      });
                    }),
                    Text('Double Door'),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),

                ///Left Door
                Row(
                  children: [
                    Checkbox(value: left_door, onChanged: (_) {
                      left_door=!left_door;
                      right_door=!right_door;
                      setState(() {

                      });
                    }),
                    Text('Left Door'),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),

                ///Right Door
                Row(
                  children: [
                    Checkbox(value: right_door, onChanged: (_) {
                      right_door=!right_door;
                      left_door=!left_door;

                      setState(() {

                      });
                    }),
                    Text('Right Door'),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),

                ///fix Door
                Row(
                  children: [
                    Checkbox(value: fix_door, onChanged: (_) {
                      if(fix_door){
                        fix_door=false;
                        up_gap_controller.text='1';
                        right_gap_controller.text='1';
                        down_gap_controller.text='1';
                        left_gap_controller.text='1';
                        center_gap_controller.text='1';
                      }else{
                        fix_door=true;
                        up_gap_controller.text='0';
                        right_gap_controller.text='0';
                        down_gap_controller.text='0';
                        left_gap_controller.text='0';
                        center_gap_controller.text='0';
                      }

                      setState(() {

                      });
                    }),
                    Text('Fix Door'),
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
                    Text('material name'),
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
                        controller: material_name_controller,
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
                    Text('material          '),
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
                    Text('Round Gap     '),
                    SizedBox(
                      width: 12,
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
late String door_direction;
if(single_door){
  if(right_door)
    door_direction="R";
  else
    door_direction="L";
}else{
  door_direction="D";
}


up_gap=double.parse(up_gap_controller.text.toString());
down_gap=double.parse(down_gap_controller.text.toString());
left_gap=double.parse(left_gap_controller.text.toString());
right_gap=double.parse(right_gap_controller.text.toString());
center_gap=double.parse(center_gap_controller.text.toString());




                       Door_Model door_model=Door_Model(single_door?1:2,
                           double.parse(material_controller.text.toString()),
                           material_name_controller.text.toString(),
                           draw_controller.hover_id,
                           up_gap,
                           right_gap,
                           down_gap,
                           left_gap,
                           center_gap,
                         door_direction,
                         inner_door,
                         fix_door
                       );
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
