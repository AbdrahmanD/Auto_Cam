import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:dart_eval/dart_eval.dart';

class View_option extends StatelessWidget {
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
        width: 300,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 24,
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
                ],
              ),
            ),

            /// divider
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Divider(
                height: 2,
              ),
            ),

            /// box or piece table
            Obx(
              () => Container(
                width: 200,
                height: 650,
                child: (draw_controller.selected_id.value.length == 0)
                    ?

                    /// list of all pieces
                    ListView.builder(
                        itemCount: draw_controller
                            .box_repository.box_model.value.box_pieces.length,
                        itemBuilder: (context, i) {
                          if (true
                              // draw_controller.box_repository.box_model.value.box_pieces[i].piece_name != 'inner'
                              ) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'id :',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                      Text(
                                        '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_id}',
                                        style: TextStyle(
                                            fontSize: text_size,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: 100,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'name :',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                      Text(
                                        '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_name}',
                                        style: TextStyle(
                                            fontSize: text_size,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: 100,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'width :',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                      Text(
                                        '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_width}',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: 100,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'height :',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                      Text(
                                        '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_height}',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: 100,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'thickness :',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                      Text(
                                        '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_thickness}',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: 100,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'material :',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                      Text(
                                        '${draw_controller.box_repository.box_model.value.box_pieces[i].material_name}',
                                        style: TextStyle(fontSize: text_size),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        })
                    :

                    /// selected piece
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 18,
                            ),

                            /// selected pieces listview builder
                            Container(
                              height: 300,
                              child: ListView.builder(
                                  itemCount: draw_controller.selected_id.length,
                                  itemBuilder: (context, i) {
                                    Piece_model p = draw_controller
                                            .box_repository
                                            .box_model
                                            .value
                                            .box_pieces[
                                        draw_controller.selected_id[i]];

                                    new_name.text = p.piece_name;
                                    new_width.text = ' ${p.piece_width}';
                                    new_height.text = ' ${p.piece_height}';
                                    new_thicknes.text = ' ${p.piece_thickness}';
                                    new_material_name.text = p.material_name;

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'ID :',
                                                style: TextStyle(
                                                    fontSize: text_size),
                                              ),
                                              Text(
                                                '${p.piece_id}',
                                                style: TextStyle(
                                                    fontSize: text_size),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 0.5,
                                            width: 100,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'name :',
                                                style: TextStyle(
                                                    fontSize: text_size),
                                              ),
                                              (draw_controller.selected_id.value
                                                          .length <
                                                      2)
                                                  ? Container(
                                                      width: 80,
                                                      height: 24,
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        enabled: true,
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        controller: new_name,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        validator: (d) {
                                                          if (d!.isEmpty) {
                                                            return 'add value please';
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  : Text(
                                                      '${p.piece_name}',
                                                      style: TextStyle(
                                                          fontSize: text_size),
                                                    ),
                                            ],
                                          ),
                                          Container(
                                            height: 0.5,
                                            width: 100,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'width :',
                                                style: TextStyle(
                                                    fontSize: text_size),
                                              ),
                                              (draw_controller.selected_id.value
                                                          .length <
                                                      2)
                                                  ? Container(
                                                      width: 120,
                                                      height: 24,
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        enabled: true,

                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        controller: new_width,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        validator: (d) {
                                                          if (d!.isEmpty) {
                                                            return 'add value please';
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  : Text(
                                                      '${p.piece_width}',
                                                      style: TextStyle(
                                                          fontSize: text_size),
                                                    ),
                                            ],
                                          ),
                                          Container(
                                            height: 0.5,
                                            width: 100,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'height :',
                                                style: TextStyle(
                                                    fontSize: text_size),
                                              ),
                                              (draw_controller.selected_id.value
                                                          .length <
                                                      2)
                                                  ? Container(
                                                      width: 120,
                                                      height: 24,
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        enabled: true,

                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        controller: new_height,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        validator: (d) {
                                                          if (d!.isEmpty) {
                                                            return 'add value please';
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  : Text(
                                                      '${p.piece_height}',
                                                      style: TextStyle(
                                                          fontSize: text_size),
                                                    ),
                                            ],
                                          ),
                                          Container(
                                            height: 0.5,
                                            width: 100,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'thickness :',
                                                style: TextStyle(
                                                    fontSize: text_size),
                                              ),
                                              (draw_controller.selected_id.value
                                                          .length <
                                                      2)
                                                  ? Container(
                                                      width: 100,
                                                      height: 24,
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        enabled: true,

                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        controller:
                                                            new_thicknes,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        validator: (d) {
                                                          if (d!.isEmpty) {
                                                            return 'add value please';
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  : Text(
                                                      '${p.piece_thickness}',
                                                      style: TextStyle(
                                                          fontSize: text_size),
                                                    ),
                                            ],
                                          ),
                                          Container(
                                            height: 0.5,
                                            width: 100,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'material :',
                                                style: TextStyle(
                                                    fontSize: text_size),
                                              ),
                                              (draw_controller.selected_id.value
                                                          .length <
                                                      2)
                                                  ? Container(
                                                      width: 100,
                                                      height: 24,
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        enabled: true,

                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        controller:
                                                            new_material_name,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        validator: (d) {
                                                          if (d!.isEmpty) {
                                                            return 'add value please';
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  : Text(
                                                      '${p.material_name}',
                                                      style: TextStyle(
                                                          fontSize: text_size),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),

                                          /// origin for test only
                                          // Row(
                                          //   children: [
                                          //     Text(
                                          //       'origin :',
                                          //       style: TextStyle(
                                          //           fontSize: text_size),
                                          //     ),
                                          //     Text(
                                          //       'Y 2 :${p.piece_faces.faces[2].corners[0].y_coordinate} \n '
                                          //       'Y 0 :${p.piece_faces.faces[0].corners[0].y_coordinate} \n'
                                          //       'Y origin:${p.piece_origin.y_coordinate} \n'
                                          //       ,
                                          //       style: TextStyle(
                                          //           fontSize: text_size),
                                          //     ),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 6,
                                          // ),

                                          /// unselect checkbox
                                          Row(
                                            children: [
                                              Text(
                                                'unselect :',
                                                style: TextStyle(
                                                    fontSize: text_size),
                                              ),
                                              Checkbox(
                                                  value: true,
                                                  onChanged: (v) {
                                                    draw_controller.selected_id
                                                        .removeAt(i);
                                                  }),
                                            ],
                                          ),
                                          Divider(
                                            height: 2,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),

                            ///divider
                            Container(
                              height: 2,
                              width: 150,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(
                              height: 16,
                            ),

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

                            /// flip
                            SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () {
                                draw_controller.flip_piece();
                              },
                              child: Container(
                                width: 100,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: Colors.teal[300],
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(child: Text('Flip piece')),
                              ),
                            ),

                            SizedBox(
                              height: 16,
                            ),

                            ///divider
                            Container(
                              height: 2,
                              width: 150,
                              color: Colors.blueGrey,
                            ),

                            SizedBox(
                              height: 24,
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
                                        i < draw_controller.selected_id.length;
                                        i++) {
                                      Piece_model p = draw_controller
                                              .box_repository
                                              .box_model
                                              .value
                                              .box_pieces[
                                          draw_controller.selected_id[i]];

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
                                          p.piece_origin);

                                      draw_controller.box_repository.box_model
                                          .value.box_pieces
                                          .remove(p);
                                      draw_controller.box_repository.box_model
                                          .value.box_pieces
                                          .add(np);
                                    }

                                    draw_controller.selected_id.value = [];
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
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
