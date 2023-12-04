
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/View_3_D/View_Page.dart';
import 'package:auto_cam/project/Project_Drawing_Screen.dart';
import 'package:auto_cam/project/Project_View_option.dart';
import 'package:auto_cam/project/Setting_Project_Form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Project_Editor extends StatelessWidget {
  Draw_Controller draw_controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var screen_size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => Positioned(
            top: 0,
            left: !draw_controller.draw_3_D.value ? 300 : 0,
            child: Container(
              height: screen_size.height,
              color: Colors.white54,
              child: Container(
                  width: !draw_controller.draw_3_D.value
                      ? screen_size.width - 500
                      : screen_size.width - 200,
                  child: !draw_controller.draw_3_D.value
                      ? Project_Drawing_Screen(screen_size.width - 500)
                      : View_Page(Size(
                      !draw_controller.draw_3_D.value
                          ? screen_size.width - 500
                          : screen_size.width - 200,
                      screen_size.height))),
            ),
          )),
          Positioned(
              top: 0,
              left: 0,
              child: Obx(
                    () => Container(
                  width: !draw_controller.draw_3_D.value ? 300 : 0,
                  height: screen_size.height,
                  color: Colors.grey[300],
                  child: !draw_controller.draw_3_D.value
                      ? Setting_Project_Form()
                      : SizedBox(),
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                  width: 200,
                  height: screen_size.height,
                  color: Colors.grey[300],
                  child: Project_View_option())),
        ],
      ),
    );
  }
}
