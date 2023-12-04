import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Pattern_Painter extends CustomPainter {
  late List<Bore_unit> bore_unit;
  late double thickness;
  late double widh;

  late double screen_width;
  late double max_width;

  Pattern_Painter(this.bore_unit, this.thickness, this.widh, this.screen_width,
      this.max_width);

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
      ..color = Colors.blue;

    Paint piece_painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;

    Path main_piece_side = Path();
    Path main_piece_face = Path();

    Path second_piece_face = Path();

    Offset main_origin = Offset(50, 75);

    Offset second_origin = Offset(50, 25);

    main_piece_side.moveTo(main_origin.dx, main_origin.dy);
    main_piece_side.lineTo(main_origin.dx + w * scal, main_origin.dy);
    main_piece_side.lineTo(main_origin.dx + w * scal + th * scal, main_origin.dy - th * scal);
    main_piece_side.lineTo(main_origin.dx + th * scal, main_origin.dy - th * scal);
    main_piece_side.lineTo(main_origin.dx, main_origin.dy);

    main_piece_face.moveTo(main_origin.dx, main_origin.dy + 6 * th * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy + 6 * th * scal);

    main_piece_face.moveTo(main_origin.dx + w * scal + th * scal, main_origin.dy + 5 * th * scal);
    main_piece_face.lineTo(main_origin.dx + w * scal + th * scal, main_origin.dy - th * scal);

    second_piece_face.moveTo(second_origin.dx-2*th* scal, second_origin.dy - 3 * th * scal);
    second_piece_face.lineTo(second_origin.dx, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + w * scal, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + w * scal-2*th* scal, second_origin.dy - 3 * th * scal);

    second_piece_face.moveTo(second_origin.dx + w * scal-th*scal , second_origin.dy - 4 * th * scal);
    second_piece_face.lineTo(second_origin.dx + w * scal + th * scal, second_origin.dy - th * scal);
    second_piece_face.lineTo(second_origin.dx + w * scal, second_origin.dy);

    canvas.drawPath(main_piece_side, piece_painter);
    canvas.drawPath(main_piece_face, piece_painter);
    canvas.drawPath(second_piece_face, piece_painter);

// print(joinHolePattern.bores.length);

    for (int i = 0; i < bore_unit.length; i++) {
      Bore_unit unit = bore_unit[i];

      double pre_distence = unit.pre_distence;
      Bore_model side_bore = unit.side_bore;
      bool have_nut_bore = unit.have_nut_bore;
      double nut_bore_distence = unit.nut_bore_distence;
      Bore_model nut_bore = unit.nut_bore;
      Bore_model face_bore = unit.face_bore;

      canvas.drawCircle(
          Offset(main_origin.dx + pre_distence * scal+th* scal/2, main_origin.dy - (th/2) * scal),

          side_bore.diameter * scal / 2,
          bore_painter);
      if (have_nut_bore) {
      canvas.drawCircle(
          Offset(main_origin.dx + pre_distence * scal, main_origin.dy + nut_bore_distence * scal),
          nut_bore.diameter * scal / 2,
          bore_painter);

      }

        canvas.drawCircle(
            Offset(second_origin.dx + pre_distence * scal, second_origin.dy-(th/2)*scal),

            face_bore.diameter * scal / 2,
            bore_painter);
      }


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
