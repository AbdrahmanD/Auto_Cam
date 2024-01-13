
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class Active_controller extends GetxController{


  int num=0;
  int limit=0;
  bool active=false;

  final my_setting_data  = GetStorage();

  Active_controller(){


    if(my_setting_data.read("set")==null){
      active=false;

    }
    else{
      active =my_setting_data.read("active");

    }





  }




}