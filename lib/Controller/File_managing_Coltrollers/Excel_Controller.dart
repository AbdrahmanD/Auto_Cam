
import 'dart:io';

import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';



class Excel_Controller extends GetxController {
  late Directory myDir;

  Excel_Controller(){
    my_Directory();

  }

  my_Directory() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory newDirectory = Directory('${appDocDir.path}/Cutting Lists');
    newDirectory.createSync();
    myDir= newDirectory;
  }

  Future<File> get my_file_path async {
    final path = myDir.path;
    return File('$path/my_box_cut_list.xlsx');
  }


  create_excel(Box_model my_box)async{

    var excel = Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    var sheet = excel['mySheet'];
    excel.setDefaultSheet(sheet.sheetName);
    ///
    ///titles

    var title4=sheet.cell(CellIndex.indexByString('A1'));title4.value='name';
    var title5=sheet.cell(CellIndex.indexByString('B1'));title5.value='thickness';
    var title6=sheet.cell(CellIndex.indexByString('C1'));title6.value='material';
    var title1=sheet.cell(CellIndex.indexByString('D1'));title1.value='Height';
    var title2=sheet.cell(CellIndex.indexByString('E1'));title2.value='Width';
    var title3=sheet.cell(CellIndex.indexByString('F1'));title3.value='Quantity';

    ///
    ///


    for(int i=0;i<my_box.box_pieces.length;i++){


      var title4=sheet.cell(CellIndex.indexByString('A$i'));title4.value='${my_box.box_pieces[i].piece_name}';
      var title5=sheet.cell(CellIndex.indexByString('B$i'));title5.value='${my_box.box_pieces[i].Piece_thickness}';
      var title6=sheet.cell(CellIndex.indexByString('C$i'));title6.value='${my_box.box_pieces[i].material_name}';
      var title1=sheet.cell(CellIndex.indexByString('D$i'));title1.value='${my_box.box_pieces[i].Piece_height}';
      var title2=sheet.cell(CellIndex.indexByString('E$i'));title2.value='${my_box.box_pieces[i].Piece_width}';
      var title3=sheet.cell(CellIndex.indexByString('F$i'));title3.value='${1}';


    }


    List<int>? fileBytes = excel.save();
    final file = await my_file_path;


    //print('saving executed in ${stopwatch.elapsed}');
    if (fileBytes != null) {
      File(file.path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }
  }

}










