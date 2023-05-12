
import 'dart:io';

import 'package:get/get.dart';



class Excel_Controller extends GetxController {


  createmyexcel() async {
    final folderName = '/Users/abdulrahman/Desktop/a1';
    final fileName = 'myFile.txt';

    // Create folder
    final folder = Directory('$folderName');
    folder.createSync();

    // Create file inside the folder
    final file = File('${folder.path}/$fileName');
    file.createSync();

    // Write to the file
    file.writeAsStringSync('Hello, world!');

    // Read from the file
    final contents = file.readAsStringSync();
    print(contents);
  }








}


