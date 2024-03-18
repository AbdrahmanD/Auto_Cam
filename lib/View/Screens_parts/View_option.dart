import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:dart_eval/dart_eval.dart';

class View_option extends StatefulWidget {

  @override
  State<View_option> createState() => _View_optionState();
}

class _View_optionState extends State<View_option> {
  Draw_Controller draw_controller = Get.find();

  double text_size = 12;

  double selected_text_size = 14;

  double w0 = 50;

  double w1 = 70;

  double h0 = 32;

  double h1 = 50;

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
  Widget build(BuildContext context) {
    x_move.text = '0';
    y_move.text = '0';

    new_name.text = '0';
    new_width.text = '0';
    new_height.text = '0';
    new_thicknes.text = '0';
    new_material_name.text = '0';



    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        width: 250,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),

            /// choos 3d or 2d , right top front
            Obx(
              () => Column(
                children: [
                  /// choos 3d or 2d
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// change view to : 2D
                      InkWell(
                        onTap: () {
                          draw_controller.draw_3_D.value = false;
                        },
                        child: Container(
                          width: (!draw_controller.draw_3_D.value) ? 75 : 32,
                          height: (!draw_controller.draw_3_D.value) ? 50 : 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                (draw_controller.draw_3_D.value) ? 0 : 6),
                            color: Colors.teal[300],
                          ),
                          child: Center(
                              child: Text(
                            '2D',
                            style: TextStyle(
                                fontSize:
                                    (!draw_controller.draw_3_D.value) ? 18 : 12,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),

                      SizedBox(
                        width: 24,
                      ),

                      /// change view to : 3D
                      InkWell(
                        onTap: () {
                          draw_controller.draw_3_D.value = true;
                        },
                        child: Container(
                            width: (draw_controller.draw_3_D.value) ? 75 : 32,
                            height: (draw_controller.draw_3_D.value) ? 50 : 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  (!draw_controller.draw_3_D.value) ? 0 : 6),
                              color: Colors.teal[300],
                            ),
                            child: Center(
                                child: Text(
                              '3D',
                              style: TextStyle(
                                  fontSize: (draw_controller.draw_3_D.value)
                                      ? 18
                                      : 12,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                    ],
                  ),

                  /// divider
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Divider(
                      height: 2,
                    ),
                  ),

                  /// choos  right top front
                  (!draw_controller.draw_3_D.value)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// change view to : front
                            InkWell(
                              onTap: () {
                                draw_controller.view_port.value = 'F';
                              },
                              child: Container(
                                width: (draw_controller.view_port.value == 'F')
                                    ? w1
                                    : w0,
                                height: (draw_controller.view_port.value == 'F')
                                    ? h1
                                    : h0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (draw_controller.view_port.value == 'F')
                                          ? 4
                                          : 0),
                                  color:
                                      (draw_controller.view_port.value == 'F')
                                          ? Colors.teal[300]
                                          : Colors.grey[400],
                                ),
                                child: Center(
                                    child: Text(
                                  'Front',
                                  style: TextStyle(
                                    fontSize:
                                        (draw_controller.view_port.value == 'F')
                                            ? 16
                                            : 12,
                                  ),
                                )),
                              ),
                            ),

                            SizedBox(
                              width: 6,
                            ),

                            /// change view to : top
                            InkWell(
                              onTap: () {
                                draw_controller.view_port.value = 'T';
                              },
                              child: Container(
                                width: (draw_controller.view_port.value == 'T')
                                    ? w1
                                    : w0,
                                height: (draw_controller.view_port.value == 'T')
                                    ? h1
                                    : h0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (draw_controller.view_port.value == 'T')
                                          ? 4
                                          : 0),
                                  color:
                                      (draw_controller.view_port.value == 'T')
                                          ? Colors.teal[300]
                                          : Colors.grey[400],
                                ),
                                child: Center(
                                    child: Text(
                                  'Top',
                                  style: TextStyle(
                                    fontSize:
                                        (draw_controller.view_port.value == 'T')
                                            ? 16
                                            : 12,
                                  ),
                                )),
                              ),
                            ),

                            SizedBox(
                              width: 6,
                            ),

                            /// change view to : right
                            InkWell(
                              onTap: () {
                                draw_controller.view_port.value = 'R';
                              },
                              child: Container(
                                width: (draw_controller.view_port.value == 'R')
                                    ? w1
                                    : w0,
                                height: (draw_controller.view_port.value == 'R')
                                    ? h1
                                    : h0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (draw_controller.view_port.value == 'R')
                                          ? 4
                                          : 0),
                                  color:
                                      (draw_controller.view_port.value == 'R')
                                          ? Colors.teal[300]
                                          : Colors.grey[400],
                                ),
                                child: Center(
                                    child: Text(
                                  'Right',
                                  style: TextStyle(
                                    fontSize:
                                        (draw_controller.view_port.value == 'R')
                                            ? 16
                                            : 12,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),

                  SizedBox(height: 12,),

                  /// zoom all
                  InkWell(
                    onTap: () {

                      draw_controller.draw_3_D.value ?(draw_controller.drawing_scale.value = 1):
                      draw_controller.zoom_all();
                      setState(() {

                      });
                    },
                    child: Container(
                      width: 112,
                      height:24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            (draw_controller.view_port.value == 'F')
                                ? 4
                                : 0),
                        color:Colors.grey[400],
                      ),
                      child: Center(
                        child: Text(
                                "ZOOM ALL",
                                style: TextStyle(
                                  fontSize:14,
                                ),
                              ),
                      )


                    ),
                  ),
                ],
              ),
            ),

            /// divider
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Divider(
                height: 2,
              ),
            ),

            /// box pieces table
            Obx(
                  () => Container(
                  width: 250,
                  // height: 596,
                  child: Column(
                    children: [
                      /// selected piece
                      (draw_controller.selected_pieces.value.length!= 0 && draw_controller.selected_faces.length == 0)
                          ?

                        ///selected piece
                        Column(
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
                                  onTap: () {},
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

                                      if(p.piece_name.contains("Door")){
                                        draw_controller.add_door(Door_Model(1, p.piece_thickness,
                                            p.material_name, draw_controller.selected_pieces[i], 0, 0, 0, 0, 0, "R",false,false
                                        ));
                                      }else{
                                        draw_controller.box_repository.box_model
                                            .value.box_pieces
                                            .add(np);
                                      }

                                    }

                                    draw_controller.selected_pieces.value = [];
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
                        ):SizedBox(),




                      (draw_controller.selected_faces.length != 0)?
                      ///selected face
                      Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),

                          /// move the face
                          Text('Move the face'),
                          SizedBox(
                            height: 16,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Container(
                                width: 100,
                                height: 50,
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


                            ],
                          ),

                          SizedBox(
                            height: 16,
                          ),

                          ///  move the face
                          InkWell(
                            onTap: () {
                              x_move_value = double.parse('${eval(x_move.text.toString())}');

                              draw_controller.move_face(x_move_value);

                              x_move_value = 0;
                              // x_move.text = '0';
                            },

                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.teal[300],
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(child: Text('move')),
                            ),
                          ),

                          Text("select piece :\n ${draw_controller.selected_faces[0].piece_id} "),
                          Text("face_name :\n ${draw_controller.selected_faces[0].face_name} "),


                        ],
                      ):SizedBox(),

                      /// list of all pieces
                      Container(height: 400,
                        child: ListView.builder(
                            itemCount: draw_controller
                                .box_repository.box_model.value.box_pieces.length,
                            itemBuilder: (context, i) {
                              bool selected_piece=false;
                              if(draw_controller.selected_pieces.value.contains(draw_controller
                                  .box_repository.box_model.value.box_pieces[i])){
                                selected_piece=true;
                              }
                              if (
                              !(draw_controller.box_repository.box_model.value.box_pieces[i].piece_name.contains('inner') ) &&
                              !(draw_controller.box_repository.box_model.value.box_pieces[i].piece_name.contains('Helper')) &&
                              (draw_controller.box_repository.box_model.value.box_pieces[i].piece_thickness!=0)
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [

                                      /// name and select the piece and material name
                                      Row(
                                        children: [
                                          Container(width: 12,height: 12,
                                            child: Checkbox(value: selected_piece,


                                                 onChanged: (v){

                                                   if(selected_piece){
                                                     draw_controller.selected_pieces.value.remove(
                                                         draw_controller
                                                             .box_repository.box_model.value.box_pieces[i]
                                                     );
                                                   }
                                                   else{
                                                     draw_controller.selected_pieces.value.add(
                                                         draw_controller
                                                             .box_repository.box_model.value.box_pieces[i]
                                                     );

                                                   }


                                              setState(() {

                                              });
                                            }),
                                          ),
                                          SizedBox(width: 8,),
                                          Text(
                                            '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_name}',
                                            style: TextStyle(
                                                fontSize: text_size*1.24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            ' / ${draw_controller.box_repository.box_model.value.box_pieces[i].material_name}',
                                            style: TextStyle(fontSize: text_size),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 0.5,
                                        width: 100,
                                        color: Colors.grey,
                                      ),

                                      ///x y z
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'X :',
                                      //       style: TextStyle(fontSize: text_size),
                                      //     ),
                                      //     Text(
                                      //       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.x_coordinate}',
                                      //       style: TextStyle(
                                      //           fontSize: text_size,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //   ],
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'Y :',
                                      //       style: TextStyle(fontSize: text_size),
                                      //     ),
                                      //     Text(
                                      //       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.y_coordinate}',
                                      //       style: TextStyle(
                                      //           fontSize: text_size,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //   ],
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'Z :',
                                      //       style: TextStyle(fontSize: text_size),
                                      //     ),
                                      //     Text(
                                      //       '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.z_coordinate}',
                                      //       style: TextStyle(
                                      //           fontSize: text_size,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //   ],
                                      // ),



                                      Container(
                                        height: 0.5,
                                        width: 100,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'W :',
                                            style: TextStyle(fontSize: text_size),
                                          ),
                                          Text(
                                            '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_width}',
                                            style: TextStyle(fontSize: text_size),
                                          ),

                                          Text(
                                            ' / H :',
                                            style: TextStyle(fontSize: text_size),
                                          ),
                                          Text(
                                            '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_height}',
                                            style: TextStyle(fontSize: text_size),
                                          ),
                                          Text(
                                            ' / TH :',
                                            style: TextStyle(fontSize: text_size),
                                          ),
                                          Text(
                                            '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_thickness}',
                                            style: TextStyle(fontSize: text_size),
                                          ),



                                        ],
                                      ),

                                      SizedBox(
                                        height: 6,
                                      ),

                                      // /// origin
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'origin :',
                                      //       style: TextStyle(fontSize: text_size),
                                      //     ),
                                      //     Text(
                                      //       'x=${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.x_coordinate}\n'
                                      //           'y=${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.y_coordinate}\n'
                                      //           'z=${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.z_coordinate}\n',
                                      //       style: TextStyle(fontSize: text_size),
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 6,
                                      // ),


                                      Divider(
                                        height: 2,
                                        color: Colors.black,
                                      ),

                                      ///

                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'X${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.x_coordinate} \n, '
                                      //           'Y:${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.y_coordinate} \n, '
                                      //           'Z:${draw_controller.box_repository.box_model.value.box_pieces[i].piece_origin.z_coordinate} \n',
                                      //       style: TextStyle(fontSize: text_size),
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 6,
                                      // ),
                                      // Divider(
                                      //   height: 2,
                                      //   color: Colors.black,
                                      // ),



                                    ],
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                      )
                    ],




              ),)
            ),

          ],
        ),
      ),
    );
  }
}
