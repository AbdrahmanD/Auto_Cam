import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Excel_Controller.dart';
import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:auto_cam/Controller/nesting/Neting_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Cut_List_Item.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/View/Main_Screen.dart';
import 'package:auto_cam/View/Screens_parts/Box_Type.dart';
import 'package:auto_cam/View/Screens_parts/Cut_List_review.dart';
import 'package:auto_cam/View/Setting_Page.dart';
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

  Draw_Controller draw_controller = Get.find();

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
    box_name_controller.text=box_model.box_name.toString();
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
    is_back_panel=box_model.is_back_panel;
   }
  int text_size =12;


  @override
  Widget build(BuildContext context) {


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
                    'setting up box size and type',
                    style: TextStyle(fontSize: 14),
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
                width: 6,
              ),
              Container(width:60,child: Text('name : ')),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 132,
                // height: 32,
                child: TextFormField(
                  minLines: 1,maxLines: 3,
                  style: TextStyle(fontSize: 12),
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

          //divider
          Container(
            height: 1,
            color: Colors.grey,
          ),


          SizedBox(
            height: 6,
          ),

          ///width
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Container(width:60,child: Text('Width :',style: TextStyle(fontSize: 12),)),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 132,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),

          ///height
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Container(width: 60,
                child: Text(
                  "Height :" ,style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 132,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),

          ///depth
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Container(width: 60,
                child: Text(
                  "Depth  :",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                  width: 132,
                  height: 26,
                  child: TextFormField(
                    style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),

          //divider
          Container(
            height: 1,
            color: Colors.grey,
          ),

          SizedBox(
            height: 6,
          ),

          /// material title
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Center(
                child: Text(
                  "Materials ",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 6,
          ),

          ///material thickness form field
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Container(width: 60,
                child: Text(
                  "thickness:",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 132,
                height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
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
                width: 6,
              ),
              Container(width: 60,
                child: Text(
                  " name :",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 132,
                // height: 26,
                child: TextFormField(
                  style: TextStyle(fontSize: 12),
                  controller: material_name_controller,
maxLines: 3,      minLines: 1,            decoration: InputDecoration(
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
            height: 6,
          ),
          SizedBox(
            height: 6,
          ),


          Container(
            height: 1,
            color: Colors.grey,
          ),

          /////////////////
          // Action part (buttons for : draw , export as excel , export as G_code .. )

          SizedBox(
            height: 6,
          ),


          ///Draw in the Screen button
          Padding(
            padding: const EdgeInsets.all(24),
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

                 String nbn= draw_Controller.first_chart_every_word_with_random_num(box_name);

                  Box_model b = Box_model(
                      nbn,
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
                width: 532,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.red[500],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: Text(
                  'Draw in the Screen',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
              ),
            ),
          ),
          ///////////////////////
          ///////////////////////

          ///save the box
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                ),
                Container(
                    width: 100,
                    child: Text('Save Box',
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


          SizedBox(
            height: 12,
          ),

          Container(
            height: 1,
            color: Colors.grey,
          ),

          SizedBox(height: 16,),

          ///review boring drawing
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 120,
                    child: Text('Review drilling files ',
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
                      Icons.draw,
                      size: 36,
                      color: Colors.teal,
                    )),
              ],
            ),
          ),


          SizedBox(
            height: 12,
          ),


          ///review cut list
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 120,
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
                          .then((value) => Get.to(Cut_List_review()));
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




          ///print shop drawing
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 120,
                    child: Text('shop drawing',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {


                    },
                    child: Icon(
                      Icons.print,
                      size: 36,
                      color: Colors.teal,
                    )),
              ],
            ),
          ),



          SizedBox(
            height: 12,
          ),

          ///KD setting
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 120,
                    child: Text('KD setting',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {

                      Get.to(Setting_Page());

                    },
                    child: Icon(
                      Icons.settings,
                      size: 36,
                      color: Colors.teal,
                    )),
              ],
            ),
          ),


          SizedBox(
            height: 12,
          ),

          // /// list of all pieces
          // Container(height: 400,
          //   child: ListView.builder(
          //       itemCount: draw_controller
          //           .box_repository.box_model.value.box_pieces.length,
          //       itemBuilder: (context, i) {
          //         bool selected_piece=false;
          //         if(draw_controller.selected_pieces.value.contains(draw_controller
          //             .box_repository.box_model.value.box_pieces[i])){
          //           selected_piece=true;
          //         }
          //         if (
          //         !(draw_controller.box_repository.box_model.value.box_pieces[i].piece_name.contains('inner') ) &&
          //             !(draw_controller.box_repository.box_model.value.box_pieces[i].piece_name.contains('Helper')) &&
          //             (draw_controller.box_repository.box_model.value.box_pieces[i].piece_thickness!=0)
          //         ) {
          //           return Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(
          //               children: [
          //
          //                 /// name and select the piece and material name
          //                 Row(
          //                   children: [
          //                     Container(width: 12,height: 12,
          //                       child: Checkbox(value: selected_piece,
          //
          //
          //                           onChanged: (v){
          //
          //                             if(selected_piece){
          //                               draw_controller.selected_pieces.value.remove(
          //                                   draw_controller
          //                                       .box_repository.box_model.value.box_pieces[i]
          //                               );
          //                             }
          //                             else{
          //                               draw_controller.selected_pieces.value.add(
          //                                   draw_controller
          //                                       .box_repository.box_model.value.box_pieces[i]
          //                               );
          //
          //                             }
          //
          //
          //                             setState(() {
          //
          //                             });
          //                           }),
          //                     ),
          //                     SizedBox(width: 8,),
          //                     Text(
          //                       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_name}',
          //                       style: TextStyle(
          //                           fontSize: text_size*1.24,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       ' / ${draw_controller.box_repository.box_model.value.box_pieces[i].material_name}',
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //                   ],
          //                 ),
          //                 Container(
          //                   height: 0.5,
          //                   width: 100,
          //                   color: Colors.grey,
          //                 ),
          //
          //                 ///x y z
          //                 // Row(
          //                 //   children: [
          //                 //     Text(
          //                 //       'X :',
          //                 //       style: TextStyle(fontSize: text_size),
          //                 //     ),
          //                 //     Text(
          //                 //       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.x_coordinate}',
          //                 //       style: TextStyle(
          //                 //           fontSize: text_size,
          //                 //           fontWeight: FontWeight.bold),
          //                 //     ),
          //                 //   ],
          //                 // ),
          //                 // Row(
          //                 //   children: [
          //                 //     Text(
          //                 //       'Y :',
          //                 //       style: TextStyle(fontSize: text_size),
          //                 //     ),
          //                 //     Text(
          //                 //       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.y_coordinate}',
          //                 //       style: TextStyle(
          //                 //           fontSize: text_size,
          //                 //           fontWeight: FontWeight.bold),
          //                 //     ),
          //                 //   ],
          //                 // ),
          //                 // Row(
          //                 //   children: [
          //                 //     Text(
          //                 //       'Z :',
          //                 //       style: TextStyle(fontSize: text_size),
          //                 //     ),
          //                 //     Text(
          //                 //       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.z_coordinate}',
          //                 //       style: TextStyle(
          //                 //           fontSize: text_size,
          //                 //           fontWeight: FontWeight.bold),
          //                 //     ),
          //                 //   ],
          //                 // ),
          //
          //
          //
          //                 Container(
          //                   height: 0.5,
          //                   width: 100,
          //                   color: Colors.grey,
          //                 ),
          //                 Row(
          //                   children: [
          //                     Text(
          //                       'W :',
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //                     Text(
          //                       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_width}',
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //
          //                     Text(
          //                       ' / H :',
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //                     Text(
          //                       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_height}',
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //                     Text(
          //                       ' / TH :',
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //                     Text(
          //                       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_thickness}',
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //
          //
          //
          //                   ],
          //                 ),
          //
          //                 SizedBox(
          //                   height: 6,
          //                 ),
          //
          //                 // /// origin
          //                 // Row(
          //                 //   children: [
          //                 //     Text(
          //                 //       'origin :',
          //                 //       style: TextStyle(fontSize: text_size),
          //                 //     ),
          //                 //     Text(
          //                 //       'x=${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.x_coordinate}\n'
          //                 //           'y=${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.y_coordinate}\n'
          //                 //           'z=${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.z_coordinate}\n',
          //                 //       style: TextStyle(fontSize: text_size),
          //                 //     ),
          //                 //   ],
          //                 // ),
          //                 // SizedBox(
          //                 //   height: 6,
          //                 // ),
          //
          //
          //                 Divider(
          //                   height: 2,
          //                   color: Colors.black,
          //                 ),
          //
          //                 ///
          //
          //                 // Row(
          //                 //   children: [
          //                 //     Text(
          //                 //       'X${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.x_coordinate} \n, '
          //                 //           'Y:${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.y_coordinate} \n, '
          //                 //           'Z:${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.z_coordinate} \n',
          //                 //       style: TextStyle(fontSize: text_size),
          //                 //     ),
          //                 //   ],
          //                 // ),
          //                 // SizedBox(
          //                 //   height: 6,
          //                 // ),
          //                 // Divider(
          //                 //   height: 2,
          //                 //   color: Colors.black,
          //                 // ),
          //
          //
          //
          //               ],
          //             ),
          //           );
          //         } else {
          //           return SizedBox();
          //         }
          //       }),
          // )

        ],
      ),
    );
  }
}
