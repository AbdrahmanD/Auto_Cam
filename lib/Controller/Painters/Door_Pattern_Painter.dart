import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Door_Pattern_Painter extends CustomPainter {
  late List<Bore_unit> door_bore_unit;
  late List<Bore_unit> side_bore_unit;
  late double thickness;
  late double widh;

  late double screen_width;
  late double max_width;
  late String type_name;

  Door_Pattern_Painter(this.door_bore_unit,this.side_bore_unit, this.thickness, this.widh, this.screen_width,
      this.max_width,this.type_name);

  @override
  void paint(Canvas canvas, Size size) {
    late double scal;
    if (max_width > screen_width) {
      scal = screen_width / max_width;
    } else {
      scal = 1;
    }

    double pw = widh;
    double pth = thickness;

    draw_pattern(canvas, pw, pth, scal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  draw_pattern(Canvas canvas, double w, double th, double scal) {
    Paint bore_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    Paint piece_painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;



     Path main_piece_face = Path();

    Path second_piece_face = Path();

    Offset main_origin = Offset(50, 145);

    Offset second_origin = Offset(50, 125);

    main_piece_face.moveTo(main_origin.dx, main_origin.dy + 6 * th * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy + 6 * th * scal);


    second_piece_face.moveTo(second_origin.dx , second_origin.dy - 3 * th * scal);
    second_piece_face.lineTo(second_origin.dx, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + w * scal, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + w * scal , second_origin.dy - 3 * th * scal);


     canvas.drawPath(main_piece_face, piece_painter);
    canvas.drawPath(second_piece_face, piece_painter);

// print(joinHolePattern.bores.length);

    for (int i = 0; i < door_bore_unit.length; i++)
    {
      Bore_unit unit = door_bore_unit[i];

      double pre_distence = unit.pre_distence;
      Bore_model side_bore = unit.side_bore;


      canvas.drawCircle(Offset(main_origin.dx + pre_distence * scal+th* scal/2, main_origin.dy - (th/2) * scal),
          side_bore.diameter * scal / 2, bore_painter);

      }

    for (int i = 0; i < side_bore_unit.length; i++)
    {
      Bore_unit unit = side_bore_unit[i];

      double pre_distence = unit.pre_distence;
      Bore_model side_bore = unit.side_bore;


      canvas.drawCircle(Offset(main_origin.dx + pre_distence * scal+th* scal/2, main_origin.dy - (th/2) * scal),
          side_bore.diameter * scal / 2, bore_painter);

    }



    draw_text(canvas, "Box",
        Offset(second_origin.dx+10, second_origin.dy + 50), 2, 12);
    draw_text(canvas, "Door",
        Offset(main_origin.dx+10, main_origin.dy - 100), 2, 12);





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
}
