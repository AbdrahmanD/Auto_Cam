
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/View/Cabinet_Editor.dart';
import 'package:auto_cam/View/Screens_parts/Box_Type.dart';
import 'package:auto_cam/project/Projecet_Controller.dart';
import 'package:auto_cam/project/Project_Editor.dart';
import 'package:auto_cam/project/Project_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Main_Screen extends StatelessWidget {
  Draw_Controller draw_controller=Get.find();
  Project_Controller project_controller=Get.find();

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
                height: 128,
              ),

              /// auto cam lable
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  "   AUTO CAM   ",
                  style: TextStyle(fontSize: w / 14, color: Colors.white),
                ),
              ),

              SizedBox(
                height: 64,
              ),

              /// row of items [ project , cabinet editor , single piece editor ]
              Container(width: w-500,
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
                              Get.to(Project_Editor());

                            },
                            child: Container(
                                height: 150,
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
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                InkWell(onTap: () async{

                                  draw_controller.box_repository.project_model=Project_model("current project",1,1,2023, "", "", []);
                                  Get.to(Project_Editor());

                                }
                                    ,child: Icon(Icons.create,size: 42,color: Colors.red[500],)),
                                SizedBox(width: 24,),
                                Text("create new project",style: TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),

                          /// open project from repository

                          Container(
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                InkWell(onTap: () async{

                                  await project_controller.read_Project_from_rebository();
                                  Get.to(Project_Editor());

                                }
                                    ,child: Icon(Icons.file_open,size: 42,color: Colors.red[500],)),
                                SizedBox(width: 24,),
                                Text("open project from repository",style: TextStyle(fontSize: 16),)
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
                              Get.to(Cabinet_Editor());
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
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                InkWell(onTap: () async{

                                  draw_controller.box_repository.box_model.value= Box_model('box_name', "wall_cabinet", 400, 600, 500,
                                          18, 'MDF', 5, 9, 18, 100, true, Point_model(0, 0, 0));
                                  draw_controller.box_repository.box_have_been_saved = false;
                                  draw_controller.box_repository.box_file_path = '';

                                  Get.to(Box_Type());

                                }
                                    ,child: Icon(Icons.create,size: 42,color: Colors.red[500],)),
                                SizedBox(width: 24,),
                                Text("create new box",style: TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),

                          /// open box from repository

                          Container(
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                InkWell(onTap: () async{

                                  await draw_controller.read_Box_from_rebository();
                                  Get.to(Cabinet_Editor());

                                }
                                    ,child: Icon(Icons.file_open,size: 42,color: Colors.red[500],)),
                                SizedBox(width: 24,),
                                Text("open box from repository",style: TextStyle(fontSize: 16),)
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
        ),
      ),
    );

  }
}
