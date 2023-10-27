
import 'dart:io';

import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';



class Excel_Controller extends GetxController {


  create_excel( Box_model my_box) async {

    String box_name=my_box.box_name;

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory oldDirectory = Directory('${appDocDir.path}/Auto_Cam');
    oldDirectory.createSync();

    final Directory newDirectory = Directory('${oldDirectory.path}/$box_name');
    newDirectory.createSync();

    final path = newDirectory.path;
    File file= File('$path/$box_name.xlsx');



    var excel = Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    var sheet = excel['mySheet'];
    excel.setDefaultSheet(sheet.sheetName);


    ///
    ///titles

    var title1=sheet.cell(CellIndex.indexByString('A1'));title1.value='n';
    var title2=sheet.cell(CellIndex.indexByString('B1'));title2.value='name';
    var title3=sheet.cell(CellIndex.indexByString('C1'));title3.value='thickness';
    var title4=sheet.cell(CellIndex.indexByString('D1'));title4.value='material';
    var title5=sheet.cell(CellIndex.indexByString('E1'));title5.value='Height';
    var title6=sheet.cell(CellIndex.indexByString('F1'));title6.value='Width';
    var title7=sheet.cell(CellIndex.indexByString('G1'));title7.value='Quantity';
    var title8=sheet.cell(CellIndex.indexByString('H1'));title8.value='copy';

    ///
    ///

int n=2;
    for(int i=0;i<my_box.box_pieces.length;i++){

      if(my_box.box_pieces[i].piece_name=='inner' ||my_box.box_pieces[i].piece_name.contains("HELPER")|| my_box.box_pieces[i].is_changed || !my_box.box_pieces[i].piece_inable){
        continue;
      }else {

        var title1 = sheet.cell(CellIndex.indexByString('A$n'));
        title1.value = '${n}';
        var title2 = sheet.cell(CellIndex.indexByString('B$n'));
        title2.value = '${my_box.box_pieces[i].piece_name}';
        var title3 = sheet.cell(CellIndex.indexByString('C$n'));
        title3.value = '${my_box.box_pieces[i].piece_thickness}';
        var title4 = sheet.cell(CellIndex.indexByString('D$n'));
        title4.value = '${my_box.box_pieces[i].material_name}';
        var title5 = sheet.cell(CellIndex.indexByString('E$n'));
        title5.value = '${my_box.box_pieces[i].piece_height}';
        var title6 = sheet.cell(CellIndex.indexByString('F$n'));
        title6.value = '${my_box.box_pieces[i].piece_width}';
        var title7 = sheet.cell(CellIndex.indexByString('G$n'));
        title7.value = '1}';
        var title8 = sheet.cell(CellIndex.indexByString('H$n'));
        title8.value = '${my_box.box_pieces[i].is_changed}';
        n++;
      }
    }


    List<int>? fileBytes = excel.save();

    if (fileBytes != null) {
      File(file.path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }


  }

}










