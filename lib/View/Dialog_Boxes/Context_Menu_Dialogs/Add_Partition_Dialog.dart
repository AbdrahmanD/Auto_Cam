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

  GlobalKey<FormState> my_key = GlobalKey();

  Draw_Controller drawerController = Get.find();

  bool quantity = true;
  bool partition_center = false;
  bool distance = true;
  bool proportional = false;
  bool edit_enable = true;

  left_changed() {
    double double_left_distance;
    if (distance) {
      if (Left_Distance.text.toString() != '') {
        double_left_distance = double.parse(Left_Distance.text.toString());
        Right_Distance.text =
        '${drawerController.box_repository.box_model.value.
        box_pieces[drawerController.hover_id].Piece_width
            - double_left_distance}';
      }
    } else if (proportional) {
      if (Left_Distance.text.toString() != '') {
        double_left_distance = double.parse(Left_Distance.text.toString());
        Right_Distance.text = '${(100 - double_left_distance).toInt()}';
      }
    }

    setState(() {});
  }

  right_changed() {
    double double_right_distance;
    if (distance) {
      if (Right_Distance.text.toString() != '') {
        double_right_distance = double.parse(Right_Distance.text.toString());
        Left_Distance.text = ''
            '${drawerController.box_repository.box_model.value.box_pieces[drawerController.hover_id].Piece_width
            - double_right_distance}';
      }
    } else if (proportional) {
      if (Right_Distance.text.toString() != '') {
        double_right_distance = double.parse(Right_Distance.text.toString());
        Left_Distance.text = '${(100 - double_right_distance).toInt()}';
      }
    }

    setState(() {});
  }

  add_partition() {
    if (my_key.currentState!.validate()) {
      if (!partition_center) {
        if (distance) {
          double left_Distence =
          quantity ? double.parse(Left_Distance.text.toString()) : 0;
          double frontage_Gap = double.parse(Front_Gap.text.toString());
          double material = double.parse(Material.text.toString());

          drawerController.add_partition(left_Distence, frontage_Gap, material,
              double.parse(Quantity.text.toString()).toInt());

        } else if (proportional) {
          double left_Distence =
              (double.parse(Left_Distance.text.toString()) / 100) *
                  (drawerController.box_repository.box_model.value
                      .box_pieces[drawerController.hover_id].Piece_width) -
                  double.parse(Material.text.toString()) / 2;

          double frontage_Gap = double.parse(Front_Gap.text.toString());
          double material = double.parse(Material.text.toString());

          drawerController.add_partition(left_Distence, frontage_Gap, material,
              double.parse(Quantity.text.toString()).toInt());

        }
      }
      ///if partation center
      else {
        double left_Distence = drawerController.box_repository.box_model.value
            .box_pieces[drawerController.hover_id].Piece_width /
            2 -
            double.parse(Material.text.toString()) / 2;

        double frontage_Gap = double.parse(Front_Gap.text.toString());
        double material = double.parse(Material.text.toString());

        drawerController.add_partition(left_Distence, frontage_Gap, material,
            double.parse(Quantity.text.toString()).toInt());

      }
    }
  }

  partition_center_change() {
    Quantity.text='1';
    Material.text='${drawerController.box_repository.box_model.
    value.init_material_thickness}';
    Front_Gap.text='24';
    if (!partition_center) {
      partition_center = true;
      distance = false;
      proportional = false;
      edit_enable = false;
      Left_Distance.text = '0';
      Right_Distance.text = '0';
    } else if (partition_center) {
      partition_center = false;
      distance = true;
      proportional = false;
      edit_enable = true;
    }
    setState(() {});
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
            key: my_key,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: Front_Gap,
                        validator: (v) {
                          if (!v!.isEmpty) {
                            double dv = double.parse(v.toString());
                            if (dv < 200) {
                              print('ok');
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                        width: 180,
                        child: Text(
                          'Center',
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
