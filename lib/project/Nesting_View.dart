import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Nesting_Painter.dart';
import 'package:auto_cam/Controller/Painters/Nesting_Piece_Painter.dart';
import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:auto_cam/Controller/nesting/Neting_Controller.dart';
import 'package:auto_cam/View/Cabinet_Editor.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class Nesting_View extends StatefulWidget {
  @override
  State<Nesting_View> createState() => _Nesting_ViewState();
}

class _Nesting_ViewState extends State<Nesting_View> {
  Neting_Controller nesting_controller = Get.find();
  Draw_Controller draw_Controller = Get.find();

  TextEditingController x_move = TextEditingController();
  TextEditingController y_move = TextEditingController();

  double x_move_value = 0;

  double y_move_value = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    x_move.text = '0';
    y_move.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double f = 1;

    nesting_controller.screen_size.value = Size(w - 600, h - 100);

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: 300,
              height: h,
              color: Colors.grey[300],
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),

                  ///back button and lable
                  InkWell(
                    onTap: () {
                      Get.to(Cabinet_Editor());
                    },
                    child: Row(
                      children: [
                        //Back button
                        Container(
                          width: 50,
                          child: Icon(
                            Icons.arrow_back,
                            size: 26,
                            color: Colors.teal,
                          ),
                        ),
                        //lable
                        Container(
                          width: 100,
                          child: Center(
                            child: Text(
                              'Back',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
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
                              TextInputType.numberWithOptions(decimal: true),
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
                              TextInputType.numberWithOptions(decimal: true),
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
                    height: 14,
                  ),

                  ///move qnd flip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          x_move_value =
                              double.parse('${eval(x_move.text.toString())}');
                          y_move_value =
                              double.parse('${eval(y_move.text.toString())}');

                          nesting_controller
                              .move_piece(Offset(x_move_value, y_move_value));
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
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          nesting_controller.flip_piece();
                        },
                        child: Container(
                          width: 70,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.teal[300],
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(child: Text('Flip')),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 12,
                  ),

                  ///divider
                  Container(
                    height: 2,
                    width: 150,
                    color: Colors.blueGrey,
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
                          nesting_controller.save_sheet();
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
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          nesting_controller.reset();
                        },
                        child: Container(
                          width: 70,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.teal[300],
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(child: Text('reset')),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),

                  ///delete the piece
                  InkWell(
                    onTap: () {},
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
            Listener(
              /// scaling
              onPointerSignal: (PointerSignalEvent event) {
                if (event is PointerScrollEvent) {
                  if (f > 0 && f < 10) {
                    nesting_controller.drawing_scale.value +=
                        (event.scrollDelta.direction).toInt() / 50;
                  }
                }
              },

              /// left click
              onPointerDown: (v) {
                nesting_controller.mouse_left_click();
                nesting_controller.hold_piece.value = true;
                setState(() {});
              },

              /// left click end
              onPointerUp: (v) {
                nesting_controller.hold_piece.value = false;
                nesting_controller.finish_draging();
              },

              /// dragging
              onPointerMove: (v) {
                nesting_controller.drag_piece(v.delta);

                setState(() {});
              },

              child: MouseRegion(
                onHover: (v) {
                  if (!nesting_controller.hold_piece.value) {
                    nesting_controller.mouse_position.value = v.localPosition;
                  }
                },
                child: GestureDetector(
                  onPanUpdate: (v) {
                    if (nesting_controller.hold_piece.value) {
                      nesting_controller.mouse_position.value = v.localPosition;
                    }
                  },
                  child: Container(
                    width: w - 600,
                    height: h,
                    color: Colors.grey[100],
                    child: Obx(
                      () => CustomPaint(
                          painter: nesting_controller.draw_nested_sheet()),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 250,
              height: h,
              color: Colors.grey,
              child: ListView.builder(
                  itemCount: draw_Controller.nesting_pieces().length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.blueGrey[100],
                        child: CustomPaint(
                          painter: Nesting_Piece_Painter(
                              draw_Controller.nesting_pieces()[i]),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
