
import 'package:auto_cam/View/Screens_parts/Box_Type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Main_Screen extends StatelessWidget {

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
                height: 64,
              ),

              // auto cam lable
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
                          "Project",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(Project_Screen());
                            Get.defaultDialog(title:'ERROR',content: Text('sorry , this choice not ready yet'));

                          },
                          child: Container(
                              height: 150,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/pr.png",
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "build full project ,like wardrobes or kitchens",
                            style: TextStyle(fontSize: 14),
                          ),
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
                          "Single Cabinet",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(Box_Type());
                          },
                          child: Container(
                              height: 150,
                              // color: Colors.red,
                              child: Image.asset(
                                "lib/assets/images/sc.png",
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "build single cabinet to use alone or in project",
                            style: TextStyle(fontSize: 14),
                          ),
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
