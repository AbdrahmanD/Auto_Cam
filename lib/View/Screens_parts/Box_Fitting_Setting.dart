import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Box_Fix_pattern_Pienter.dart';
import 'package:auto_cam/Controller/Painters/Pattern_Painter.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/View/Screens_parts/Box_Fitting_Editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Box_Fitting_Setting extends StatefulWidget {
  const Box_Fitting_Setting({Key? key}) : super(key: key);

  @override
  State<Box_Fitting_Setting> createState() => _Box_Fitting_SettingState();
}

class _Box_Fitting_SettingState extends State<Box_Fitting_Setting> {
  ScrollController crt = ScrollController();

  bool screw = false;

  double d1=46;
  double d2=150;
  double d3=46;

  Draw_Controller draw_controller = Get.find();

  String corrent_setting = " SETTING - KD patterns ";
  String category = "Box_Fitting_DRILL";

  List<JoinHolePattern> list_boxes_fitting = [];

  // JoinHolePattern corrent_join_pattern =
  // JoinHolePattern('name', 150, 760,0,0, [], true);

  int pattern_index=0;

  read_patterns() async {
    list_boxes_fitting = [];


    await draw_controller.read_pattern_files();

    Map<String, List<JoinHolePattern>> join_patterns =
        draw_controller.box_repository.join_patterns;

    list_boxes_fitting = join_patterns["Box_Fitting_DRILL"]!;

    setState(() {});
  }

  add_new_pattern(){

  }



  
  @override
  void initState() {

    read_patterns();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    JoinHolePattern corrent_join_pattern =list_boxes_fitting[pattern_index];

    return Scaffold(
      appBar: AppBar(
          title:Text(corrent_setting)
      ),
      body: Row(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 200,height: h,
                  color: Colors.grey[100],
                  child:
                  Column(
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      ///title : List of patterns
                      Text(
                        "List of patterns ",
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      /// pattern listview builder
                      Container(
                        width: 200,height: h-300,

                        child: ListView.builder(
                          itemCount: list_boxes_fitting.length,
                          itemBuilder: (context,index){

                            return   Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(

                                /// chose pattern
                                onTap: (){

                                  pattern_index=index;

                                  setState(() {});

                                  },

                                child: Text("${list_boxes_fitting[index].name}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      /// add new pattern button
                      InkWell(
                        onTap: (){
                          add_new_pattern();
                          },
                        child: Container(width: 150,height: 50,child: Center(child: Text("NEW PATTERN")),

                        decoration: BoxDecoration(color:Colors.teal[300],borderRadius: BorderRadius.circular(12)),),
                      )
                    ],
                  )

                ),


                Container(
                  width:w-200,height:h,
                  child:Column(
                    children: [
                      Container(
                        width: w-200,height: 142,
                      ),
                      Container(
                        height: h-200, width: w-200,
                        color: Colors.grey[300],
                        child:Box_Fitting_Editor(w-200,h-200,corrent_join_pattern,draw_controller.box_repository.box_model.value.init_material_thickness)

                      ),

                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

