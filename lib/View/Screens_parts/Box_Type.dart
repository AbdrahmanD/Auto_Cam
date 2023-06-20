import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/View/Cabinet_Editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Box_Type extends StatefulWidget {

  @override
  State<Box_Type> createState() => _Box_TypeState();
}

class _Box_TypeState extends State<Box_Type> {

  Draw_Controller draw_controller=Get.find();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
        child: Center(
          child:
          Column(
            children: [

              SizedBox(
                height: w/4,
              ),

              // auto cam lable
              Container(
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "  chose the type of box you want to build    ",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),

              SizedBox(
                height: 64,
              ),

              // row of items [ project , cabinet editor , single piece editor ]
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // project
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "wall cabinet",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(Project_Screen());
                            draw_controller.box_type="wall_box";
                            Get.to(Cabinet_Editor());

                          },
                          child: Container(
                              height: 200,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/normal.png",
                              )),
                        ),
                        Text(
                          "normal cabinet",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  // single cabinet
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Base Cabinet",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            draw_controller.box_type="base_box";

                            Get.to(Cabinet_Editor());
                          },
                          child: Container(
                              height: 200,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/10u.png",
                              )),
                        ),
                        Text(
                          "box with 10 cm top and normal base",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  // single piece
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Inner Box",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(Single_Piece_Editor());
                            draw_controller.box_type="inner_box";
                            Get.to(Cabinet_Editor());
                          },
                          child: Container(
                              height: 200,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/10ud.png",
                              )),
                        ),
                        Text(
                          "box with 10 cm  top and base",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

              SizedBox(
                height: 128,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
