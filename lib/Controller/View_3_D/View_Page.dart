import 'dart:math' as math;

import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/View_3_D/transform_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

  double x_move=0;
  double y_move=0;

  bool shift_hold = false;
  bool alt_hold = false;

  String plane='X_Y';

  @override
  Widget build(BuildContext context) {

    double box_X=screen_size.width/2;
    double box_Y=screen_size.height/2;

    return Scaffold(
      body: Container(
        height: screen_size.height,
        width: screen_size.width,
        color: Colors.grey[100],
        child: RawKeyboardListener(

          focusNode: FocusNode(),

          autofocus: true,
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent) {
              if (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) ||
                  event.isKeyPressed(LogicalKeyboardKey.shiftRight)) {
                shift_hold = true;
                setState(() {});
              } if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) ||
                  event.isKeyPressed(LogicalKeyboardKey.controlRight)) {
                alt_hold = true;
                setState(() {});
              }
            }

            else if (event is RawKeyUpEvent) {
              if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) == false &&
                  event.isKeyPressed(LogicalKeyboardKey.controlRight) == false) {
                shift_hold = false;

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
            onPointerSignal: (PointerSignalEvent event) {

              if (event is PointerScrollEvent) {

                if ((draw_controller.drawing_scale.value + event.scrollDelta.dy / 1000) > 0.5 &&
                    (draw_controller.drawing_scale.value + event.scrollDelta.dy / 1000) < 100) {
                  draw_controller.drawing_scale.value+= event.scrollDelta.dy / 500;

                  setState(() {});
                }
              }
            },
            // onPointerHover: (v){
            //   print(v.position);
            // },
//

            child: MouseRegion(

              onHover: (v) {
                double scale=draw_controller.drawing_scale.value;
                draw_controller.mouse_position.value=
                    Offset(
                          (v.localPosition.dx-box_X)/scale-x_move,
                          -(box_Y-v.localPosition.dy)/scale-y_move,
                    );
                draw_controller.hover_id_find();
                setState(() {

                });
               },
              child: GestureDetector(

                onPanUpdate: (v) {

                  if (!shift_hold && !alt_hold) {
                    if(plane=='X_Y'){

                      x_move+=v.delta.dx/draw_controller.drawing_scale.value;
                      y_move+=v.delta.dy/draw_controller.drawing_scale.value;

                      transfomer.move(-v.delta.dx , v.delta.dy, 0);
                      setState(() {});
                    }
                    else if(plane=='X_Z'){
                      transfomer.move(-v.delta.dx , 0, v.delta.dy);
                      setState(() {});
                    }
                    else if(plane=='Y_Z'){
                      transfomer.move( 0,v.delta.dy , -v.delta.dx);
                      setState(() {});
                    }

                  }
                  else if (shift_hold && !alt_hold) {
                    transfomer.a3 += v.delta.dy / 500;
                    setState(() {});
                  }
                 else if (alt_hold && !shift_hold) {
                    transfomer.a2 += v.delta.dx / 500;
                    setState(() {});
                  }
                  else if (alt_hold && shift_hold) {
                    transfomer.a1 += v.delta.dy / 500;
                    setState(() {});
                  }


                },
                onSecondaryTapUp: (v) {

                  // Get.defaultDialog(
                  //     radius: 12,
                  //     title: draw_controller.general_list(),
                  //     content: draw_controller.Context_list());

                  Get.defaultDialog(
                      radius: 12,
                      title: "hover piece",

                      content: Text(""
                          "   X:${draw_controller.box_repository.box_model.value.box_origin.x_coordinate} "
                          ",  Y:${draw_controller.box_repository.box_model.value.box_origin.y_coordinate} "
                          "\n"
                          // "draw mouse position X=${draw_controller.mouse_position.value.dx} \n"
                          // "draw mouse position Y=${draw_controller.mouse_position.value.dy} \n"
                      //     "inner X : ${draw_controller.box_repository.box_model.value.box_pieces[4].piece_origin.x_coordinate}"
                      //     "inner Y : ${draw_controller.box_repository.box_model.value.box_pieces[4].piece_origin.y_coordinate}"
                          "hover id = ${draw_controller.hover_id}")
                  );

                },

                child: Obx(()=> CustomPaint(
                    painter: transfomer.camera_cordinate_draw(screen_size),
                  // painter: draw_controller.draw_3_D_painter(),

                ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [

          SizedBox(width: 56,),
          ///Top
          InkWell(
            onTap: () {
              transfomer.a1=math.pi; //z
              transfomer.a3=-math.pi/2;//x
              transfomer.a2=math.pi;//y
              plane='X_Z';

              setState(() {

              });//         setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blueGrey,
                child: Center(
                    child: Text(
                  'Top',
                  style: TextStyle(fontSize: 14),
                )),
              ),
            ),
          ),

          ///Right
          InkWell(
            onTap: () {
              transfomer.a1 = 0; //z
              transfomer.a2 = -math.pi/2;//y
              transfomer.a3 = 0;//x
              plane='Y_Z';

              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blueGrey,
                child: Center(
                    child: Text(
                  'Right',
                  style: TextStyle(fontSize: 14),
                )),
              ),
            ),
          ),

          ///Front
          InkWell(
            onTap: () {
              transfomer.a1 =0; //z
              transfomer.a3 =0;//y
              transfomer.a2 =0;//x
              plane='X_Y';
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blueGrey,
                child: Center(
                    child: Text(
                  'Front',
                  style: TextStyle(fontSize: 14),
                )),
              ),
            ),
          ),

          ///Home
          InkWell(
            onTap: () {
              transfomer.a1=math.pi/24;
              transfomer.a2=-math.pi/6;
              transfomer.a3=math.pi/12;
              plane='X_Y';

              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blueGrey,
                child: Center(
                    child: Icon(Icons.home,size: 36,color: Colors.white,)),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
