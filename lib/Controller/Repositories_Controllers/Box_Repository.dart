import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:get/get.dart';

class Box_Repository extends GetxController{

   Rx<Box_model> box_model=Box_model(400, 600, 600, 18, 6).obs;

  Box_Repository();



}