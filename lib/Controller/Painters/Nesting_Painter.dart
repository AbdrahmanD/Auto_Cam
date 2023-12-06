import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';

class Nesting_Painter extends CustomPainter {
  late double w;
  late double h;
  late My_Sheet container;
late  Offset origin ;
late  double scale ;


  Nesting_Painter(this.w, this.h, this.container){

    scale =(h-300)/container.h;
      origin = Offset(100, h * scale );

  }

  @override
  void paint(Canvas canvas, Size size) {


    draw_sheet(canvas, scale, container);

    // for (int i = 0; i < nesting_pieces.sheets.length; i++) {
    //   draw_sheet(canvas, scale, nesting_pieces.sheets[i]);
    // }

    for (int i = 0; i < container.pieces.length; i++) {

      if ( container.pieces[i].nested)
        draw_nested_rect(canvas, scale,  container.pieces[i],i+1);
      else
        draw_rect(canvas, scale,  container.pieces[i]);


    }


  }

  draw_rect(Canvas canvas, double my_scale, Piece_model piece) {

    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;


    double piece_w = piece.piece_width;
    double piece_h = piece.piece_height;
    Point_model piece_origin = piece.piece_origin;

    Path p = Path();

    p.moveTo(origin.dx + piece_origin.x_coordinate, origin.dy - piece_origin.y_coordinate);
    p.lineTo(origin.dx + piece_origin.x_coordinate + piece_w * my_scale,
             origin.dy - piece_origin.x_coordinate);
    p.lineTo(origin.dx + piece_origin.x_coordinate + piece_w * my_scale,
             origin.dy - piece_origin.x_coordinate - piece_h * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate,
             origin.dy - piece_origin.x_coordinate - piece_h * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate, origin.dy - piece_origin.y_coordinate);

    canvas.drawPath(p, line_painter);

    draw_text(canvas, "rect", Offset(origin.dx + piece_origin.x_coordinate+10, origin.dy - piece_origin.y_coordinate -20), 4, 3);
  }

  draw_nested_rect(Canvas canvas, double my_scale, Piece_model piece,int id) {
    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;


    double piece_w = piece.piece_width;
    double piece_h = piece.piece_height;
    Point_model piece_origin = piece.piece_origin;

    Path p = Path();

    p.moveTo(origin.dx + piece_origin.x_coordinate* my_scale                     , origin.dy - piece_origin.y_coordinate* my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate* my_scale + piece_w * my_scale, origin.dy - piece_origin.y_coordinate* my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate* my_scale + piece_w * my_scale, origin.dy - piece_origin.y_coordinate* my_scale - piece_h * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate* my_scale                     , origin.dy - piece_origin.y_coordinate* my_scale - piece_h * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate* my_scale                     , origin.dy - piece_origin.y_coordinate* my_scale);

    canvas.drawPath(p, line_painter);
    draw_text(canvas,"$id",Offset(origin.dx + piece_origin.x_coordinate* my_scale+5, origin.dy - piece_origin.y_coordinate* my_scale-15),14,1);
  }

  draw_sheet(Canvas canvas, double my_scale, My_Sheet sheet) {
    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.red[200]!;


    double sheet_w = sheet.w;
    double sheet_h = sheet.h;
    Offset sheet_origin = sheet.origin;

    Path p = Path();

    p.moveTo(origin.dx + sheet_origin.dx* my_scale                    , origin.dy - sheet_origin.dy* my_scale);
    p.lineTo(origin.dx + sheet_origin.dx* my_scale+ sheet_w * my_scale, origin.dy - sheet_origin.dy* my_scale);
    p.lineTo(origin.dx + sheet_origin.dx* my_scale+ sheet_w * my_scale, origin.dy - sheet_origin.dy* my_scale - sheet_h * my_scale);
    p.lineTo(origin.dx + sheet_origin.dx* my_scale                    , origin.dy - sheet_origin.dy* my_scale - sheet_h * my_scale);
    p.lineTo(origin.dx + sheet_origin.dx* my_scale                    , origin.dy - sheet_origin.dy* my_scale);

    canvas.drawPath(p, line_painter);
  }

  draw_text(Canvas c, String text, Offset offset, double t_size, int my_text_size) {
    TextSpan ts = TextSpan(
        text: text,
        style: TextStyle(fontSize: t_size * my_text_size, color: Colors.black));
    TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();

    tp.paint(c, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
