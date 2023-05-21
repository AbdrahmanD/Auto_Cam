
import 'dart:io';

import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';



class Excel_Controller extends GetxController {
  late Directory myDir;

  Excel_Controller(){
  }

  create_excel( Box_model my_box) async {

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory newDirectory = Directory('${appDocDir.path}/Cutting_Lists');
    newDirectory.createSync();

    final path = newDirectory.path;
    File file= File('$path/my_box_cut_list.xlsx');



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

    ///
    ///

int n=2;
    for(int i=0;i<my_box.box_pieces.length;i++){

      if(my_box.box_pieces[i].piece_name=='inner'){
        continue;
      }else {

        var title1 = sheet.cell(CellIndex.indexByString('A$n'));
        title1.value = '${n}';
        var title2 = sheet.cell(CellIndex.indexByString('B$n'));
        title2.value = '${my_box.box_pieces[i].piece_name}';
        var title3 = sheet.cell(CellIndex.indexByString('C$n'));
        title3.value = '${my_box.box_pieces[i].Piece_thickness}';
        var title4 = sheet.cell(CellIndex.indexByString('D$n'));
        title4.value = '${my_box.box_pieces[i].material_name}';
        var title5 = sheet.cell(CellIndex.indexByString('E$n'));
        title5.value = '${my_box.box_pieces[i].Piece_height}';
        var title6 = sheet.cell(CellIndex.indexByString('F$n'));
        title6.value = '${my_box.box_pieces[i].Piece_width}';
        var title7 = sheet.cell(CellIndex.indexByString('G$n'));
        title7.value = '${1}';
        n++;
      }
    }


    List<int>? fileBytes = excel.save();

    //print('saving executed in ${stopwatch.elapsed}');
    if (fileBytes != null) {
      File(file.path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }


  }

}










