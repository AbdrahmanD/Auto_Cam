import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:auto_cam/Controller/Draw_Controllers/AnalyzeJoins.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/project/Project_Painter.dart';
import 'package:auto_cam/project/Project_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class Project_Controller extends GetxController {


  RxDouble drawing_scale = (0.5).obs;
  Rx<Size> screen_size = Size(800, 600).obs;
  Rx<Offset> mouse_position = Offset(0, 0).obs;

  Box_Repository box_repository = Get.find();
  Draw_Controller draw_controller = Get.find();

  RxString view_port = 'F'.obs;
  int hover_id = 100;
  RxInt selected_id = 100.obs;
  bool hold_box = true;
  bool inserting = false;
  RxBool draw_3_D = false.obs;

  RxString my_print="my_print".obs;


  List<List<Point_model>> corners = [];
  List<Point_model> selected_box_corners = [];
  List<Point_model> all_corners = [];


  hovered_Box() {
    Project_model p = box_repository.project_model;

    bool have_hover_box = false;

    for (int i = 0; i < p.boxes.length; i++) {
      Box_model b = p.boxes[i];
      double x = b.box_origin.x_coordinate * drawing_scale.value +
          screen_size.value.width / 2;
      double y = b.box_origin.y_coordinate * drawing_scale.value +
          screen_size.value.height / 2;
      double z = b.box_origin.z_coordinate * drawing_scale.value;
      double w = b.box_width * drawing_scale.value;
      double h = b.box_height * drawing_scale.value;
      double d = b.box_depth * drawing_scale.value;

      Point_model sp = Point_model(x, y, z);
      Point_model ep = Point_model(x + w, y - h, z + d);

      bool x_combare = (mouse_position.value.dx > sp.x_coordinate) &&
          (mouse_position.value.dx < ep.x_coordinate);
      bool y_combare = (mouse_position.value.dy < sp.y_coordinate) &&
          (mouse_position.value.dy > ep.y_coordinate);

      if (x_combare && y_combare) {
        hover_id = i;
        have_hover_box = true;
      }
    }
    if ((!have_hover_box)) {
      hover_id = 100;
    }
  }

  move_project(Offset offset) {
    for (Box_model b in box_repository.project_model.boxes) {
      b.box_origin.x_coordinate += offset.dx / drawing_scale.value;
      b.box_origin.y_coordinate += offset.dy / drawing_scale.value;
    }
  }


  snap_to_box() {

    corners = [];
    selected_box_corners = [];
    all_corners = [];


    if (selected_id.value != 100) {


      Box_model b = box_repository.project_model.boxes[selected_id.value];

      Point_model c1 = b.box_origin;
      Point_model c2 = Point_model(b.box_origin.x_coordinate + b.box_width,
          b.box_origin.y_coordinate, b.box_origin.z_coordinate);
      Point_model c3 = Point_model(b.box_origin.x_coordinate + b.box_width,
          b.box_origin.y_coordinate - b.box_height, b.box_origin.z_coordinate);
      Point_model c4 = Point_model(b.box_origin.x_coordinate,
          b.box_origin.y_coordinate - b.box_height, b.box_origin.z_coordinate);

      selected_box_corners.add(c1);
      selected_box_corners.add(c2);
      selected_box_corners.add(c3);
      selected_box_corners.add(c4);



      for (int si = 0; si < box_repository.project_model.boxes.length; si++)
      {
        if (si == selected_id.value){
           continue;}
        else{

          Box_model sb = box_repository.project_model.boxes[si];

          Point_model sc1 = sb.box_origin;
          Point_model sc2 = Point_model(
              sb.box_origin.x_coordinate + sb.box_width,
              sb.box_origin.y_coordinate,
              sb.box_origin.z_coordinate);
          Point_model sc3 = Point_model(
              sb.box_origin.x_coordinate + sb.box_width,
              sb.box_origin.y_coordinate - sb.box_height,
              sb.box_origin.z_coordinate);
          Point_model sc4 = Point_model(
              sb.box_origin.x_coordinate,
              sb.box_origin.y_coordinate - sb.box_height,
              sb.box_origin.z_coordinate);

          all_corners.add(sc1);
          all_corners.add(sc2);
          all_corners.add(sc3);
          all_corners.add(sc4);

        }

      }

      for (int i = 0; i < selected_box_corners.length; i++) {


        Point_model p = selected_box_corners[i];

        double x = p.x_coordinate;
        double y = p.y_coordinate;

        for (int t = 0; t < all_corners.length; t++) {
          Point_model tp = all_corners[t];

          double sx = tp.x_coordinate;
          double sy = tp.y_coordinate;

          bool x_compare= (x-sx).abs()<50;
          bool y_compare= (y-sy).abs()<50;

          if(x_compare && y_compare){

            corners.add([p,tp]);

         }
        }
      }

    }
  }

  finish_draging(){


    if (selected_id.value!=100) {

      Point_model p1 = corners[0][0];
      Point_model p2 = corners[0][1];
      double x_value;
      double y_value;

      x_value=(p2.x_coordinate-p1.x_coordinate);
      y_value=(p2.y_coordinate-p1.y_coordinate);


     move_box(Offset(x_value,y_value));

        // selected_id.value=100;

    }

    // my_print.value=" "
    //     "selected_id: ${selected_id.value} \n"
    //     "corners: ${corners.length} \n"
    //     "selected_box_corners: ${selected_box_corners.length} \n"
    //     "all_corners: ${all_corners.length} \n"
    //     "corners[0].length: ${corners[0].length} \n"
    //     "corners[1].length: ${corners[1].length} \n"
    //     "corners [0][0]: ${corners[0][0].x_coordinate} \n"
    //     "corners [0][1]: ${corners[0][1].x_coordinate} \n"
    //     "selected id : ${selected_id.value} \n ";
    //


  }

  select_box() {}

  insert_box() {
    hold_box = true;
    add_box_to_project();
  }

  delete_box() {
    box_repository.box_model.value =
        box_repository.project_model.boxes.removeAt(selected_id.value);
    selected_id.value = 100;
    hover_id = 100;
  }

  move_box(Offset offset) {
    box_repository.project_model.boxes[selected_id.value].box_origin
        .x_coordinate += offset.dx;
    box_repository.project_model.boxes[selected_id.value].box_origin
        .y_coordinate += offset.dy;
  }

  drag_box(Offset offset) {
    snap_to_box();

    if (selected_id.value != 100) {
      box_repository.project_model.boxes[selected_id.value].box_origin
          .x_coordinate += offset.dx / drawing_scale.value;
      // ((mouse_position.value.dx) / drawing_scale.value) -
      //     (screen_size.value.width / drawing_scale.value) / 2;
      box_repository.project_model.boxes[selected_id.value].box_origin
          .y_coordinate += offset.dy / drawing_scale.value;
      // (mouse_position.value.dy / drawing_scale.value) -
      //     (screen_size.value.height / drawing_scale.value) / 2;
    }
  }

  mouse_left_click(Offset offset, bool sheft_hold) {

    selected_id.value = hover_id;
    if (!sheft_hold) {
      hold_box = false;
      inserting = false;
    }
    draw_project();

  }

  Project_Painter draw_project() {
    if ((hold_box && inserting)) {
      box_repository
              .project_model
              .boxes[box_repository.project_model.boxes.length - 1]
              .box_origin
              .x_coordinate =
          ((mouse_position.value.dx) / drawing_scale.value) -
              (screen_size.value.width / drawing_scale.value) / 2;
      box_repository
              .project_model
              .boxes[box_repository.project_model.boxes.length - 1]
              .box_origin
              .y_coordinate =
          (mouse_position.value.dy / drawing_scale.value) -
              (screen_size.value.height / drawing_scale.value) / 2;
    }

    hovered_Box();
    Project_Painter project_painter = Project_Painter(
        box_repository.project_model,
        drawing_scale.value,
        screen_size.value,
        hover_id,
        selected_id.value,
        view_port.value,
        corners,
        mouse_position.value);

    snap_to_box();

    return project_painter;
  }

  add_box_to_project() async {
    Box_model box_model = await draw_controller.read_Box_from_rebository();
    box_repository.project_model.boxes.add(box_model);

    if (box_repository.project_model.boxes.length == 0) {
      box_model.box_origin = Point_model(0, 0, 0);
    } else {
      inserting = true;
    }
  }

  read_Project_from_rebository() async {
    String path = await draw_controller.open_File();

    File f = File("$path");
    String content = await f.readAsString();

    Project_model project_model = Project_model.fromjson(json.decode(content));

    box_repository.project_model = project_model;
  }

  save_project() async {
    if (box_repository.project_have_been_saved) {
      String jsonData = jsonEncode(box_repository.project_model.toJson());
      File file = File(box_repository.project_file_path!);
      file.writeAsStringSync(jsonData);
    } else {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: 'box name',
      );

      if (outputFile == null) {}

      try {
        String jsonData = jsonEncode(box_repository.project_model.toJson());
        File file = File(outputFile!);
        file.writeAsStringSync(jsonData);
        box_repository.project_file_path = outputFile;
        box_repository.project_have_been_saved = true;
      } catch (e) {
        print('Error writing JSON data to the file: $e');
      }
    }
  }


  extract_cutList(){

    AnalyzeJoins analyzeJoins=AnalyzeJoins(true);



  }


}
