import 'package:auto_cam/View/Main_Screen.dart';
import 'package:auto_cam/View/View_Active_port.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {




  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
        Get.offAll(Main_Screen());

    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body:
      Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ Colors.grey, Colors.white,Colors.grey]
            )
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: h/4,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(22),
                ),
                child:
                Text(
                  "   AUTO CAM   ",
                  style: TextStyle(fontSize: w / 14, color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 64,
              ),
              Text(" Design  Wardrobes and kitchen cabinets \n get executive file Directly \n no cad ..  no cam .. "
                  "\n only ( AUTO CAM ) softwere",
                style: TextStyle(fontSize: 26, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
