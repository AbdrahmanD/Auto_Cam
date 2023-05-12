import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Add_Shelf_Dialog extends StatefulWidget {

  @override
  State<Add_Shelf_Dialog> createState() => _Add_Shelf_DialogState();
}

class _Add_Shelf_DialogState extends State<Add_Shelf_Dialog> {
  TextEditingController Quantity = TextEditingController();

  TextEditingController Front_Gap = TextEditingController();

  TextEditingController Material = TextEditingController();

  TextEditingController Top_Distance = TextEditingController();

  TextEditingController Bottom_Distance = TextEditingController();

  GlobalKey<FormState> my_key = GlobalKey();

  Draw_Controller drawerController = Get.find();

  bool quantity = true;
  bool shelf_center = false;
  bool distance = true;
  bool proportional = false;
  bool edit_enable = true;

  top_changed() {
    double double_top_distance;
    if (distance) {
      if (Top_Distance.text.toString() != '') {
        double_top_distance = double.parse(Top_Distance.text.toString());
        Bottom_Distance.text =
            '${drawerController.box_repository.box_model.value.box_pieces[drawerController.hover_id].Piece_height - double_top_distance}';
      }
    } else if (proportional) {
      if (Top_Distance.text.toString() != '') {
        double_top_distance = double.parse(Top_Distance.text.toString());
        Bottom_Distance.text = '${(100 - double_top_distance).toInt()}';
      }
    }

    setState(() {});
  }

  bottom_changed() {
    double double_bottom_distance;
    if (distance) {
      if (Bottom_Distance.text.toString() != '') {
        double_bottom_distance = double.parse(Bottom_Distance.text.toString());
        Top_Distance.text = ''
            '${drawerController.box_repository.box_model.value.box_pieces[drawerController.hover_id].Piece_height - double_bottom_distance}';
      }
    } else if (proportional) {
      if (Bottom_Distance.text.toString() != '') {
        double_bottom_distance = double.parse(Bottom_Distance.text.toString());
        Top_Distance.text = '${(100 - double_bottom_distance).toInt()}';
      }
    }

    setState(() {});
  }

  add_shelf() {
    if (my_key.currentState!.validate()) {
      if (!shelf_center) {
        if (distance) {
          double top_Distence =
              quantity ? double.parse(Top_Distance.text.toString()) : 0;
          double frontage_Gap = double.parse(Front_Gap.text.toString());
          double material = double.parse(Material.text.toString());
          drawerController.add_shelf(top_Distence, frontage_Gap, material,
              double.parse(Quantity.text.toString()).toInt());
        } else if (proportional) {
          double top_Distence =
              (double.parse(Top_Distance.text.toString()) / 100) *
                      (drawerController.box_repository.box_model.value
                          .box_pieces[drawerController.hover_id].Piece_height) -
                  double.parse(Material.text.toString()) / 2;
          double frontage_Gap = double.parse(Front_Gap.text.toString());
          double material = double.parse(Material.text.toString());
          drawerController.add_shelf(top_Distence, frontage_Gap, material,
              double.parse(Quantity.text.toString()).toInt());
        }
      } else {
        double top_Distence = drawerController.box_repository.box_model.value
                    .box_pieces[drawerController.hover_id].Piece_height /
                2 -
            double.parse(Material.text.toString()) / 2;
        double frontage_Gap = double.parse(Front_Gap.text.toString());
        double material = double.parse(Material.text.toString());
        drawerController.add_shelf(top_Distence, frontage_Gap, material,
            double.parse(Quantity.text.toString()).toInt());
      }
    }
  }

  shelf_center_change() {
    Quantity.text='1';
    Material.text='${drawerController.box_repository.box_model.value.init_material_thickness}';
    Front_Gap.text='24';
    if (!shelf_center) {
      shelf_center = true;
      distance = false;
      proportional = false;
      edit_enable = false;
      Top_Distance.text = '0';
      Bottom_Distance.text = '0';
    } else if (shelf_center) {
      shelf_center = false;
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
              child: Image.asset('lib/assets/images/shelfe.png'),
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
                      add_shelf();
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
                              Top_Distance.text = '0';
                              Bottom_Distance.text = '0';
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
                          value: shelf_center,
                          onChanged: (bool? value) {

                              shelf_center_change();

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
                              Top_Distance.text = '0';
                              Bottom_Distance.text = '0';
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
                              Top_Distance.text = '0';
                              Bottom_Distance.text = '0';
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
                        'Top',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        onChanged: (_) {
                          top_changed();
                        },
                        enabled: (quantity && edit_enable),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: Top_Distance,
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
                        'Down',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        onChanged: (_) {
                          bottom_changed();
                        },
                        enabled: (quantity && edit_enable),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: Bottom_Distance,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ), validator: (d) {if (d!.isEmpty) {return 'add value please';}},
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
