import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';

class Box_Painter extends CustomPainter {

  late double drawing_scale;
  late Size screen_Size;
  late int hover_id;
  late int selected_id;
  late Box_model box_model;
  late String view_port;


  Box_Painter(this.box_model,this.drawing_scale, this.screen_Size, this.hover_id, this.selected_id,this.view_port) {
    this.box_model = box_model;

    this.hover_id = hover_id;

    box_model.box_origin.x_coordinate =
        screen_Size.width / 2 - box_model.box_width * drawing_scale / 2;
    box_model.box_origin.y_coordinate =
        screen_Size.height / 2 + box_model.box_height * drawing_scale / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    draw_box(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  draw_box(Canvas canvas) {

    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Paint pieces_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue[100]!;

    Paint selected_pieces_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue[300]!;

    Paint Doors_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.brown[200]!;
    Paint Doors_filler_2 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.brown[200]!
    ..blendMode=BlendMode.lighten;

    Paint inners_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.teal[100]!;

    for (int i = 0; i < box_model.box_pieces.length; i++) {
      Piece_model piece_model = box_model.box_pieces[i];



      Point_model p1 = piece_model.piece_faces.front_face.corners[0];
      Point_model p2 = piece_model.piece_faces.front_face.corners[1];
      Point_model p3 = piece_model.piece_faces.front_face.corners[2];
      Point_model p4 = piece_model.piece_faces.front_face.corners[3];
      Point_model p5 = piece_model.piece_faces.back_face.corners[0];
      Point_model p6 = piece_model.piece_faces.back_face.corners[1];
      Point_model p7 = piece_model.piece_faces.back_face.corners[2];
      Point_model p8 = piece_model.piece_faces.back_face.corners[3];




      Path path = Path();

      if(view_port=='F'){
        path.moveTo(
            p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,
            box_model.box_origin.y_coordinate - p1.y_coordinate * drawing_scale);
        path.lineTo(
            p2.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,
            box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale);
        path.lineTo(
            p3.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,
            box_model.box_origin.y_coordinate - p3.y_coordinate * drawing_scale);
        path.lineTo(
            p4.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,
            box_model.box_origin.y_coordinate - p4.y_coordinate * drawing_scale);
        path.lineTo(
            p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,
            box_model.box_origin.y_coordinate - p1.y_coordinate * drawing_scale);


      }
      else if(view_port=='R'){
        path.moveTo(screen_Size.height/2+p2.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale);
        path.lineTo(screen_Size.height/2+p6.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p6.y_coordinate * drawing_scale);
        path.lineTo(screen_Size.height/2+p7.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p7.y_coordinate * drawing_scale);
        path.lineTo(screen_Size.height/2+p3.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p3.y_coordinate * drawing_scale);
        path.lineTo(screen_Size.height/2+p2.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale);


      }


      else if(view_port=='T'){
        path.moveTo(p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,screen_Size.height/2- box_model.box_origin.z_coordinate - p1.z_coordinate * drawing_scale);
        path.lineTo(p2.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,screen_Size.height/2- box_model.box_origin.z_coordinate - p2.z_coordinate * drawing_scale);
        path.lineTo(p6.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,screen_Size.height/2- box_model.box_origin.z_coordinate - p6.z_coordinate * drawing_scale);
        path.lineTo(p5.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,screen_Size.height/2- box_model.box_origin.z_coordinate - p5.z_coordinate * drawing_scale);
        path.lineTo(p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate,screen_Size.height/2- box_model.box_origin.z_coordinate - p1.z_coordinate * drawing_scale);
      }




      if (i == hover_id) {
        if (piece_model.piece_name == 'inner') {
          canvas.drawPath(path, inners_filler);
          canvas.drawPath(path, line_painter);
        } else if (piece_model.piece_name == 'Door') {
          canvas.drawPath(path, Doors_filler);
          canvas.drawPath(path, line_painter);
        } else {
          canvas.drawPath(path, pieces_filler);
          canvas.drawPath(path, line_painter);

        }
      }
      if (i == selected_id) {
        if (piece_model.piece_name != 'inner' && piece_model.piece_name != 'Door') {

          canvas.drawPath(path, selected_pieces_filler);
          canvas.drawPath(path, line_painter);
        }
      }
      else {
        if (piece_model.piece_name == 'Door') {
          canvas.drawPath(path, Doors_filler_2);
          canvas.drawPath(path, line_painter);
            }
        else
          canvas.drawPath(path, line_painter);

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
