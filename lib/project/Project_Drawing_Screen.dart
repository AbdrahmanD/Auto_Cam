import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/project/Projecet_Controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';

class Project_Drawing_Screen extends StatefulWidget {
  late double w;

  Project_Drawing_Screen(this.w);

  @override
  State<Project_Drawing_Screen> createState() => _Drawing_ScreenState();
}

class _Drawing_ScreenState extends State<Project_Drawing_Screen> {
  Project_Controller project_controller = Get.find();

  bool shift_hold = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    project_controller.screen_size.value = Size(widget.w, h);
    double f = 1;

    return Container(
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) ||
                event.isKeyPressed(LogicalKeyboardKey.shiftRight)) {
              shift_hold = true;
              // setState(() {});
            }
          } else if (event is RawKeyUpEvent) {
            if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) == false &&
                event.isKeyPressed(LogicalKeyboardKey.controlRight) == false) {
              shift_hold = false;

             }
          }
        },
        child: Listener(behavior: HitTestBehavior.opaque,
          onPointerMove: (v){
          // project_controller.mouse_position.value=v.localPosition;
          if (!shift_hold) {
            project_controller.drag_box(v.delta);
          }

          },   // pressed

          onPointerSignal: (PointerSignalEvent event) {
            if (event is PointerScrollEvent) {
              if (f > 0 && f < 10) {
                project_controller.drawing_scale.value +=
                    (event.scrollDelta.direction).toInt() / 10;
              }
            }
          },
          onPointerDown: (v) {
            project_controller.mouse_left_click(v.localPosition,shift_hold);
            setState(() {

            });
          },
onPointerUp: (v){
  project_controller.finish_draging();

},
          child: MouseRegion(
            onHover: (d) {
              project_controller.mouse_position.value = d.localPosition;
             },
            child: GestureDetector(
              onPanUpdate: (v) {
                if (shift_hold) {
                  project_controller.move_project(v.delta);
                  setState(() {});
                } else {
                  // if (!draw_controller.select_window.value) {
                  //   draw_controller.select_window_method(v.delta);
                  //   setState(() {
                  //
                  //   });
                  // }
                  // project_controller.select_window_method(v.localPosition,draw_controller.select_window.value);

                  setState(() {});
                }
              },
              // onPanStart: (v){project_controller.select_window.value=true;},
              // onPanEnd: (v){project_controller.select_window.value=false;
              // project_controller.select_piece_via_window();
              // },
              onSecondaryTapUp: (v) {

                //
                // Get.defaultDialog(
                //     radius: 12,
                //     title: "project_controller.general_list()",
                //     content: Text("project_controller.Context_list()"));
              },
              child: Obx(
                () => CustomPaint(
                  painter: project_controller.draw_project(),
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
