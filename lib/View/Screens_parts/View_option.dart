import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class View_option extends StatefulWidget {
  const View_option({Key? key}) : super(key: key);

  @override
  State<View_option> createState() => _View_optionState();
}

class _View_optionState extends State<View_option> {
  Draw_Controller draw_controller=Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container( color: Colors.grey[300],
        width: 100,height: MediaQuery.of(context).size.height,
        child: Column(
          children: [

            SizedBox(height: 56,),
            /// change view to : 2D
            InkWell(onTap: (){
              draw_controller.draw_3_D.value=false;

            },

              child: Container(width: 75,height: 50,
                color: Colors.teal[400],
                child: Center(child: Text('2D',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(height: 24,),

            /// change view to : 3D
            InkWell(onTap: (){
              draw_controller.draw_3_D.value=true;

            },

              child: Container(width: 75,height: 50,
                color: Colors.teal[400],
                child: Center(child: Text('3D',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
              ),
            ),
            SizedBox(height: 24,),

            /// change view to : Top
            InkWell(onTap: (){

            },

              child: Container(width: 75,height: 50,
                color: Colors.teal[400],
                child: Center(child: Text('Top',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
              ),
            ),
            SizedBox(height: 24,),

            /// change view to : Right
            InkWell(onTap: (){

            },

              child: Container(width: 75,height: 50,
                color: Colors.teal[400],
                child: Center(child: Text('Right',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
              ),
            ),
            SizedBox(height: 24,),


            /// change view to : Front
            InkWell(onTap: (){

            },

              child: Container(width: 75,height: 50,
                color: Colors.teal[400],
                child: Center(child: Text('Front',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
              ),
            ),




          ],
        ),
      ),
    );
  }
}
