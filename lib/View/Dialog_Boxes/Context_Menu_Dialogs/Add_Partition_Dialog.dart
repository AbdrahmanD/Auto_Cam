import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class Add_Partition_Dialog extends StatefulWidget {
  const Add_Partition_Dialog({Key? key}) : super(key: key);

  @override
  State<Add_Partition_Dialog> createState() => _Add_Partition_DialogState();
}

class _Add_Partition_DialogState extends State<Add_Partition_Dialog> {
  TextEditingController Quantity = TextEditingController();

  TextEditingController Front_Gap = TextEditingController();

  TextEditingController Material = TextEditingController();

  TextEditingController Left_Distance = TextEditingController();

  TextEditingController Right_Distance = TextEditingController();

  GlobalKey<FormState> add_partition_dialog_key = GlobalKey();

  Draw_Controller draw_Controller = Get.find();

  bool quantity = true;
  bool partition_center = true;
  bool distance = false;

  bool help_partition = false;

  bool proportional = false;
  bool edit_enable = true;

 late  double back_distance;
 late  double partation_material_thickness;

 late  double final_left_distance;
 late  double final_right_distance;


  help_partition_change(){

    if (!help_partition) {
      help_partition=true;
      partation_material_thickness=0;
    }else{
      help_partition=false;
    }

    setState(() {

    });
  }

  left_changed() {
    if (distance) {
      if (Left_Distance.text.toString() != '') {
        double  double_left_distance_0 = double.parse(Left_Distance.text.toString());
        final_left_distance=double.parse(double_left_distance_0.toStringAsFixed(2));

        double right_distance=draw_Controller.box_repository.box_model.value.
        box_pieces[draw_Controller.hover_id].piece_width
            - final_left_distance-partation_material_thickness;

        Right_Distance.text ='${double.parse(right_distance.toStringAsFixed(2))}';
        // '${}';
      }
    } else if (proportional) {
      if (Left_Distance.text.toString() != '') {
        final_left_distance = double.parse(Left_Distance.text.toString());
        Right_Distance.text = '${(100 - final_left_distance).toInt()}';
      }
    }


    setState(() {});
  }

  right_changed() {

     if (distance) {
      if (Right_Distance.text.toString() != '') {
      double  double_right_distance_0 = double.parse(Right_Distance.text.toString())+partation_material_thickness;
      final_right_distance=double.parse(double_right_distance_0.toStringAsFixed(2));
       double d_Left_Distance_0 =draw_Controller.box_repository.box_model.value.box_pieces[draw_Controller.hover_id].piece_width
            - final_right_distance;
       double d_Left_Distance=double.parse(d_Left_Distance_0.toStringAsFixed(2));
       Left_Distance.text='${double.parse(d_Left_Distance.toStringAsFixed(2))}';
      }
    } else if (proportional) {
      if (Right_Distance.text.toString() != '') {
        final_right_distance = double.parse(Right_Distance.text.toString());
        Left_Distance.text = '${(100 - final_right_distance).toInt()}';
      }
    }

    setState(() {});
  }

  add_partition() {

    back_distance=draw_Controller.box_repository.pack_panel_distence;

    double frontage_Gap = double.parse(Front_Gap.text.toString());
    double material = !help_partition?(double.parse((double.parse(Material.text.toString())).toStringAsFixed(2))):0;

    if (add_partition_dialog_key.currentState!.validate()) {

      if (quantity) {

        if (!partition_center) {

          double  double_left_distance_0 = double.parse(Left_Distance.text.toString());
          final_left_distance=double.parse(double_left_distance_0.toStringAsFixed(2));

          if (distance) {

             draw_Controller.add_partition(final_left_distance, frontage_Gap, material,1,back_distance,help_partition);

          } else if (proportional) {
            double left_Distence =
                (final_left_distance / 100) *
                    (draw_Controller.box_repository.box_model.value
                        .box_pieces[draw_Controller.hover_id].piece_width) -
                    material / 2;

            draw_Controller.add_partition(left_Distence, frontage_Gap, material,1,back_distance,help_partition);

          }
        }
        ///if partation center
        else {
          double left_Distence = draw_Controller.box_repository.box_model.value
              .box_pieces[draw_Controller.hover_id].piece_width /
              2 - material/ 2;

          draw_Controller.add_partition(left_Distence, frontage_Gap, material,1,back_distance,help_partition);

        }
      }
      else{
        draw_Controller.add_partition(0, frontage_Gap, material,
            double.parse(Quantity.text.toString()).toInt(),back_distance,help_partition);

      }
    }
    setState(() {

    });
  }

  partition_center_change() {

    if (!partition_center) {
      partition_center = true;
      distance = false;
      proportional = false;
      edit_enable = false;
      Quantity.text='1';
      Left_Distance.text = '0';
      Right_Distance.text = '0';
    }
    else if (partition_center) {
      partition_center = false;
      distance = true;
      proportional = false;
      edit_enable = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    partation_material_thickness=draw_Controller.box_repository.box_model.value.init_material_thickness;


    Quantity.text='1';
    Material.text='$partation_material_thickness';
    Front_Gap.text='0';

    partition_center = true;
    distance = false;
    proportional = false;
    edit_enable = false;
    double d_Left_Distance = draw_Controller.box_repository.box_model.value.
    box_pieces[draw_Controller.hover_id].piece_width-partation_material_thickness;

    Left_Distance.text='${double.parse(d_Left_Distance.toStringAsFixed(2))}';
    Right_Distance.text = '0';


  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// foto , ok and cancel button
        Column(
          children: [
            /// foto
            Container(
              width: 200,
              height: 300,
              child: Image.asset('lib/assets/images/partition.png'),
            ),
            SizedBox(
              height: 12,
            ),

            ///ok and cancel button
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      add_partition();
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
              ),
            ),
          ],
        ),

        SizedBox(
          width: 24,
        ),

        /// all details fields
        Container(
          child: Form(
            key: add_partition_dialog_key,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'Quantity',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: Quantity,
                        onChanged: (_) {
                          if (Quantity.text != '') {
                            if (double.parse(Quantity.text.toString()).toInt() >
                                1) {
                              quantity = false;
                              partition_center=false;
                              Left_Distance.text = '0';
                              Right_Distance.text = '0';
                              setState(() {});
                            } else {
                              quantity = true;
                              setState(() {});
                            }
                          }
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
                    Container(width: 45, child: Text('  mm'))
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'Front Gap',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [DecimalTextInputFormatter(1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: Front_Gap,
                        validator: (v) {
                          if (!v!.isEmpty) {
                            double dv = double.parse(v.toString());
                            if (dv <= (draw_Controller.box_repository.box_model.value.box_depth-100-24)) {

                            } else {
                              return 'the Gap big';
                            }
                          } else {
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
                    Container(width: 45, child: Text('  mm'))
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'thickness',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [DecimalTextInputFormatter(1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: Material,
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
                    Container(width: 45, child: Text('  mm'))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 270,
                    child: Container(
                      color: Colors.grey,
                      child: Text(' '),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        width: 40,
                        child: Checkbox(
                          value: partition_center,
                          onChanged: (bool? value) {
                              partition_center_change();

                          },
                        )),
                    Container(
                        width: 90,
                        child: Text(
                          'Center',
                        )),
                    SizedBox(width: 12,),
                    Container(
                        width: 40,
                        child: Checkbox(
                          value: help_partition,
                          onChanged: (bool? value) {

                            help_partition_change();

                          },
                        )),
                    Container(
                        width: 120,
                        child: Text(
                          'Help partition',
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 270,
                    child: Container(
                      color: Colors.grey,
                      child: Text(' '),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        width: 30,
                        child: Checkbox(
                          value: distance,
                          onChanged: (bool? value) {
                            if (edit_enable) {
                              distance = !distance;
                              proportional = !proportional;
                              Left_Distance.text = '0';
                              Right_Distance.text = '0';
                              setState(() {});
                            }
                          },
                        )),
                    Container(
                        width: 80,
                        child: Text(
                          'Distence',
                        )),
                    Container(
                        width: 30,
                        child: Checkbox(
                          value: proportional,
                          onChanged: (bool? value) {
                            if (edit_enable) {
                              distance = !distance;
                              proportional = !proportional;
                              Left_Distance.text = '0';
                              Right_Distance.text = '0';
                              setState(() {});
                            }
                          },
                        )),
                    Container(
                        width: 100,
                        child: Text(
                          'Proportional',
                        )),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'Left',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        onChanged: (_) {
                          left_changed();
                        },
                        enabled: (quantity && edit_enable),
                        inputFormatters: [DecimalTextInputFormatter(1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: Left_Distance,
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
                    Container(width: 45, child: Text(distance ? '  mm' : '  %'))
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'Right',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        onChanged: (_) {
                          right_changed();
                        },
                        enabled: (quantity && edit_enable),
                        inputFormatters: [DecimalTextInputFormatter(1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: Right_Distance,
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
                    Container(width: 45, child: Text(distance ? '  mm' : '  %'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
