import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/View/Cabinet_Editor.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Box_Type extends StatefulWidget {

  late bool active;

  Box_Type(this.active);

  @override
  State<Box_Type> createState() => _Box_TypeState(active);



}

class _Box_TypeState extends State<Box_Type> {

  late bool active;

  _Box_TypeState(this.active);

  Draw_Controller draw_controller=Get.find();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body:!active?Container(width: w,height: h,child: Center(child: Text("active key is requested ",style: TextStyle(fontSize: 32),),),):
      Container(
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
                height: 100,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  /// standard_unit
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "standard unit",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(Project_Screen());
                            draw_controller.box_type="standard_unit";
                            Get.to(Cabinet_Editor(active));

                          },
                          child: Container(
                              height: 200,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/unit.png",
                              )),
                        ),
                        // Text(
                        //   "normal cabinet",
                        //   style: TextStyle(fontSize: 14),
                        // ),
                      ],
                    ),
                  ),


                  /// wall cabinet
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
                            draw_controller.box_type="wall_cabinet";
                            Get.to(Cabinet_Editor(active));

                          },
                          child: Container(
                              height: 200,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/normal.png",
                              )),
                        ),
                        // Text(
                        //   "normal cabinet",
                        //   style: TextStyle(fontSize: 14),
                        // ),
                      ],
                    ),
                  ),

                  /// base cabinet
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "base _cabinet",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            draw_controller.box_type="base_cabinet";

                            Get.to(Cabinet_Editor(active));
                          },
                          child: Container(
                              height: 200,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/10u.png",
                              )),
                        ),
                        // Text(
                        //   "box with 10 cm top and normal base",
                        //   style: TextStyle(fontSize: 14),
                        // ),
                      ],
                    ),
                  ),

                  /// sink cabinet
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sink Cabinet",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(Single_Piece_Editor());
                            draw_controller.box_type="sink_cabinet";
                            Get.to(Cabinet_Editor(active));
                          },
                          child: Container(
                              height: 200,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/sink_cabinet.png",
                              )),
                        ),
                        // Text(
                        //   "box with 10 cm  top and base",
                        //   style: TextStyle(fontSize: 14),
                        // ),
                      ],
                    ),
                  ),

                  /// inner box
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
                            draw_controller.box_type="inner_cabinet";
                            Get.to(Cabinet_Editor(active));
                          },
                          child: Container(
                              height: 200,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/10ud.png",
                              )),
                        ),
                        // Text(
                        //   "box with 10 cm  top and base",
                        //   style: TextStyle(fontSize: 14),
                        // ),
                      ],
                    ),
                  ),


                ],
              ),


              /// setting
              SizedBox(
                height: 24,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
