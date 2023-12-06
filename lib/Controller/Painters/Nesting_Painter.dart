import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:flutter/material.dart';

class Nesting_Painter extends CustomPainter {
  late double w;
  late double h;
  late Nesting_Pieces nesting_pieces;

  Nesting_Painter(this.w, this.h, this.nesting_pieces);

  @override
  void paint(Canvas canvas, Size size) {
    double scale = 0.1;

    draw_sheet(canvas, scale, nesting_pieces.container);

    for (int i = 0; i < nesting_pieces.sheets.length; i++) {
      draw_sheet(canvas, scale, nesting_pieces.sheets[i]);
    }

    for (int i = 0; i < nesting_pieces.rects.length; i++) {
      if (nesting_pieces.rects[i].nested)
        draw_nested_rect(canvas, scale, nesting_pieces.rects[i],i);
      else
        draw_rect(canvas, scale, nesting_pieces.rects[i]);
    }


  }

  draw_rect(Canvas canvas, double my_scale, My_Rect rect) {
    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Offset origin = Offset(100, h * my_scale - 100);

    double rect_w = rect.w;
    double rect_h = rect.h;
    Offset rect_origin = rect.origin;

    Path p = Path();

    p.moveTo(origin.dx + rect_origin.dx, origin.dy - rect_origin.dy);
    p.lineTo(origin.dx + rect_origin.dx + rect_w * my_scale,
        origin.dy - rect_origin.dy);
    p.lineTo(origin.dx + rect_origin.dx + rect_w * my_scale,
        origin.dy - rect_origin.dy - rect_h * my_scale);
    p.lineTo(origin.dx + rect_origin.dx,
        origin.dy - rect_origin.dy - rect_h * my_scale);
    p.lineTo(origin.dx + rect_origin.dx, origin.dy - rect_origin.dy);

    canvas.drawPath(p, line_painter);
  }

  draw_nested_rect(Canvas canvas, double my_scale, My_Rect rect,int id) {
    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    Offset origin = Offset(500, h * my_scale - 100);

    double rect_w = rect.w;
    double rect_h = rect.h;
    Offset rect_origin = rect.origin;

    Path p = Path();

    p.moveTo(origin.dx + rect_origin.dx* my_scale                    , origin.dy - rect_origin.dy* my_scale);
    p.lineTo(origin.dx + rect_origin.dx* my_scale + rect_w * my_scale, origin.dy - rect_origin.dy* my_scale);
    p.lineTo(origin.dx + rect_origin.dx* my_scale + rect_w * my_scale, origin.dy - rect_origin.dy* my_scale - rect_h * my_scale);
    p.lineTo(origin.dx + rect_origin.dx* my_scale                    , origin.dy - rect_origin.dy* my_scale - rect_h * my_scale);
    p.lineTo(origin.dx + rect_origin.dx* my_scale                    , origin.dy - rect_origin.dy* my_scale);

    canvas.drawPath(p, line_painter);
    draw_text(canvas,"$id",Offset(origin.dx + rect_origin.dx* my_scale+5, origin.dy - rect_origin.dy* my_scale-15),14,1);
  }

  draw_sheet(Canvas canvas, double my_scale, My_Sheet sheet) {
    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.red[200]!;

    Offset origin = Offset(100, h * my_scale - 100);

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

  draw_text(
      Canvas c, String text, Offset offset, double t_size, int my_text_size) {
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
