import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/View/Screens_parts/Drawing_Screen.dart';
import 'package:auto_cam/View/Screens_parts/Setting_Box_Size_Form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cabinet_Editor extends StatelessWidget {

Draw_Controller draw_controller=Get.find();

  @override
  Widget build(BuildContext context) {

    var screen_size=MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          // size edit form
          Container(width: 300,color: Colors.grey[300],
          child: Setting_Box_Size_Form()
          ),

          // main Box Painter
          Container(width: screen_size.width-300,
          child:Drawing_Screen(screen_size.width-300)
          ),

        ],
      ),
    );
  }


}

