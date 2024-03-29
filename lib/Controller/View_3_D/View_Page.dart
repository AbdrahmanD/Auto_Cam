import 'dart:math' as math;

import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/View_3_D/transform_controller.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/View/Dialog_Boxes/Context_Menu_Dialogs/Gumball.dart';
import 'package:auto_cam/View/Screens_parts/Box_Pieces_List.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class View_Page extends StatefulWidget {
  late Size screen_size;

  View_Page(this.screen_size);

  @override
  State<View_Page> createState() => _View_PageState(screen_size);
}

class _View_PageState extends State<View_Page> {
  _View_PageState(this.screen_size);

  late Size screen_size;

  late transform_controller transfomer = transform_controller(screen_size);
  Draw_Controller draw_controller = Get.find();


  bool right_click = false;

  bool shift_hold = false;
  bool alt_hold = false;
  bool ctr_hold = false;
@override
  void initState() {
    // TODO: implement initState


  draw_controller.x_move=0;
  draw_controller.y_move=0;

  super.initState();
  }


  String plane = 'X_Y';

  Offset old_position = Offset(0, 0);

  Offset gumball_position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    double box_X = screen_size.width / 2;
    double box_Y = screen_size.height / 2;
    double scale = draw_controller.drawing_scale.value;

    return Scaffold(
      body:
          Stack(
            children: [


              /// main drawing canvas
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                height: screen_size.height,
                width: screen_size.width,
                // color: Colors.grey[100],
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  autofocus: true,

                  /// listen to keyboard keys
                  onKey: (RawKeyEvent event) {
                    ///   start press
                    if (event is RawKeyDownEvent) {
                      if (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) ||
                          event.isKeyPressed(LogicalKeyboardKey.shiftRight)) {
                        shift_hold = true;
                        setState(() {});
                      }
                      if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) ||
                          event.isKeyPressed(LogicalKeyboardKey.controlRight)) {
                        ctr_hold = true;
                        setState(() {});
                      }
                      if (event.isKeyPressed(LogicalKeyboardKey.altRight) ||
                          event.isKeyPressed(LogicalKeyboardKey.altLeft)) {
                        alt_hold = true;
                        setState(() {});
                      }

                      /// Enter
                      if (event.isKeyPressed(LogicalKeyboardKey.enter)) {

                        print("enter");

                        setState(() {});
                      }

                      /// Delete
                      if (event.isKeyPressed(LogicalKeyboardKey.delete)) {

                        draw_controller.delete_piece();

                        setState(() {});
                      }


                    }

                    ///   end press
                    else if (event is RawKeyUpEvent) {
                      if (event.isKeyPressed(LogicalKeyboardKey.shiftRight) == false &&
                          event.isKeyPressed(LogicalKeyboardKey.shiftLeft) == false) {
                        shift_hold = false;
                        setState(() {});
                      }

                      if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) == false &&
                          event.isKeyPressed(LogicalKeyboardKey.controlRight) ==
                              false) {
                        ctr_hold = false;

                        setState(() {});
                      }
                      if (event.isKeyPressed(LogicalKeyboardKey.altLeft) == false &&
                          event.isKeyPressed(LogicalKeyboardKey.altRight) == false) {
                        alt_hold = false;
                        setState(() {});
                      }
                    }
                  },

                  child: Listener(
                    /// zooming by scrolling mouse wheel
                    onPointerSignal: (PointerSignalEvent event) {
                      if (event is PointerScrollEvent) {
                        if ((draw_controller.drawing_scale.value +
                            event.scrollDelta.dy / 1000) >
                            0.5 &&
                            (draw_controller.drawing_scale.value +
                                event.scrollDelta.dy / 1000) <
                                100) {
                          draw_controller.drawing_scale.value +=
                              event.scrollDelta.dy / 500;
                          setState(() {});
                        }
                      }
                    },

                    child: MouseRegion(

                      /// hovering
                      onHover: (v) {

                        draw_controller.mouse_position.value = Offset(
                            (v.localPosition.dx - box_X) / scale - draw_controller.x_move,
                           -(box_Y - v.localPosition.dy) / scale - draw_controller.y_move,
                        );

                        draw_controller.hover_id_find();

                        setState(() {});
                      },





                      /// mouse actions
                      child: GestureDetector(

                        /// left click
                        onPanDown: (v){
                          gumball_position=v.localPosition;
                          if (!shift_hold) {
                            draw_controller.select_piece();
                          }
                          setState(() {});
                        },



                        /// onPanUpdate
                        onPanUpdate: (v)
                        {
                          if(shift_hold){
                            draw_controller.end_select_window.value=Offset(
                              (v.localPosition.dx - box_X) / scale - draw_controller.x_move,
                              -(box_Y - v.localPosition.dy) / scale - draw_controller.y_move,
                            );


                            setState(() {});

                          }else
                          {

                          if (plane == 'X_Y') {
                            draw_controller.x_move += v.delta.dx / draw_controller.drawing_scale.value;
                            draw_controller.y_move += v.delta.dy / draw_controller.drawing_scale.value;

                            transfomer.move(-v.delta.dx, v.delta.dy, 0);

                            setState(() {});
                          }
                          else if (plane == 'X_Z') {

                            draw_controller.x_move += v.delta.dx / draw_controller.drawing_scale.value;
                            draw_controller.y_move += v.delta.dy / draw_controller.drawing_scale.value;

                            transfomer.move(-v.delta.dx, 0, v.delta.dy);
                            setState(() {});
                          }
                          else if (plane == 'Y_Z') {
                            draw_controller.x_move += v.delta.dx / draw_controller.drawing_scale.value;
                            draw_controller.y_move += v.delta.dy / draw_controller.drawing_scale.value;

                            transfomer.move(0, v.delta.dy, -v.delta.dx);
                            setState(() {});
                          }


                          }
                        },


                        ///onPanStart
                        onPanStart: (v){
                          if (shift_hold) {
                            draw_controller.select_window.value=true;
                          }
                            draw_controller.start_select_window.value=Offset(
                              (v.localPosition.dx - box_X) / scale - draw_controller.x_move,
                              -(box_Y - v.localPosition.dy) / scale - draw_controller.y_move,
                            );



                    },

                        ///onPanEnd
                          onPanEnd: (v){
                            if (shift_hold) {

                              draw_controller.select_piece_via_window();
                              draw_controller.select_window.value=false;

                            }
                          },

                        /// right click
                        onSecondaryTapUp: (v) {
                          if (
                          (!( draw_controller.hover_id == 100) &&  draw_controller.box_repository.box_model.value.box_pieces[ draw_controller.hover_id].piece_name
                              .contains('inner'))
                          || ( draw_controller.hover_id == 100)

                          ) {
                            Get.defaultDialog(
                                  radius: 12,
                                  title: draw_controller.general_list(),
                                  content: draw_controller.Context_list());
                          }
                        },


                        onSecondaryLongPressStart: (v)
                        {
                          old_position = v.localPosition;
                          setState(() {});
                        },


                        /// long right click
                        onSecondaryLongPressMoveUpdate: (v) {
                          double dx = (old_position.dx - v.localPosition.dx) *
                              draw_controller.drawing_scale.value;
                          double dy = (old_position.dy - v.localPosition.dy) *
                              draw_controller.drawing_scale.value;

                          old_position = v.localPosition;

                          /// rotate round x axis
                          transfomer.a3 += dy / 500;

                          /// rotate round y axis
                          transfomer.a2 += dx / 500;

                          // /// rotate round z axis
                          // transfomer.a1 += dy / 500;

                          setState(() {});

                        },

onDoubleTap: (){
  if (
  (!( draw_controller.hover_id == 100) &&  draw_controller.box_repository.box_model.value.box_pieces[ draw_controller.hover_id].piece_name
      .contains('inner'))
      || ( draw_controller.hover_id == 100)

  ) {
    Get.defaultDialog(
        radius: 12,
        title: draw_controller.general_list(),
        content: draw_controller.Context_list());
  }
},
                        child: Obx(
                              () => CustomPaint(
                            painter: transfomer.camera_cordinate_draw(screen_size),
                            // painter: draw_controller.draw_3_D_painter(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),),

              /// view options : right . left . top . home . zoom all
              Positioned(
                bottom: 16,
                left: 0,
                child: Row(
                children: [
                  SizedBox(
                    width: 56,
                  ),

                  ///Top
                  InkWell(
                    onTap: () {
                      transfomer.a1 = math.pi; //z
                      transfomer.a3 = -math.pi / 2; //x
                      transfomer.a2 = math.pi; //y
                      plane = 'X_Z';
                      draw_controller.view_port.value="T";

                      transfomer.camera_position=Point_model(0, 0, 0);
                      draw_controller.x_move=0;
                      draw_controller.y_move=0;

                      setState(() {}); //         setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.blueGrey[200],
                        ),
                        child: Center(
                            child: Text(
                              'Top',
                              style: TextStyle(fontSize: 13),
                            )),
                      ),
                    ),
                  ),

                  ///Right
                  InkWell(
                    onTap: () {
                      transfomer.a1 = 0; //z
                      transfomer.a2 = -math.pi / 2; //y
                      transfomer.a3 = 0; //x
                      plane = 'Y_Z';
                      draw_controller.view_port.value="R";
                      transfomer.camera_position=Point_model(0, 0, 0);
                      draw_controller.x_move=0;
                      draw_controller.y_move=0;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.blueGrey[200],
                        ),
                        child: Center(
                            child: Text(
                              'Right',
                              style: TextStyle(fontSize: 13),
                            )),
                      ),
                    ),
                  ),

                  ///Front
                  InkWell(
                    onTap: () {
                      transfomer.a1 = 0; //z
                      transfomer.a3 = 0; //y
                      transfomer.a2 = 0; //x
                      plane = 'X_Y';

                      draw_controller.view_port.value="F";

                      transfomer.camera_position=Point_model(0, 0, 0);
                      draw_controller.x_move=0;
                      draw_controller.y_move=0;

                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.blueGrey[200],
                        ),
                        child: Center(
                            child: Text(
                              'Front',
                              style: TextStyle(fontSize: 13),
                            )),
                      ),
                    ),
                  ),

                  ///Home
                  InkWell(
                    onTap: () {
                      transfomer.a1 = math.pi / 24;
                      transfomer.a2 = -math.pi / 6;
                      transfomer.a3 = math.pi / 12;
                      plane = 'X_Y';
                      draw_controller.view_port.value="P";

                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.blueGrey[200],
                        ),
                        child: Center(
                            child: Icon(
                              Icons.home,
                              size: 28,
                              color: Colors.black87,
                            )),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      draw_controller.zoom_all();

                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.blueGrey[200],
                        ),
                        child: Center(
                            child: Icon(
                              Icons.zoom_in,
                              size: 28,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ),
                ],
              ),),


              /// list of box content
              Positioned(
                  left: 0,top: 100,
                  child: Box_Pieces_List(draw_controller.box_repository.box_model.value)
              ),





              /// Gumball
              Obx(()=>Positioned(


                  top:   gumball_position.dy-80,
                  left:   gumball_position.dx-60,

                  child:Gumball(draw_controller.gumball.value)

              )
              ),

            ],
          )

     );
  }
}
