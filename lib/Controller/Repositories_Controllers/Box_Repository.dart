import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:get/get.dart';

class Box_Repository extends GetxController{

   Rx<Box_model> box_model=Box_model("test",400, 600, 600, 18,'MDF', 6,true,"wall_box").obs;

  Box_Repository();



}