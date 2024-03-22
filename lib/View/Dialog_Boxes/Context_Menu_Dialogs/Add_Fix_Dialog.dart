import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
 import 'package:auto_cam/Controller/Painters/Fix_panel_Painter.dart';
 import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Add_Fix_Dialog extends StatefulWidget {
  const Add_Fix_Dialog({Key? key}) : super(key: key);

  @override
  State<Add_Fix_Dialog> createState() => _Add_Fix_DialogState();
}

class _Add_Fix_DialogState extends State<Add_Fix_Dialog> {
  double fix_thickness_value = 0;
  String fix_material_name = '';

  int corner = 4;

  TextEditingController fix_material_name_controller = TextEditingController();
  TextEditingController filler_thickness_controller = TextEditingController();

  Draw_Controller draw_controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    filler_thickness_controller.text =
        "${draw_controller.box_repository.box_model.value.init_material_thickness}";
    fix_material_name_controller.text =
        draw_controller.box_repository.box_model.value.init_material_name;
  }

  @override
  Widget build(BuildContext context) {
    fix_thickness_value =
        double.parse(filler_thickness_controller.text.toString());

    Piece_model p = draw_controller.box_repository.box_model.value.box_pieces
        .where((element) => element.piece_name == "left")
        .first;

    // Filler_model f = Filler_model(vertical_filler,inside_filler,filler_width_value,
    //     100, filler_thickness_value, corner, x_move_value, y_move_value);
    //

    return Container(
      width: 400,
      height: 660,
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('left'),
              Checkbox(
                  value: (corner == 4) ? true : false,
                  onChanged: (v) {
                    corner = 4;
                    setState(() {});
                  }),
              SizedBox(
                width: 12,
              ),
              Text('right'),
              Checkbox(
                  value: (corner == 2) ? true : false,
                  onChanged: (v) {
                    corner = 2;
                    setState(() {});
                  }),
              SizedBox(
                width: 12,
              ),
              Text('top'),
              Checkbox(
                  value: (corner == 1) ? true : false,
                  onChanged: (v) {
                    corner = 1;
                    setState(() {});
                  }),
              SizedBox(
                width: 12,
              ),
              Text('douwn'),
              Checkbox(
                  value: (corner == 3) ? true : false,
                  onChanged: (v) {
                    corner = 3;
                    setState(() {});
                  }),
              SizedBox(
                width: 12,
              ),
            ],
          ),

          SizedBox(
            height: 12,
          ),

          /// painter
          Container(
            width: 300,
            height: 260,
            color: Colors.grey[200],
            child: CustomPaint(
              painter: Fix_Panel_Painter(
                  fix_thickness_value,
                  corner,
                  draw_controller.box_repository.box_model.value.box_width,
                  draw_controller.box_repository.box_model.value.box_height),
            ),
          ),

          SizedBox(
            height: 18,
          ),

          /// Fix material name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fix material name'),
              SizedBox(
                width: 6,
              ),
              Container(
                width: 80,
                height: 32,
                child: TextFormField(
                  onChanged: (_) {
                   },
                  enabled: true,
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: fix_material_name_controller,
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
            height: 18,
          ),

          /// Fix thickness
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fix thickness'),
              SizedBox(
                width: 6,
              ),

              /// thickness form field
              Container(
                width: 80,
                height: 32,
                child: TextFormField(
                  onChanged: (_) {

                  },
                  enabled: true,
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: filler_thickness_controller,
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
            height: 24,
          ),

          /// add bottom
          InkWell(
              onTap: () {

                fix_material_name =
                    fix_material_name_controller.text.toString();
                fix_thickness_value = double.parse(
                    filler_thickness_controller.text.toString());

                draw_controller.add_fix_panel(
                    fix_thickness_value, fix_material_name, corner);

                Navigator.of(Get.overlayContext!).pop();
              },
              child: Container(
                width: 132,
                height: 32,
                decoration: BoxDecoration(
                    color: Colors.teal[500],
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                    child: Text(
                  'Add Fix panel',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
              ))
        ],
      ),
    );
  }
}
