import 'dart:ui';

import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:auto_cam/Model/Main_Models/Box_Pieces_Arrang.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/CNC_Tool.dart';
import 'package:auto_cam/Model/Main_Models/Cut_List_Item.dart';
import 'package:auto_cam/Model/Main_Models/Drawer_Rail_Brand.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/project/Project_model.dart';
import 'package:get/get.dart';

class Box_Repository extends GetxController {
  double top_base_piece_width = 100;

  double pack_panel_thickness = 0;
  double pack_panel_grove_depth = 9;
  double pack_panel_distence = 0;


  Rx<Box_model> box_model = Box_model('box_name', "wall_cabinet", 400, 600, 500,
          18, 'MDF', 5, 9, 18, 100, true, Point_model(0, 0, 0))
      .obs;



  String back_panel_type = "full_cover";



  Project_model project_model =
      Project_model("current project", 1, 1, 2023, "", "", []);

  Map<String, List<JoinHolePattern>> join_patterns =
  {
    "Box_Fitting_DRILL": [],
    "Flexible_Shelves": [],
    "Drawer_Face": [],
    "Drawer_Rail_Box" : [],
    "Drawer_Rail_Side": [],
    "Door_Hinges": [],
    "side_Hinges": [],
    "Groove": [],
  };

  List brands =[].obs();



  List<Cut_List_Item> cut_list_items = [];

  List<CNC_Tool> cnc_tools = [
    CNC_Tool("cut", 1, "cutting tool", 12, 18, 100, 100, 10000)
  ];

  Nesting_Pieces nesting_pieces = Nesting_Pieces([], 12);

  bool nesting_pieces_saves = false;

  bool box_have_been_saved = false;
  String box_file_path = '';

  bool project_have_been_saved = false;
  String project_file_path = '';

  List<My_Sheet> repo_sheerts = [];




  Box_Repository();

  add_box_to_repo(Box_model b) {

    box_model.value.box_pieces=b.box_pieces;
    box_model.value = b;

  }

  add_box_to_project(Box_model box_model) {
    project_model.boxes.add(box_model);
  }


  Box_Pieces_Arrang arrange_box(Box_model b){

    Box_Pieces_Arrang box_pieces_arrang =Box_Pieces_Arrang(box_model.value);

    return box_pieces_arrang;
  }

  enable_Piece(Piece_model p ,bool enable){

    int index=  box_model.value.box_pieces.indexWhere((element) => element.piece_id==p.piece_id);

    box_model.value.box_pieces[index].piece_inable=enable;

Box_model nb=box_model.value;

add_box_to_repo(nb);

  }







}
