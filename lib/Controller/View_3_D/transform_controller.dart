import 'dart:math' as math;
import 'dart:ui';
import 'package:auto_cam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam/Controller/View_3_D/CameraTransformer.dart';
import 'package:auto_cam/Controller/Painters/three_D_Painter.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class transform_controller {

  double scale = 0.7;

  late Point_model camera_position;

  Box_Repository box_repository = Get.find();

  double a1=math.pi/24;
  double a2=-math.pi/6;
  double a3=math.pi/12;

 late  CameraTransformer cameraTransformer ;
  late Size screen_size;

  transform_controller(this.screen_size ){
     camera_position=Point_model(screen_size.width/2, screen_size.height/2, 0);
  }


  /// /////////////////////////////////////////////////////
  /// /////////////////////////////////////////////////////




  three_D_Painter camera_cordinate_draw(Size screen_size  ){

    cameraTransformer = CameraTransformer(
        camera_position.x_coordinate, camera_position.y_coordinate, camera_position.z_coordinate,
        a1, a2, a3
    );


    // print(a1);
    // print(a2);
    // print(a3);
    // print("###########");

    Box_model b=box_repository.box_model.value;

    Box_model box_model=Box_model(b.box_name, b.box_type, b.box_width, b.box_height, b.box_depth,
        b.init_material_thickness, b.init_material_name, b.back_panel_thickness,
        b.grove_value, b.bac_panel_distence, b.top_base_piece_width, b.is_back_panel, Point_model(0,0,0));

    box_model.box_pieces=[];

    for(int i=0;i<b.box_pieces.length;i++){
  Piece_model p = Piece_model(b.box_pieces[i].piece_id, b.box_pieces[i].piece_name,
      b.box_pieces[i].piece_direction, b.box_pieces[i].material_name,
      b.box_pieces[i].piece_width, b.box_pieces[i].piece_height,
      b.box_pieces[i].piece_thickness, b.box_pieces[i].piece_origin);
  box_model.box_pieces.add(p);
}

    for(int i=0;i<box_model.box_pieces.length;i++){

      Piece_model p =box_model.box_pieces[i];

       p.piece_faces.faces[4].corners[0]=cameraTransformer.transform(p.piece_faces.faces[4].corners[0]);
       p.piece_faces.faces[4].corners[1]=cameraTransformer.transform(p.piece_faces.faces[4].corners[1]);
       p.piece_faces.faces[4].corners[2]=cameraTransformer.transform(p.piece_faces.faces[4].corners[2]);
       p.piece_faces.faces[4].corners[3]=cameraTransformer.transform(p.piece_faces.faces[4].corners[3]);
       p.piece_faces.faces[5].corners[0]=cameraTransformer.transform(p.piece_faces.faces[5].corners[0]);
       p.piece_faces.faces[5].corners[1]=cameraTransformer.transform(p.piece_faces.faces[5].corners[1]);
       p.piece_faces.faces[5].corners[2]=cameraTransformer.transform(p.piece_faces.faces[5].corners[2]);
       p.piece_faces.faces[5].corners[3]=cameraTransformer.transform(p.piece_faces.faces[5].corners[3]);



    }

    List<LineWithType> NLineWithType=[];

    for(int w=0;w<my_web().length;w++){

      LineWithType old_line=my_web()[w];

      List<Line> new_lines=[];

      for(int l=0;l<old_line.lines.length;l++){
        Line nLine=Line(
            cameraTransformer.transform(old_line.lines[l].start_point),
            cameraTransformer.transform(old_line.lines[l].end_point)
        );
        new_lines.add(nLine);
      }
      NLineWithType.add(LineWithType(new_lines, old_line.type, old_line.color));

    }
    three_D_Painter camera_painter=three_D_Painter(box_model,NLineWithType, screen_size, scale);


    return camera_painter;

  }




  List<LineWithType> my_web(){
    List<LineWithType> result=[];

    List<Line> lines=[];
    for(double i=-500;i<=500;i+=10){
      Point_model px1=Point_model(i,    0, -500 );
      Point_model px2=Point_model(i,    0, 500  );
      Point_model py1=Point_model( -500,0,  i   );
      Point_model py2=Point_model( 500, 0,  i   );

      Line line_1=Line(px1,px2);
      Line line_2=Line(py1,py2);
      lines.add(line_1);
      lines.add(line_2);

    }

    LineWithType web=LineWithType(lines, 'web',Colors.black12);

    Point_model px= Point_model( 0,0,0);
    Point_model px_2=Point_model( 50,0,00);

    Line x_Axis=Line(px, px_2);


    Point_model py=Point_model( 0,0,0);
    Point_model py_2=Point_model( 0,50,00);

    Line y_Axis=Line(py, py_2);

    Point_model pz=Point_model( 0,0,0);
    Point_model pz_2=Point_model( 0,0,50);

    Line z_Axis=Line(pz, pz_2);

    LineWithType X_axis=LineWithType([x_Axis], 'X',Colors.red);
    LineWithType Y_axis=LineWithType([y_Axis], 'Y',Colors.blue);
    LineWithType Z_axis=LineWithType([z_Axis], 'Z',Colors.teal);

    result.add(web);
    result.add(X_axis);
    result.add(Y_axis);
    result.add(Z_axis);

    return result;
  }


  move(double dx, double dy, double dz){

    camera_position.x_coordinate+=dx/scale;
    camera_position.y_coordinate+=dy/scale;
    camera_position.z_coordinate+=dz/scale;

  }






}
