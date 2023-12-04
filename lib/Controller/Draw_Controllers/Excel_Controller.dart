
import 'dart:io';

import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Cut_List_Item.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';



class Excel_Controller extends GetxController {



  Draw_Controller draw_controller = Get.find();

  create_excel() async {


    String? directory0 = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'box name',
    );

    String file_name=directory0!.split("/")[directory0!.split("/").length-1];
    String new_directory_0 =directory0!.split('/').sublist(0,directory0!.split("/").length-1).join("/");


    final Directory newDirectory = Directory('$new_directory_0');
    newDirectory.createSync();

    File file= File('${newDirectory.path}/$file_name.xlsx');


    var excel = Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    var sheet = excel['mySheet'];
    excel.setDefaultSheet(sheet.sheetName);


    ///
    ///titles

    var title1=sheet.cell(CellIndex.indexByString('A1'));title1.value='n';
    var title2=sheet.cell(CellIndex.indexByString('B1'));title2.value='name';
    var title3=sheet.cell(CellIndex.indexByString('C1'));title3.value='thickness';
    var title4=sheet.cell(CellIndex.indexByString('D1'));title4.value='material';
    var title5=sheet.cell(CellIndex.indexByString('E1'));title5.value='Width';
    var title6=sheet.cell(CellIndex.indexByString('F1'));title6.value='Height';
    var title7=sheet.cell(CellIndex.indexByString('G1'));title7.value='Quantity';

    ///
    ///

int n=2;

    List<Cut_List_Item> p = draw_controller.box_repository.cut_list_items;

    for(int i=0;i<p.length;i++){


        var title1 = sheet.cell(CellIndex.indexByString('A$n'));
        title1.value = '${n-1}';
        var title2 = sheet.cell(CellIndex.indexByString('B$n'));
        title2.value = '${p[i].pieces_names}';
        var title3 = sheet.cell(CellIndex.indexByString('C$n'));
        title3.value = '${p[i].material_thickness}';
        var title4 = sheet.cell(CellIndex.indexByString('D$n'));
        title4.value = '${p[i].material_name}';
        var title5 = sheet.cell(CellIndex.indexByString('E$n'));
        title5.value = '${p[i].width}';
        var title6 = sheet.cell(CellIndex.indexByString('F$n'));
        title6.value = '${p[i].hight}';
        var title7 = sheet.cell(CellIndex.indexByString('G$n'));
        title7.value = "${p[i].quantity}";

        n++;

    }


    List<int>? fileBytes = excel.save();

    if (fileBytes != null) {
      File(file.path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }


  }

}










