import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;



class Active_controller extends GetxController {
  int num = 0;
  int limit = 4;
  bool active = false;

  final my_setting_data = GetStorage();

  Active_controller() {

    if (kIsWeb) {

      active = true;


    } else {


      if (my_setting_data.read("installation_unique_key") == null)  {
        my_setting_data.write("installation_unique_key", generat_unique_code());
      }

      /// nun_limit_active
      if (my_setting_data.read("un_limit_active") != null &&
          my_setting_data.read("un_limit_active") == true) {
        active = true;
      }

      /// limit_active
      else if (my_setting_data.read("limit_active") != null &&
          my_setting_data.read("limit_active") == true)
      {
        if (my_setting_data.read("num") != null)
        {
          num = my_setting_data.read("num");

          if (num < limit) {
            active = true;
            num++;
            my_setting_data.write("num", num);
          }
          else{

            // print("num big =$num");

          }
        }
        else
        {
          active = true;
          num++;
          my_setting_data.write("num", num);
        }

      }


    }






  }

 String generat_unique_code(){

    DateTime now=DateTime.now();

    var second =now.minute;
    var      ran_1  =Random().nextInt(100);
    var minit  =now.hour;
    var      ran_2  =Random().nextInt(100);
    var hour   =now.day;
    var      ran_3  =Random().nextInt(100);
    var month  =now.month;
    var      ran_4  =Random().nextInt(100);
    var year   =now.year;
    var      ran_5  =Random().nextInt(100);

    String unique_key= "$second$ran_1$minit$ran_2$hour$ran_3$month$ran_4$year$ran_5";

    return unique_key;
  }

  String translate_active_code(String code){
String resault_code="" ;

String unique=my_setting_data.read("installation_unique_key");

String limit_active_key=limit_convert_code(unique);
String un_limit_active_key=un_limit_convert_code(unique);

    if(code==limit_active_key){
      resault_code="limit";
    }
    else if(code==un_limit_active_key){
      resault_code="un_limit";
    }else{
      resault_code="wrong";

    }

return resault_code;
  }

String limit_convert_code(String code){

    List<String> code_list=code.split("");
    List<String> genertated_code_list=[];
    for(String l in code_list){
      if(l=="0"){genertated_code_list.add("90");}
else  if(l=="1"){genertated_code_list.add("81");}
else  if(l=="2"){genertated_code_list.add("72");}
else  if(l=="3"){genertated_code_list.add("63");}
else  if(l=="4"){genertated_code_list.add("54");}
else  if(l=="5"){genertated_code_list.add("45");}
else  if(l=="6"){genertated_code_list.add("36");}
else  if(l=="7"){genertated_code_list.add("27");}
else  if(l=="8"){genertated_code_list.add("18");}
else  if(l=="9"){genertated_code_list.add("09");}

    }
    String resault=genertated_code_list.join();

    return resault;
}

String un_limit_convert_code(String code){

  List<String> code_list=code.split("");
  List<String> genertated_code_list=[];
  for(String l in code_list){
          if(l=="0"){genertated_code_list.add("9a");}
    else  if(l=="1"){genertated_code_list.add("8b");}
    else  if(l=="2"){genertated_code_list.add("7c");}
    else  if(l=="3"){genertated_code_list.add("6d");}
    else  if(l=="4"){genertated_code_list.add("5e");}
    else  if(l=="5"){genertated_code_list.add("4f");}
    else  if(l=="6"){genertated_code_list.add("3g");}
    else  if(l=="7"){genertated_code_list.add("2h");}
    else  if(l=="8"){genertated_code_list.add("1i");}
    else  if(l=="9"){genertated_code_list.add("0j");}

  }
  String resault=genertated_code_list.join();

  return resault;


}

   generate_limit_convert_code(String code){

    List<String> code_list=code.split("");
    List<String> genertated_code_list=[];
    for(String l in code_list){
      if(l=="0"){genertated_code_list.add("90");}
      else  if(l=="1"){genertated_code_list.add("81");}
      else  if(l=="2"){genertated_code_list.add("72");}
      else  if(l=="3"){genertated_code_list.add("63");}
      else  if(l=="4"){genertated_code_list.add("54");}
      else  if(l=="5"){genertated_code_list.add("45");}
      else  if(l=="6"){genertated_code_list.add("36");}
      else  if(l=="7"){genertated_code_list.add("27");}
      else  if(l=="8"){genertated_code_list.add("18");}
      else  if(l=="9"){genertated_code_list.add("09");}

    }
    String resault=genertated_code_list.join();

    print(resault) ;
  }



  check_active_code(String active_code){

    String code=translate_active_code(active_code);

    if(code=="limit"){
        my_setting_data.write("un_limit_active", false);
        my_setting_data.write("limit_active", true);
        my_setting_data.write("num", 3);

    }else if(code=="un_limit"){
      my_setting_data.write("un_limit_active", true);
       my_setting_data.write("limit_active", false);
      my_setting_data.write("num", 50000);

    }else if(code=="wrong"){
      my_setting_data.write("un_limit_active", false);
      my_setting_data.write("limit_active", false);
      my_setting_data.write("num", 0);

    }
return code;

  }


  clean_data() async {

    // my_setting_data.write("installation_unique_key", null);
    // my_setting_data.write("un_limit_active", false);
    // my_setting_data.write("limit_active", false);
    // my_setting_data.write("num", 0);

   // String installation_unique_key= await my_setting_data.read("installation_unique_key");
   // // String un_limit_active        = await my_setting_data.read("un_limit_active");
   // // String limit_active           = await my_setting_data.read("limit_active");
   // // String num                    = await my_setting_data.read("num");
   //
   //
   // //
   // print("=====================");
   print("${limit_convert_code("751266112726720240")}");
   // // print("un_limit_active         $un_limit_active        ");
   // // print("limit_active            $limit_active           ");
   // // print("num                     $num                    ");
   //
   //
   // print(limit_convert_code(installation_unique_key));
   // print("=====================");

  }


}
