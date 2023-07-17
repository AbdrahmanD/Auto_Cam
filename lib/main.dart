import 'package:auto_cam/Controller/MY_Binding.dart';
import 'package:auto_cam/View/Splash_Screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
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
