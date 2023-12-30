import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Excel_Controller.dart';
import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:auto_cam/Controller/nesting/Neting_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/View/Main_Screen.dart';
import 'package:auto_cam/project/Nesting_View.dart';
import 'package:auto_cam/View/Piece_List_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Setting_Box_Size_Form extends StatefulWidget {
  @override
  State<Setting_Box_Size_Form> createState() => _Setting_Box_Size_FormState();
}

class _Setting_Box_Size_FormState extends State<Setting_Box_Size_Form> {
  late Box_model box_model;

  bool is_back_panel = true;

  GlobalKey<FormState> form_key = GlobalKey();

  Draw_Controller draw_Controller = Get.find();

  TextEditingController box_name_controller = TextEditingController();
  TextEditingController width_controller = TextEditingController();

  TextEditingController hight_controller = TextEditingController();

  TextEditingController depth_controller = TextEditingController();

  TextEditingController material_thickness_controller = TextEditingController();
  TextEditingController material_name_controller = TextEditingController();

  TextEditingController back_panel_thickness_controller =
      TextEditingController();

  TextEditingController pack_panel_grove_depth_controller =
      TextEditingController();
  TextEditingController pack_panel_distence_controller =
      TextEditingController();
  TextEditingController top_base_piece_width_controller =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    box_model = draw_Controller.get_box();

    box_name_controller.text = "test box";
    width_controller.text = box_model.box_width.toString();
    hight_controller.text = box_model.box_height.toString();
    depth_controller.text = box_model.box_depth.toString();
    material_thickness_controller.text =
        box_model.init_material_thickness.toString();
    back_panel_thickness_controller.text =
        box_model.back_panel_thickness.toString();
    material_name_controller.text = 'MDF';
    pack_panel_grove_depth_controller.text =
        '${draw_Controller.box_repository.pack_panel_grove_depth}';
    pack_panel_distence_controller.text =
        '${draw_Controller.box_repository.pack_panel_distence}';
    top_base_piece_width_controller.text =
        '${draw_Controller.box_repository.top_base_piece_width}';
  }

  @override
  Widget build(BuildContext context) {

    Neting_Controller nesting_controller = Get.find();

    return Form(
      key: form_key,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 18,
          ),

          ///back button and lable
          Row(
            children: [
              //Back button
              Container(
                width: 50,
                child: InkWell(
                  child: Icon(
                    Icons.home,
                    size: 26,
                    color: Colors.teal,
                  ),
                  onTap: () {
                    Get.to(Main_Screen());
                  },
                ),
              ),
              //lable
              Container(
                width: 200,
                child: Center(
                  child: Text(
                    'setting up box size',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),

          //divider
          Container(
            height: 1,
            color: Colors.grey,
          ),

          SizedBox(
            height: 12,
          ),

          ///box name
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Text(' Box name  :'),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 140,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: box_name_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),

          ///width
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Text(' Box Width  :'),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: width_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),

          ///height
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                "Box Height :",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: hight_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),

          ///depth
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                "Box depth  : ",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                  width: 100,
                  height: 26,
                  child: TextFormField(
                    style: TextStyle(fontSize: 14),
                    controller: depth_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (d) {
                      if (d!.isEmpty) {
                        return 'please add value';
                      }
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  )),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),

          //divider
          Container(
            height: 1,
            color: Colors.grey,
          ),

          SizedBox(
            height: 12,
          ),

          SizedBox(
            width: 18,
          ),

          /// material title
          Center(
            child: Text(
              "Materials ",
              style: TextStyle(fontSize: 14),
            ),
          ),

          SizedBox(
            height: 14,
          ),

          ///material thickness form field
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                "thickness   :",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: material_thickness_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                  inputFormatters: [DecimalTextInputFormatter(1)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),

          SizedBox(
            height: 6,
          ),

          ///material name form field
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                " name         :",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: material_name_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),

          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 6,
          ),

          ///back Panel thickness form field
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                "Back Panel :",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: back_panel_thickness_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),

          ///pack_panel_grove_depth  form field
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                "grove depth:",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: pack_panel_grove_depth_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),

          ///pack_panel_distence_controller form field
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                "Back distence :",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: pack_panel_distence_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),

          ///top_base_piece_width_controller form field
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                "filler width :",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: top_base_piece_width_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),

          SizedBox(
            height: 12,
          ),

          //divider
          Container(
            height: 1,
            color: Colors.grey,
          ),

          /////////////////
          // Action part (buttons for : draw , export as excel , export as G_code .. )

          SizedBox(
            height: 6,
          ),

          ///chose or Edit fitting type
          // Container(
          //   child: Row(
          //     children: [
          //       SizedBox(width: 18),
          //       Container(
          //           width: 180,
          //           child: Text('chose or Edit fitting type',
          //               style: TextStyle(
          //                 fontSize: 14,
          //               ))),
          //       SizedBox(
          //         width: 18,
          //       ),
          //       InkWell(
          //           onTap: () {},
          //           child: Icon(
          //             Icons.draw,
          //             size: 36,
          //             color: Colors.teal,
          //           )),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 6,
          // ),
          //
          // ///divider
          // Container(
          //   height: 1,
          //   color: Colors.grey,
          // ),

          ///////////////////////
          SizedBox(
            height: 6,
          ),


          ///chose is there back panel or not
          Container(
            child: Row(
              children: [
                SizedBox(width: 18),
                Container(
                    width: 180,
                    child: Text('               with back panel ',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                Checkbox(
                    value: is_back_panel,
                    onChanged: (v) {
                      is_back_panel = !is_back_panel;
                      setState(() {});
                    })
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),

          //divider
          Container(
            height: 1,
            color: Colors.grey,
          ),
          ///////////////////////
          ///Draw in the Screen button
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 52, top: 18, bottom: 18),
            child: InkWell(
              onTap: () {
                if (form_key.currentState!.validate()) {
                  String box_name = box_name_controller.text.toString();
                  double width_value =
                      double.parse(width_controller.text.toString());
                  double hight_value =
                      double.parse(hight_controller.text.toString());
                  double depth_value =
                      double.parse(depth_controller.text.toString());
                  double material_thickness_value = double.parse(
                      material_thickness_controller.text.toString());
                  String material_name_value =
                      material_name_controller.text.toString();
                  double pack_panel_thickness_value = double.parse(
                      back_panel_thickness_controller.text.toString());

                  double pack_panel_grove_depth = double.parse(
                      pack_panel_grove_depth_controller.text.toString());
                  double pack_panel_distence = double.parse(
                      pack_panel_distence_controller.text.toString());
                  double top_base_piece_width = double.parse(
                      top_base_piece_width_controller.text.toString());

                  draw_Controller.box_repository.pack_panel_distence =
                      pack_panel_distence;
                  draw_Controller.box_repository.pack_panel_grove_depth =
                      pack_panel_grove_depth;
                  draw_Controller.box_repository.top_base_piece_width =
                      top_base_piece_width;
                  draw_Controller.box_repository.box_model.value
                      .init_material_thickness = material_thickness_value;

                  Box_model b = Box_model(
                      box_name,
                      draw_Controller.box_type,
                      width_value,
                      hight_value,
                      depth_value,
                      material_thickness_value,
                      material_name_value,
                      pack_panel_thickness_value,
                      pack_panel_grove_depth,
                      pack_panel_distence,
                      top_base_piece_width,
                      is_back_panel,
                      Point_model(0, 0, 0));

                  draw_Controller.add_Box(b);

                }
              },
              child: Container(
                width: 350,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: Text(
                  'Draw in the Screen',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
              ),
            ),
          ),
          ///////////////////////
          ///////////////////////

          Container(
            height: 1,
            color: Colors.grey,
          ),

          SizedBox(height: 12,),
          //review cut list
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 180,
                    child: Text('Review cut list  ',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {
                      draw_Controller.analyze();
                      Future.delayed(Duration(milliseconds: 1000))
                          .then((value) => Get.to(Piece_List_view(false)));
                    },
                    child: Icon(
                      Icons.list,
                      size: 36,
                      color: Colors.teal,
                    )),
              ],
            ),
          ),

          SizedBox(
            height: 12,
          ),

          ///preview Nesting sheets
          // Container(
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 18,
          //       ),
          //       Container(
          //           width: 180,
          //           child: Text('preview Nesting sheets',
          //               style: TextStyle(
          //                 fontSize: 14,
          //               ))),
          //       SizedBox(
          //         width: 18,
          //       ),
          //       InkWell(
          //           onTap: () {
          //
          //             nesting_controller.nesting_initilize();
          //             Get.to(Nesting_View());
          //
          //           },
          //           child: Icon(
          //             Icons.margin_outlined,
          //             size: 36,
          //             color: Colors.teal,
          //           )),
          //     ],
          //   ),
          // ),

          SizedBox(
            height: 12,
          ),

          ///save the box
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 180,
                    child: Text('Save cabinet',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {
                      draw_Controller.save_Box();
                    },
                    child: Icon(
                      Icons.save,
                      size: 36,
                      color: Colors.teal,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
