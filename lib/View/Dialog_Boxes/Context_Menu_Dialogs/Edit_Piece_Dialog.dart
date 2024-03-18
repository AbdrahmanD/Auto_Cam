
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit_Piece_Dialog extends StatefulWidget {
  const Edit_Piece_Dialog({Key? key}) : super(key: key);

  @override
  State<Edit_Piece_Dialog> createState() => _Edit_Piece_DialogState();
}

class _Edit_Piece_DialogState extends State<Edit_Piece_Dialog> {

  Draw_Controller draw_controller = Get.find();


  double x_move_value = 0;

  double y_move_value = 0;

  TextEditingController x_move = TextEditingController();

  TextEditingController y_move = TextEditingController();

  TextEditingController new_name = TextEditingController();

  TextEditingController new_width = TextEditingController();

  TextEditingController new_height = TextEditingController();

  TextEditingController new_thicknes = TextEditingController();

  TextEditingController new_material_name = TextEditingController();


  @override
  void initState() {
    x_move.text = '0';
    y_move.text = '0';

    new_name.text = '0';
    new_width.text = '0';
    new_height.text = '0';
    new_thicknes.text = '0';
    new_material_name.text = '0';



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(width: 300,height: 400,
      child: Column(
        children: [

          /// move the piece
          Text('Move'),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('X'),
              SizedBox(
                width: 6,
              ),
              Container(
                width: 65,
                height: 24,
                child: TextFormField(
                  style: TextStyle(fontSize: 12),
                  enabled: true,
                  keyboardType:
                  TextInputType.numberWithOptions(
                      decimal: true),
                  controller: x_move,
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
              SizedBox(
                width: 18,
              ),
              Text('Y'),
              SizedBox(
                width: 6,
              ),
              Container(
                width: 65,
                height: 24,
                child: TextFormField(
                  style: TextStyle(fontSize: 12),
                  enabled: true,
                  keyboardType:
                  TextInputType.numberWithOptions(
                      decimal: true),
                  controller: y_move,
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
            height: 8,
          ),
          InkWell(
            onTap: () {
              x_move_value = double.parse(
                  '${eval(x_move.text.toString())}');
              y_move_value = double.parse(
                  '${eval(y_move.text.toString())}');

              draw_controller.move_piece(
                  x_move_value, y_move_value);
              x_move_value = 0;
              y_move_value = 0;
              x_move.text = '0';
              y_move.text = '0';
            },
            child: Container(
              width: 70,
              height: 32,
              decoration: BoxDecoration(
                  color: Colors.teal[300],
                  borderRadius: BorderRadius.circular(4)),
              child: Center(child: Text('move')),
            ),
          ),

          SizedBox(
            height: 12,
          ),

          /// save or cancel button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();

                },
                child: Container(
                  width: 70,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.teal[300],
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(child: Text('cancel')),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  for (int i = 0;
                  i < draw_controller.selected_pieces.length;
                  i++) {
                    Piece_model p =  draw_controller.selected_pieces[i] ;

                    p.material_name =
                        new_material_name.text.toString();
                    p.piece_name = new_name.text.toString();
                    p.piece_width = double.parse(
                        '${eval(new_width.text.toString())}');
                    p.piece_height = double.parse(
                        '${eval(new_height.text.toString())}');
                    p.piece_thickness = double.parse(
                        '${eval(new_thicknes.text.toString())}');

                    Piece_model np = Piece_model(
                      p.piece_id,
                      p.piece_name,
                      p.piece_direction,
                      p.material_name,
                      p.piece_width,
                      p.piece_height,
                      p.piece_thickness,
                      p.piece_origin,
                    );

                    draw_controller.box_repository.box_model
                        .value.box_pieces
                        .remove(p);


                      draw_controller.box_repository.box_model
                          .value.box_pieces
                          .add(np);


                  }

                  draw_controller.selected_pieces.value = [];

                  Get.back();

                },
                child: Container(
                  width: 70,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.teal[300],
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(child: Text('Save')),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),


          ///delete the piece
          InkWell(
            onTap: () {
              draw_controller.delete_piece();
              Get.back();

            },
            child: Container(
              width: 150,
              height: 32,
              decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(4)),
              child: Center(child: Text('Delete the piece')),
            ),
          ),


          SizedBox(
            height: 12,
          ),



        ],
      ),

    );
  }
}
