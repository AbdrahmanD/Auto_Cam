
import 'package:auto_cam/Controller/MY_Binding.dart';
import 'package:auto_cam/View/Splash_Screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

void main() async {

  await GetStorage.init();

 runApp(
      GetMaterialApp(
          scrollBehavior: MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
          ),
      initialBinding: MY_Binding(),
      home: Splash_Screen()
  )
  );
}

/// good commit
