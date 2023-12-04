import 'package:auto_cam/Model/Main_Models/Box_model.dart';
 import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
 import 'package:auto_cam/project/Project_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Project_Painter extends CustomPainter {



  late Project_model project_model;
  late double drawing_scale;
  late Size screen_Size;
  late int hover_id;
  late int selected_id;
   late List<List<Point_model>> corners;
late Offset mouse_positio;
  late String view_port;



  Project_Painter(
      this.project_model,
      this.drawing_scale,
      this.screen_Size,
      this.hover_id,
      this.selected_id,
      this.view_port,
       this.corners,
      this.mouse_positio

      )
  {


    this.hover_id = hover_id;


  }

  @override
  void paint(Canvas canvas, Size size) {



    for(int i=0;i<project_model.boxes.length;i++){
      Box_model b=project_model.boxes[i];

       if(selected_id==i){
         draw_box(canvas,b,size,true,false);
       }else if(hover_id==i){
         draw_box(canvas,b,size,false,true);

       }else{
         draw_box(canvas,b,size,false,false);

       }


    }

    if(corners.length!=0){

      for(int i=0;i<corners.length;i++){

        double x1=corners[i][0].x_coordinate*drawing_scale+screen_Size.width/2;
        double y1=corners[i][0].y_coordinate*drawing_scale+screen_Size.height/2;

        double x2=corners[i][1].x_coordinate*drawing_scale+screen_Size.width/2;
        double y2=corners[i][1].y_coordinate*drawing_scale+screen_Size.height/2;

        canvas.drawCircle(Offset(x1,y1), 5*drawing_scale, Paint());
        canvas.drawCircle(Offset(x2,y2), 5*drawing_scale, Paint());

        canvas.drawLine(Offset(x1, y1),Offset(x2, y2), Paint());

      }

    }




  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


  draw_box(Canvas canvas,Box_model box_model,Size size,bool selected,bool hover) {

  double w= screen_Size.width/2;
  double h= screen_Size.height/2;

    Paint thin_line_painter = Paint()
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke
      ..color = Colors.black;


    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;


    Paint hovered_pieces_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.teal[100]!;


  Paint selected_pieces_filler = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.red[300]!;




  Paint helper_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey[400]!
    ..blendMode=BlendMode.darken;

    Paint doors_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue[100]!
      ..blendMode=BlendMode.darken;



    for (int i = 0; i < box_model.box_pieces.length; i++) {
      Piece_model piece_model = box_model.box_pieces[i];



      Point_model p1 = piece_model.piece_faces.faces[4].corners[0];
      Point_model p2 = piece_model.piece_faces.faces[4].corners[1];
      Point_model p3 = piece_model.piece_faces.faces[4].corners[2];
      Point_model p4 = piece_model.piece_faces.faces[4].corners[3];
      Point_model p5 = piece_model.piece_faces.faces[5].corners[0];
      Point_model p6 = piece_model.piece_faces.faces[5].corners[1];
      Point_model p7 = piece_model.piece_faces.faces[5].corners[2];
      Point_model p8 = piece_model.piece_faces.faces[5].corners[3];




      Path path = Path();

      if(view_port=='F'){

        path.moveTo((p1.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p1.y_coordinate )* drawing_scale);
        path.lineTo((p2.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p2.y_coordinate )* drawing_scale);
        path.lineTo((p3.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p3.y_coordinate )* drawing_scale);
        path.lineTo((p4.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p4.y_coordinate )* drawing_scale);
        path.lineTo((p1.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p1.y_coordinate )* drawing_scale);


      }
      else if(view_port=='R'){

        path.moveTo( (p2.z_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p2.y_coordinate )* drawing_scale);
        path.lineTo( (p6.z_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p6.y_coordinate )* drawing_scale);
        path.lineTo( (p7.z_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p7.y_coordinate )* drawing_scale);
        path.lineTo( (p3.z_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p3.y_coordinate )* drawing_scale);
        path.lineTo( (p2.z_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p2.y_coordinate )* drawing_scale);


      }


      else if(view_port=='T'){

        path.moveTo((p1.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p1.z_coordinate) * drawing_scale);
        path.lineTo((p2.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p2.z_coordinate) * drawing_scale);
        path.lineTo((p6.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p6.z_coordinate) * drawing_scale);
        path.lineTo((p5.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p5.z_coordinate) * drawing_scale);
        path.lineTo((p1.x_coordinate  + box_model.box_origin.x_coordinate)* drawing_scale+w,h+( box_model.box_origin.y_coordinate - p1.z_coordinate) * drawing_scale);

      }




      if (selected) {

          canvas.drawPath(path, selected_pieces_filler);
          canvas.drawPath(path, line_painter);


       } else if (hover) {

        canvas.drawPath(path, hovered_pieces_filler);
        canvas.drawPath(path, line_painter);


      }
      else{
        if(piece_model.piece_name.contains("Helper")){
          canvas.drawPath(path, helper_filler);
        }
        else if(piece_model.piece_name.contains('Door')){
          canvas.drawPath(path, doors_filler);
          canvas.drawPath(path, thin_line_painter);
        }
        else {
          canvas.drawPath(path, line_painter);
        }

      }






    }
  }

  draw_text(Canvas c, String text, Offset offset, double t_size , int my_text_size) {
    TextSpan ts = TextSpan(
        text: text, style: TextStyle(fontSize: t_size/10*my_text_size, color: Colors.black));
    TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();

    tp.paint(c, offset);
  }


}
