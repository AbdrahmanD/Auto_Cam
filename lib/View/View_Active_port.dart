
import 'package:auto_cam/Controller/Active_controller.dart';
import 'package:auto_cam/View/Main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class View_Active_port extends StatefulWidget {
  const View_Active_port({Key? key}) : super(key: key);

  @override
  State<View_Active_port> createState() => _View_Active_portState();
}

class _View_Active_portState extends State<View_Active_port> {


  bool password=false;
  TextEditingController password_controller = TextEditingController();
  TextEditingController limit_controller = TextEditingController();


  final my_setting_data  = GetStorage();

  late bool active=false;



  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(title: Text("setting Page"),),
      body: Container(width: w,height: h,
        child:
        Row(

          children: [

            SizedBox(width: 100,),
            ///password field
         !password ? Container(width:400,height: h-200,color: Colors.grey[200],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: password_controller,
                  obscureText:true,
                  decoration: InputDecoration(

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(32),
                child: InkWell(
                  onTap: () {

                    String entered_password=password_controller.text.toString();
                    String original_password="A1b2d3s4t4e5p6o7r8w9123";

                    if (entered_password==original_password) {
                      password=true;
                      setState(() {

                      });
                    }

                  },
                  child: Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(
                          'open setting page',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ),
              ),


            ],
          ),
        ):SizedBox(width:400,),

          password ? Container(width: w/3,height: h-100,color: Colors.teal[200],
          child: Column(
            children: [

              SizedBox(width: 50,),


              /// limit
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: limit_controller,
                  obscureText:true,

                  decoration: InputDecoration(

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'please add value';
                    }
                  },
                ),
              ),
              SizedBox(height: 32,),


              Text("3"),
              SizedBox(height: 32,),

              Checkbox(value: active, onChanged: (v){

                active=!active;

                setState(() {

                });
              }),

              ///save
              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 52, top: 18, bottom: 18),
                child: InkWell(
                  onTap: () {


                   String limit=limit_controller.text.toString();

                    if(limit=="develo123androi321java123") {
                      my_setting_data.write("set", true);
                      // my_setting_data.write("limit", limit);
                      my_setting_data.write("active", active);
                    }
                      Get.to(Main_Screen());

                      Get.to(Main_Screen());




                  },
                  child: Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(
                          'save',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 32,),


            ],
          ),
        ):SizedBox(),

          ],
    )));

  }
}
