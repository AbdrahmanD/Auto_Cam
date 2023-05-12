import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/File_managing_Coltrollers/Excel_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/View/Main_Screen.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Setting_Box_Size_Form extends StatefulWidget {



  @override
  State<Setting_Box_Size_Form> createState() => _Setting_Box_Size_FormState();
}

class _Setting_Box_Size_FormState extends State<Setting_Box_Size_Form> {

  late Box_model box_model;


  GlobalKey<FormState> form_key = GlobalKey();

  Draw_Controller draw_Controller = Get.find();

  TextEditingController width_controller               =TextEditingController();

  TextEditingController hight_controller               =TextEditingController();

  TextEditingController depth_controller               =TextEditingController();

  TextEditingController material_thickness_controller  =TextEditingController();

  TextEditingController back_panel_thickness_controller=TextEditingController();

  @override
  Widget build(BuildContext context) {

    box_model=draw_Controller.get_box();


    width_controller.text=               box_model.box_width.toString();
    hight_controller.text=               box_model.box_height.toString();
    depth_controller.text=               box_model.box_depth.toString();
    material_thickness_controller.text=  box_model.init_material_thickness.toString();
    back_panel_thickness_controller.text=box_model.backpanel_thickness.toString();


    return Form(
      key: form_key,
      child: Column(
        children: [
          SizedBox(
            height: 18,
          ),       //back button and lable
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
                  child:
                  Text(
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
            height: 18,
          ),
          //width
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
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

          //height
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
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

          //depth
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
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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

          Text(
            "thickness :",
            style: TextStyle(fontSize: 14),
          ),

          SizedBox(
            height: 12,
          ),

          //material thickness form field
          Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Text(
                "Material      :",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                height: 26,
                child: TextFormField(
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
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

          SizedBox(
            height: 12,
          ),

          //back Panel thickness form field
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Text(
                "  mm",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),

          SizedBox(
            height: 16,
          ),

          //divider
          Container(
            height: 1,
            color: Colors.grey,
          ),

          /////////////////
          // Action part (buttons for : draw , export as excel , export as G_code .. )

          SizedBox(
            height: 12,
          ),

          //chose or Edit fitting type
          Container(
            child: Row(
              children: [
                SizedBox(width: 18),
                Container(
                    width: 180,
                    child: Text('chose or Edit fitting type',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {},
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

          //divider
          Container(
            height: 1,
            color: Colors.grey,
          ),

          ///////////////////////
          ///////////////////////
          ///Draw in the Screen button
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 52, top: 24, bottom: 24),
            child: InkWell(
              onTap: () {
                if(form_key.currentState!.validate()){

                  double  width_value=double.parse(width_controller.text.toString());
                  double  hight_value=double.parse(hight_controller.text.toString());
                  double  depth_value=double.parse(depth_controller.text.toString());
                  double  material_thickness_value=double.parse(material_thickness_controller  .text.toString());
                  double  pack_panel_thickness_value=double.parse(back_panel_thickness_controller.text.toString());


                  Box_model b=Box_model(width_value, hight_value, depth_value,
                      material_thickness_value, pack_panel_thickness_value);
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

          SizedBox(
            height: 56,
          ),

          //Export cut list as excel
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 180,
                    child: Text('Export cut list as excel ',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {

Excel_Controller excel=Excel_Controller();
// excel.create_sheet(draw_Controller.box_repository.box_model.value);
excel.createmyexcel();
                    },
                    child: Icon(
                      Icons.file_open_rounded,
                      size: 36,
                      color: Colors.teal,
                    )),
              ],
            ),
          ),

          SizedBox(
            height: 22,
          ),

          //Export Details sheets as PDF
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 180,
                    child: Text('Details sheets as   PDF ',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.picture_as_pdf,
                      size: 36,
                      color: Colors.teal,
                    )),
              ],
            ),
          ),

          SizedBox(
            height: 22,
          ),

          //preview Nesting sheets
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 180,
                    child: Text('preview Nesting sheets',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {
                      draw_Controller.print_pieces_coordinate();
                    },
                    child: Icon(
                      Icons.margin_outlined,
                      size: 36,
                      color: Colors.teal,
                    )),
              ],
            ),
          ),

          SizedBox(
            height: 22,
          ),

          //Export every piece \n  as G_code file
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                    width: 180,
                    child: Text('Export every piece \n  as G_code file',
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                SizedBox(
                  width: 18,
                ),
                InkWell(
                    onTap: () {
                      draw_Controller.box_repository.box_model.value.pieces_id;
                      print(                      draw_Controller.box_repository.box_model.value.pieces_id);
                    },
                    child: Icon(
                      Icons.code,
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
