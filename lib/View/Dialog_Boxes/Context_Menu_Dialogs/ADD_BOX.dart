import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Inner_Box.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ADD_BOX extends StatefulWidget {
  const ADD_BOX({Key? key}) : super(key: key);

  @override
  State<ADD_BOX> createState() => _ADD_BOXState();
}

class _ADD_BOXState extends State<ADD_BOX> {

  TextEditingController width_controller = TextEditingController();
  TextEditingController hight_controller = TextEditingController();
  TextEditingController depth_controller = TextEditingController();

  TextEditingController material_thickness_controller = TextEditingController();
  TextEditingController material_name_controller      = TextEditingController();
  TextEditingController box_type_controller           = TextEditingController();

  GlobalKey<FormState> form_key = GlobalKey();



  Draw_Controller draw_Controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Piece_model inner=draw_Controller.box_repository.box_model.value.box_pieces[draw_Controller.hover_id];

    width_controller.text="${inner.piece_width}";
    hight_controller.text="${inner.piece_height}";
    depth_controller.text="${draw_Controller.box_repository.box_model.value.box_depth}";
    material_thickness_controller.text="18";
    material_name_controller.text="MDF";
    box_type_controller.text="full_top";


  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 400,height:600,
      child: Form( key: form_key,
        child: ListView(
          children: [

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


            ///box_type
            Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Text(
                  " box type         :",
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
                    controller: box_type_controller,
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


            ///Draw in the Screen button
            Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 52, top: 18, bottom: 18),
              child: InkWell(
                onTap: () {
                  if (form_key.currentState!.validate()) {
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

                    String box_type = box_type_controller.text.toString();



                    Inner_Box b = Inner_Box(


                        width_value,
                        hight_value,
                        depth_value,
                        material_thickness_value,
                        material_name_value,
                        box_type
                    );

                    draw_Controller.add_box_inside_inner(b);

                    Navigator.of(Get.overlayContext!).pop();


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
          ],
        ),
      ),

    );
  }
}
