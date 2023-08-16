import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';


class Drawing_Screen extends StatelessWidget {

  late double w;

  Drawing_Screen(this.w){
  }

  late double h;

  late Box_model box_model;

  Draw_Controller draw_controller=Get.find();


  @override
  Widget build(BuildContext context) {

    h=MediaQuery.of(context).size.height;
    draw_controller.screen_size.value = Size(w,h);
    double f=1;
    return Container(


      child: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent) {

            if(f>0 && f<10){
              draw_controller.drawing_scale.value += (event.scrollDelta.direction).toInt()/10;

            }
          }
        },
        child: GestureDetector(

          onLongPress: () {
            Get.defaultDialog(
              radius: 12,
                title: draw_controller.general_list(),
                content: draw_controller.Context_list()
            );
          },
          child: MouseRegion(

            onHover: (d) {
              draw_controller.mouse_position.value = d.localPosition;
            },

            child:
            Obx(
              () => CustomPaint(
                painter:draw_controller.draw_Box(),
                child: Container(
                  width: w,
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
