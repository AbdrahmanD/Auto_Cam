import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:get/get.dart';

class Box_Repository extends GetxController{


  double standerd_distence=32;

  double start_distence_small=25;
  double start_distence_big=50;

  double small_length_limit=100;
  double medium_length_limit=150;
  double larg_length_limit=300;
  double X_larg_length_limit=500;




  double wood_pen_diameter=8;
  double wood_pen_horizontal_depth=30;
  double wood_pen_vertical_depth=10;

  double scew_nut_diameter=10;
  double scew_nut_depth=11;

  double minifix_diameter=15;
  double minifix_depth=14;
  double minifix_distence=33;


  double top_base_piece_width=100;

  double pack_panel_grove_depth=9;
  double pack_panel_distence=18;

  List<JoinHolePattern> join_patterns=[];


  Rx<Box_model> box_model=Box_model(
      'box_name',"wall_cabinet", 400, 600, 500, 18, 'MDF',5,
      9,18,
      100,  true, Point_model(0,0,0)).obs;

  Box_Repository();

  add_box_to_repo(Box_model b){
    box_model.value=b;
  }


}