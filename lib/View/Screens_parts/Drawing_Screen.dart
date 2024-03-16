import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';

class Drawing_Screen extends StatefulWidget {
  late double w;

  Drawing_Screen(this.w);

  @override
  State<Drawing_Screen> createState() => _Drawing_ScreenState();
}

class _Drawing_ScreenState extends State<Drawing_Screen> {

  Draw_Controller draw_controller = Get.find();

  bool shift_hold = false;
  bool ctr_hold = false;

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;

    draw_controller.screen_size.value = Size(widget.w, h);

    double f = 3.1;

    return Container(
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) ||
                event.isKeyPressed(LogicalKeyboardKey.shiftRight)) {
              shift_hold = true;
              ctr_hold = false;
               }
          else  if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) ||
                event.isKeyPressed(LogicalKeyboardKey.controlRight) ) {
              ctr_hold = true;
              shift_hold = false;

            }

          }
         },
        child: Listener(
          onPointerSignal: (PointerSignalEvent event) {
            if (event is PointerScrollEvent) {
              // f += (event.scrollDelta.direction).toInt() / 3;
              // if (f >3 && f <= 25) {
              if (draw_controller.drawing_scale.value >0.2 ) {

                draw_controller.drawing_scale.value += (event.scrollDelta.direction).toInt() / 10;
               //   // print(f);
              }else{
                draw_controller.drawing_scale.value=0.3;
              }
            }
          },
          onPointerDown: (v) {
            if(shift_hold){
              draw_controller.selected_pieces.value=[];

            }else{
              draw_controller.select_piece(v.localPosition);

            }
          },
          child: MouseRegion(
            onHover: (d) {
              draw_controller.mouse_position.value = d.localPosition;
            },
            child: GestureDetector(
              onPanUpdate: (v) {
                if (shift_hold) {
                  draw_controller.move_box( v.delta.dx, -v.delta.dy) ;
                }
                else {
                  draw_controller.select_window_method(v.localPosition,draw_controller.select_window.value);
                  setState(() {});
                }
              },
              onPanStart: (v){
                draw_controller.select_window.value=true;
                },
              onPanEnd: (v){

                draw_controller.select_window.value=false;

                  if (!ctr_hold) {
                    draw_controller.select_piece_via_window();
                  }else{
                    draw_controller.select_face_via_window();
                  }

              },
              onSecondaryTapUp: (v) {
                Get.defaultDialog(
                    radius: 12,
                    title: draw_controller.general_list(),
                    content: draw_controller.Context_list());
              },
              child: Obx(
                () => CustomPaint(
                  painter: draw_controller.draw_Box(),
                  child: Container(
                    width: widget.w,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
