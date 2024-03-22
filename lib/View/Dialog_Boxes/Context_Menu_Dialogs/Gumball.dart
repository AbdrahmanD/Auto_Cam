import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Gumball extends StatefulWidget {
  late bool gumball;

  Gumball(this.gumball);

  @override
  State<Gumball> createState() => _GumballState();
}

class _GumballState extends State<Gumball> {
  Draw_Controller draw_controller = Get.find();
  TextEditingController move_value = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
  move_value.text="0";

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool gumball = widget.gumball;

    return Container(
        width: 160,height:120,
        child: gumball
            ? Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 40,),

                      InkWell(
                          onTap: () {
                            double double_move_value = double.parse(
                                double.parse(move_value.text.toString())
                                    .toStringAsFixed(2));
                            draw_controller.move(double_move_value,"Y");
                            draw_controller.gumball.value = false;
                            setState(() {});
                          },
                          child: Transform.rotate(
                              angle: -3.14 / 2,
                              child: Container(
                                  width: 42,
                                  height: 64,
                                  child: Image.asset(
                                      'lib/assets/images/blue_arrow.png')))),

                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 96,
                        height: 40,
                        child: TextFormField(
                          controller: move_value,
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            double double_move_value = double.parse(
                                double.parse(move_value.text.toString())
                                    .toStringAsFixed(2));
                            draw_controller.move(double_move_value,"X");
                            draw_controller.gumball.value = false;
                            setState(() {});
                          },
                          child: Container(
                              width: 64,
                              height: 42,
                              child: Image.asset(
                                  'lib/assets/images/red_arrow.png'))),
                    ],
                  ),
                ],
              )
            : Container());
  }
}
