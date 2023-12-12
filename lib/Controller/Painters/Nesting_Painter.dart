import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';

class Nesting_Painter extends CustomPainter {

  late double w;
  late double h;
  late My_Sheet container;
  late Offset origin;

  late Offset mouse_Position;
late String hover_id;
late String selected_id;
  late double scale;
  late List<List<Point_model>> corners;

  Nesting_Painter(this.w, this.h, this.container,this.mouse_Position,this.hover_id,this.selected_id,this.scale,this.corners) {
    origin = Offset(40, h );
  }

  @override
  void paint(Canvas canvas, Size size) {

    draw_sheet(canvas, scale, container);

      for (int i = 0; i < container.pieces.length; i++) {
      bool hover=(container.pieces[i].piece_id==hover_id);
      bool selected=(container.pieces[i].piece_id==selected_id);
      // print('hover id : $hover_id , piece id : $i');


      if (container.pieces[i].nested) {
        draw_nested_rect(canvas, scale, container.pieces[i], i + 1,hover,selected);

      }
    }
    if(corners.length!=0){

      for(int i=0;i<corners.length;i++){

        double x1=corners[i][0].x_coordinate*scale+40;
        double y1=h-corners[i][0].y_coordinate*scale;

        double x2=corners[i][1].x_coordinate*scale+40;
        double y2=h-corners[i][1].y_coordinate*scale;

        canvas.drawCircle(Offset(x1,y1), 5*scale, Paint());
        canvas.drawCircle(Offset(x2,y2), 5*scale, Paint());

        canvas.drawLine(Offset(x1, y1),Offset(x2, y2), Paint());

      }

    }

    canvas.drawCircle(mouse_Position, 6, Paint());


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

    p.moveTo(origin.dx + piece_origin.x_coordinate,
        origin.dy - piece_origin.y_coordinate);
    p.lineTo(origin.dx + piece_origin.x_coordinate + piece_w * my_scale,
        origin.dy - piece_origin.x_coordinate);
    p.lineTo(origin.dx + piece_origin.x_coordinate + piece_w * my_scale,
        origin.dy - piece_origin.x_coordinate - piece_h * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate,
        origin.dy - piece_origin.x_coordinate - piece_h * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate,
        origin.dy - piece_origin.y_coordinate);

    canvas.drawPath(p, line_painter);

    draw_text(
        canvas,
        "rect",
        Offset(origin.dx + piece_origin.x_coordinate + 10,
            origin.dy - piece_origin.y_coordinate - 20),
        4,
        3);
  }

  draw_nested_rect(Canvas canvas, double my_scale, Piece_model piece, int id,bool hover,bool selected) {
    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;



    Paint hover_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    Paint selected_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;




    double piece_w = piece.piece_width;
    double piece_h = piece.piece_height;
    Point_model piece_origin = piece.piece_origin;

    Path p = Path();

    p.moveTo(origin.dx + piece_origin.x_coordinate * my_scale, origin.dy - piece_origin.y_coordinate * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate * my_scale + piece_w * my_scale, origin.dy - piece_origin.y_coordinate * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate * my_scale + piece_w * my_scale, origin.dy - piece_origin.y_coordinate * my_scale - piece_h * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate * my_scale, origin.dy - piece_origin.y_coordinate * my_scale - piece_h * my_scale);
    p.lineTo(origin.dx + piece_origin.x_coordinate * my_scale, origin.dy - piece_origin.y_coordinate * my_scale);



    if(hover){
      canvas.drawPath(p,hover_painter);
      canvas.drawPath(p, line_painter);

    }else if(selected){
      canvas.drawPath(p,selected_painter);
      canvas.drawPath(p, line_painter);

    }
    else{
      canvas.drawPath(p, line_painter);

    }
    draw_text(
        canvas,
        "$id",
        Offset(origin.dx + piece_origin.x_coordinate * my_scale + 5,
            origin.dy - piece_origin.y_coordinate * my_scale - 15),
        14,
        1);

  }

  draw_sheet(Canvas canvas, double my_scale, My_Sheet sheet) {
    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.red[200]!;

    double sheet_w = sheet.w;
    double sheet_h = sheet.h;

    Path p = Path();

    p.moveTo(origin.dx  , origin.dy  );
    p.lineTo(origin.dx  + sheet_w * my_scale, origin.dy  );
    p.lineTo(origin.dx  + sheet_w * my_scale, origin.dy   - sheet_h * my_scale);
    p.lineTo(origin.dx , origin.dy   - sheet_h * my_scale);
    p.lineTo(origin.dx , origin.dy  );

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
