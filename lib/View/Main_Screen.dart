import 'package:auto_cam/Controller/Active_controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/View/Cabinet_Editor.dart';
 import 'package:auto_cam/View/Screens_parts/Box_Type.dart';
import 'package:auto_cam/View/Setting_Page.dart';
import 'package:auto_cam/View/View_Active_port.dart';
import 'package:auto_cam/project/Projecet_Controller.dart';
import 'package:auto_cam/project/Project_Editor.dart';
import 'package:auto_cam/project/Project_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Main_Screen extends StatefulWidget {



  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  Draw_Controller draw_controller = Get.find();

  Project_Controller project_controller = Get.find();

  Active_controller active_controller = Get.find();

  late bool active;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  active=active_controller.active;
  print("active = $active");
  setState(() {

  });

  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
     body:
     Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.center,
                colors: [Colors.white, Colors.grey])),
        child: ListView(
          children: [
            SizedBox(
              height: 42,
            ),

            /// auto cam lable
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: w/2,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Text(
                      "   AUTO CAM   ",
                      style: TextStyle(fontSize: w / 22, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 36,
            ),

            /// row of items [ project , cabinet editor   ]
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: w /2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// project
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Project",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(Project_Editor(active));
                              },
                              child: Container(
                                  height: 130,
                                  // color: Colors.red,
                                  child: Image.asset(
                                    "lib/assets/images/pr.png",
                                  )),
                            ),

                            SizedBox(
                              height: 64,
                            ),

                            /// open new project

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        draw_controller
                                                .box_repository.project_model =
                                            Project_model("current project", 1, 1,
                                                2023, "", "", []);
                                        Get.to(Project_Editor(active));
                                      },
                                      child: Icon(
                                        Icons.create,
                                        size: 42,
                                        color: Colors.red[500],
                                      )),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Text(
                                    "create new project",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            /// open project from repository

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        await project_controller
                                            .read_Project_from_rebository();
                                        Get.to(Project_Editor(active));
                                      },
                                      child: Icon(
                                        Icons.file_open,
                                        size: 42,
                                        color: Colors.red[500],
                                      )),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Text(
                                    "open project from repository",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// single cabinet
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Single Cabinet",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(Cabinet_Editor(active));
                              },
                              child: Container(
                                  height: 150,
                                  // color: Colors.red,
                                  child: Image.asset(
                                    "lib/assets/images/sc.png",
                                  )),
                            ),
                            SizedBox(
                              height: 64,
                            ),

                            /// open new cabinet

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        draw_controller
                                                .box_repository.box_model.value =
                                            Box_model(
                                                'box_name',
                                                "wall_cabinet",
                                                400,
                                                600,
                                                500,
                                                18,
                                                'MDF',
                                                5,
                                                9,
                                                18,
                                                100,
                                                true,
                                                Point_model(0, 0, 0));
                                        draw_controller.box_repository
                                            .box_have_been_saved = false;
                                        draw_controller
                                            .box_repository.box_file_path = '';

                                        Get.to(Box_Type(active));
                                      },
                                      child: Icon(
                                        Icons.create,
                                        size: 42,
                                        color: Colors.red[500],
                                      )),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Text(
                                    "create new box",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            /// open box from repository

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        await draw_controller
                                            .read_Box_from_rebository();
                                        Get.to(Cabinet_Editor(active));
                                      },
                                      child: Icon(
                                        Icons.file_open,
                                        size: 42,
                                        color: Colors.red[500],
                                      )),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Text(
                                    "open box from repository",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),

            ///KD Join pattern setting
            Container(
              width: w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                       Get.to(Setting_Page());
                      },
                      child: Icon(
                        Icons.settings,
                        size: 32,
                        color: Colors.red[500],
                      )),
                  SizedBox(
                    width: 32,
                  ),
                  Text(
                    "KD Join pattern setting",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),




            SizedBox(
              height: 24,
            ),
            Container(
              width: w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Get.defaultDialog(title: "ACTIVE EDITOR" , content: Container(
                          width: 600,height: 600,child: View_Active_port(),
                        ));
                      },
                      child: Icon(
                        Icons.key,
                        size: 24,
                        color: Colors.red[500],
                      )),

                ],
              ),
            ),

            SizedBox(
              height: 24,
            ),


            // Container(
            //   width: w,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       InkWell(
            //           onTap: () {
            //             active_controller.clean_data();
            //           },
            //           child: Icon(
            //             Icons.cancel,
            //             size: 24,
            //             color: Colors.red[500],
            //           )),
            //
            //     ],
            //   ),
            // ),


          ]
          ,
        ),
      )

    );
  }
}
