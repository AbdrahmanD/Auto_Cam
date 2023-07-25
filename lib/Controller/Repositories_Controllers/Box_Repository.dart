import 'package:auto_cam/Model/Main_Models/Box_model.dart';
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






  Rx<Box_model> box_model=Box_model("test",400, 600, 600, 18,'MDF', 6,true,"wall_box").obs;

  Box_Repository();



}