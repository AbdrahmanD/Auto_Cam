import 'package:auto_cam/View/Dialog_Boxes/Context_Menu_Dialogs/ADD_BOX.dart';
import 'package:auto_cam/View/Dialog_Boxes/Context_Menu_Dialogs/Add_Filler_Dialog.dart';
import 'package:auto_cam/View/Dialog_Boxes/Context_Menu_Dialogs/Add_Fix_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Out_Box_Menu extends StatefulWidget {
  const Out_Box_Menu({Key? key}) : super(key: key);

  @override
  State<Out_Box_Menu> createState() => _Out_Box_MenuState();
}

class _Out_Box_MenuState extends State<Out_Box_Menu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        ///add filler
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add Filler',
                content: Add_Filler_Dialog(false)
            );
            // draw_controller.add_door(1.5);
          },
          child: Text(
            'Add Filler',
            style: TextStyle(fontSize: 18),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),


        ///add fix panel
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add Fix panel',
                content: Add_Fix_Dialog()
            );
            // draw_controller.add_door(1.5);
          },
          child: Text(
            'Add Fix Panel',
            style: TextStyle(fontSize: 18),
          ),
        ),

        ///add box
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add BOX',
                content: ADD_BOX()
            );
            // draw_controller.add_door(1.5);
          },
          child: Text(
            'Add BOX',
            style: TextStyle(fontSize: 18),
          ),
        ),


      ],
    );
  }
}
