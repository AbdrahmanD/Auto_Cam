import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Add_back_panel_Dialog extends StatefulWidget {
  const Add_back_panel_Dialog({Key? key}) : super(key: key);

  @override
  State<Add_back_panel_Dialog> createState() => _Add_back_panel_DialogState();
}

class _Add_back_panel_DialogState extends State<Add_back_panel_Dialog> {
  Draw_Controller draw_controller = Get.find();

  TextEditingController back_panel_material_name = TextEditingController();
  TextEditingController back_panel_thickness = TextEditingController();
  TextEditingController back_panel_distance = TextEditingController();
  TextEditingController back_panel_groove_depth = TextEditingController();

  bool groove_bp = true;
  String back_panel_type = "groove";
late double initial_material_thickness;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    back_panel_material_name.text = "MDF 5m";
    back_panel_thickness.text = "5";
    back_panel_distance.text = "18";
    back_panel_groove_depth.text = "9";

    initial_material_thickness=draw_controller.box_repository.box_model.value.init_material_thickness;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        // height: 800,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// foto back panel type Groove  OR full cover
            Row(
              children: [

                /// groove
                InkWell(
                    onTap: () {
                      groove_bp = true;
                      back_panel_type="groove";
                      back_panel_thickness.text="5";
                      back_panel_material_name.text = "MDF 5m";

                      setState(() {});
                    },
                    child:
                        Container(
                          width: groove_bp ? 230 : 110,
                          height: groove_bp ? 260 : 160,
                           child:                         Image.asset("lib/assets/images/groove_back_panel.png")
                          ,
                        ),
                ),


                SizedBox(
                  width: 12,
                ),

                /// full cover
                InkWell(
                    onTap: () {
                      groove_bp = false;
                      back_panel_type="full_cover";
                      back_panel_thickness.text="$initial_material_thickness";
                      back_panel_material_name.text = draw_controller.box_repository.box_model.value.init_material_name;


                      setState(() {});
                    },
                    child:Container(
                          width: !groove_bp ? 230 : 110,
                          height: !groove_bp ? 260 : 160,
                       child:  Image.asset("lib/assets/images/full_cover_back_panel.png"),
                        ),
                       ),
              ],
            ),
            SizedBox(
              height: 62,
            ),

            ///back panel material name
            Row(
              children: [
                Container(
                  width: 250,
                  child: Text(
                    'back panel aterial name',
                  ),
                ),
                Container(
                  width: 120,
                  height: 40,
                  child: TextFormField(
                    inputFormatters: [DecimalTextInputFormatter(1)],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: back_panel_material_name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),

            ///back panel thickness
            Row(
              children: [
                Container(
                  width: 250,
                  child: Text(
                    'back panel thickness (TH) :',
                  ),
                ),
                Container(
                  width: 120,
                  height: 40,
                  child: TextFormField(
                    inputFormatters: [DecimalTextInputFormatter(1)],
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    controller: back_panel_thickness,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),


            ///back panel distance
            groove_bp
                ? Row(
                    children: [
                      Container(
                        width: 250,
                        child: Text(
                          'back panel Gap (B) :',
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 40,
                        child: TextFormField(
                          inputFormatters: [DecimalTextInputFormatter(1)],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          controller: back_panel_distance,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 40,
                  ),
            SizedBox(
              height: 12,
            ),

            ///back panel groove depth
            groove_bp
                ? Row(
                    children: [
                      Container(
                        width: 250,
                        child: Text(
                          'groove depth (D) :',
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 40,
                        child: TextFormField(
                          inputFormatters: [DecimalTextInputFormatter(1)],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          controller: back_panel_groove_depth,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 40,
                  ),

            SizedBox(
              height: 32,
            ),

            InkWell(
              onTap: () {
                double material_thickness = double.parse(back_panel_thickness.text.toString());
                double back_distance      = double.parse(back_panel_distance.text.toString());
                double groove_depth       = double.parse(back_panel_groove_depth.text.toString());

                String back_panel_material_name_value=back_panel_material_name.text.toString();

                draw_controller.add_back_banel(back_panel_type,back_panel_material_name_value,
                    material_thickness, back_distance, groove_depth);


                draw_controller.box_repository.pack_panel_grove_depth=groove_depth;
                draw_controller.box_repository.pack_panel_thickness=material_thickness;

                Navigator.of(Get.overlayContext!).pop();

              },
              child: Container(
                width: 150,
                height: 56,
                color: Colors.teal,
                child: Center(
                    child: Text(
                  "add backpanel",
                  style: TextStyle(fontSize: 16),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
