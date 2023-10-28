import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/View/Cabinet_Editor.dart';
 import 'package:auto_cam/View/Dialog_Boxes/Context_Menu_Dialogs/CreateJoinholepatternDialog.dart';
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
                            draw_controller.box_type="wall_cabinet";
                            Get.to(Cabinet_Editor());

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

                  // single cabinet
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

                            Get.to(Cabinet_Editor());
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
                            draw_controller.box_type="inner_cabinet";
                            Get.to(Cabinet_Editor());
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

              /// saved boxes
              SizedBox(
                height: 64,
              ),

              Container(width: w,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(onTap: () async{

                      draw_controller.open_File();

                    }
                        ,child: Icon(Icons.file_open,size: 42,color: Colors.red[500],)),
                    SizedBox(width: 32,),
                    Text("open box from repository",style: TextStyle(fontSize: 22),)
                  ],
                ),
              ),

              /// setting
              SizedBox(
                height: 24,
              ),

              Container(width: w,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(onTap: (){
                      Get.defaultDialog(
                          title: "Create KD Join pattern",
                          content: CreateJoinholepatternDialog());
                    }
                        ,child: Icon(Icons.settings,size: 42,color: Colors.red[500],)),
                    SizedBox(width: 32,),
                    Text("setting",style: TextStyle(fontSize: 22),)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
