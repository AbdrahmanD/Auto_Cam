import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/CNC_Tool.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tools_Setting extends StatefulWidget {
  const Tools_Setting({Key? key}) : super(key: key);

  @override
  State<Tools_Setting> createState() => _Tools_SettingState();
}

class _Tools_SettingState extends State<Tools_Setting> {

  Draw_Controller draw_Controller = Get.find();



  TextEditingController tool_name_controller=TextEditingController();
  TextEditingController tool_num_controller=TextEditingController();
  TextEditingController tool_description_controller=TextEditingController();
  TextEditingController tool_diameter_controller=TextEditingController();
  TextEditingController tool_step_down_controller=TextEditingController();
  TextEditingController tool_feed_rate_speed_controller=TextEditingController();
  TextEditingController tool_plunge_rate_speed_controller=TextEditingController();
  TextEditingController spindle_speed_controller=TextEditingController();

  String     tool_name ="cut";
  int       tool_num =1;
  String    tool_description="cutting tool" ;
  double   tool_diameter =12;
  double   tool_step_down =12;
  int      tool_feed_rate_speed=100 ;
  int      tool_plunge_rate_speed =100;
  int      spindle_speed =10000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tool_name_controller.text="$tool_name";
    tool_num_controller.text="$tool_num";
    tool_description_controller.text="$tool_description";
    tool_diameter_controller.text="$tool_diameter";
    tool_step_down_controller.text="$tool_step_down";
    tool_feed_rate_speed_controller.text="$tool_feed_rate_speed";
    tool_plunge_rate_speed_controller.text="$tool_plunge_rate_speed";
    spindle_speed_controller.text="$spindle_speed";


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,height: 600,
      child: Column(
        children: [

          /// tool_name
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Container(width: 200,child: Text("tool name")),
                Container(width: 200,
                  child: TextFormField(
                    controller: tool_name_controller,
                  ),
                ),


              ],
            ),
          ),

          /// tool_position
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Container(width: 200,child: Text("tool num")),
                Container(width: 200,
                  child: TextFormField(
                    controller: tool_num_controller,
                  ),
                ),


              ],
            ),
          ),

          /// tool_description
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Container(width: 200,child: Text("tool description")),
                Container(width: 200,
                  child: TextFormField(
                    controller: tool_description_controller,
                  ),
                ),


              ],
            ),
          ),

          /// tool_diameter
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Container(width: 200,child: Text("tool diameter")),
                Container(width: 150,
                  child: TextFormField(
                    controller: tool_diameter_controller,
                  ),
                ),
                Container(width: 50,child: Text("mm")),


              ],
            ),
          ),

          /// tool_step_down
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Container(width: 200,child: Text("tool step down")),
                Container(width: 150,
                  child: TextFormField(
                    controller: tool_step_down_controller,
                  ),
                ),
                Container(width: 50,child: Text("mm")),


              ],
            ),
          ),

          /// tool_feed_rate_speed
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Container(width: 200,child: Text("tool feed rate speed ")),
                Container(width:150,
                  child: TextFormField(
                    controller: tool_feed_rate_speed_controller,
                  ),
                ),
                Container(width: 50,child: Text("M/Min")),


              ],
            ),
          ),

          /// tool_plunge_rate_speed
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Container(width: 200,child: Text("tool plunge rate speed")),
                Container(width: 150,
                  child: TextFormField(
                    controller: tool_plunge_rate_speed_controller,
                  ),
                ),
                Container(width: 50,child: Text("M/Min")),



              ],
            ),
          ),

          /// spindle_speed
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Container(width: 200,child: Text("spindle speed")),
                Container(width: 150,
                  child: TextFormField(
                    controller: spindle_speed_controller,
                  ),
                ),
                Container(width: 50,child: Text("R/Min")),


              ],
            ),
          ),



          SizedBox(
            height: 24,
          ),

          /// save or cancel button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(Get.overlayContext!).pop();

                },
                child: Container(
                  width: 70,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(child: Text('cancel')),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {

                  CNC_Tool cnc_tool = CNC_Tool(tool_name, tool_num, tool_description, tool_diameter, tool_step_down, tool_feed_rate_speed, tool_plunge_rate_speed, spindle_speed);

                  draw_Controller.box_repository.cnc_tools.add(cnc_tool);
                  Navigator.of(Get.overlayContext!).pop();

                 },
                child: Container(
                  width: 70,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.teal[300],
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(child: Text('Save')),
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
