import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:get/get.dart';

class Box_Repository extends GetxController{


  double absolute_fix_distence_standerd=32;
  double absolute_fix_distence_small=25;
  double absolute_fix_distence_midume=30;
  double absolute_fix_distence_big=50;



  double wood_pen_diameter=8;
  double wood_pen_horizontal_depth=30;
  double wood_pen_vertical_depth=10;

  double nut_pen_diameter=10;
  double nut_pen_depth=11;

  double minifix_diameter=15;
  double minifix_depth=14;
  double minifix_distence=32;


  double top_base_piece_width=100;

  double pack_panel_grove_depth=9;
  double pack_panel_distence=18;


  Rx<Box_model> box_model=Box_model(
      'box_name',"wall_cabinet", 400, 600, 500, 18, 'MDF',5,
      9,18,
      100,  true, Point_model(0,0,0)).obs;

  Map<String,double> drawers_types_values={'normal_side':26,"concealed_hafle_1":10};

  Box_Repository();

  add_box_to_repo(Box_model b){
    box_model.value=b;
  }


}