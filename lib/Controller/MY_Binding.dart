import 'package:auto_cam/Controller/Active_controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Excel_Controller.dart';
import 'package:auto_cam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam/Controller/nesting/Neting_Controller.dart';
import 'package:auto_cam/project/Projecet_Controller.dart';
import 'package:get/get.dart';

class MY_Binding extends Bindings{

  @override
  void dependencies() {

   Get.lazyPut(()=> Box_Repository());
   Get.lazyPut(()=> Excel_Controller());
   Get.lazyPut(()=> Draw_Controller());
   Get.lazyPut(()=> Neting_Controller());
   Get.lazyPut(()=> Project_Controller());
   Get.lazyPut(()=> Active_controller());


  }

}