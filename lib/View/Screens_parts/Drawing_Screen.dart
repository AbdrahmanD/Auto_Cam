import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';


class Drawing_Screen extends StatelessWidget {

  late double w;
  late double h;
  late Box_model box_model;

  Draw_Controller draw_controller=Get.find();


  Drawing_Screen(this.w){
  }


  @override
  Widget build(BuildContext context) {
    draw_controller.screen_size.value = MediaQuery.of(context).size;

    return Container(
      child: GestureDetector(
        onScaleUpdate: (d) {
          draw_controller.drawing_scale.value = d.scale;
        },
        onLongPress: () {
          Get.defaultDialog(
            radius: 12,
              title: draw_controller.minu_title(),
              content: draw_controller.Context_Menu()
          );
        },
        child: MouseRegion(
          onHover: (d) {
            draw_controller.mouse_position.value = d.localPosition;
          },
          child: Obx(
            () => CustomPaint(
              painter: draw_controller.draw_Box(),
              child: Container(
                width: w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
