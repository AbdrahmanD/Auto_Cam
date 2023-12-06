import 'dart:ui';

import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';

class Nesting_Pieces {

  List<My_Sheet> sheets = [];
  late My_Sheet container;
 late List<Piece_model> pieces;

  Nesting_Pieces(this.pieces) {

    container = My_Sheet(1220, 2440, Offset(0, 0), []);
    sheets.add(container);

  }


  sort_rect_big_to_small_by_height() {

    List<Piece_model> revers_pieces = [];

    pieces.sort((a, b) {
      return (a.piece_height).compareTo((b.piece_height));
    });

    for (int i = pieces.length - 1; i > -1; i--) {
      revers_pieces.add(pieces[i]);
    }
    pieces = revers_pieces;
  }

  sort_rect_big_to_small_by_width() {
    List<Piece_model> revers_pieces = [];

    pieces.sort((a, b) {
      return (a.piece_width).compareTo((b.piece_width));
    });

    for (int i = pieces.length - 1; i > -1; i--) {
      revers_pieces.add(pieces[i]);
    }
    pieces = revers_pieces;
  }

  sort_sheet_small_to_big() {
    sheets.sort((a, b) {
      return (a.h).compareTo((b.h));
    });
  }

  bool can_contain(Piece_model piece, My_Sheet my_sheet) {

    bool can_contain = false;

    bool compare_w = my_sheet.w >= piece.piece_width;
    bool compare_h = my_sheet.h >= piece.piece_height;

    if (compare_w && compare_h) {
      can_contain = true;
    }

    return can_contain;
  }

  List<My_Sheet> spilt_sheet(My_Sheet my_sheet, Piece_model my_piece) {
    List<My_Sheet> new_sheets = [];

    My_Sheet my_sheet_1 = My_Sheet(my_sheet.w - my_piece.piece_width, my_piece.piece_height,
        Offset(my_piece.piece_width + my_sheet.origin.dx, my_sheet.origin.dy), []);

    My_Sheet my_sheet_2 = My_Sheet(my_sheet.w, my_sheet.h - my_piece.piece_height,
        Offset(my_sheet.origin.dx, my_sheet.origin.dy + my_piece.piece_height), []);

    new_sheets.add(my_sheet_1);
    new_sheets.add(my_sheet_2);

    return new_sheets;
  }

  insert_rect_in_sheet(My_Sheet my_sheet, Piece_model my_piece) {
    my_piece.piece_origin = Point_model(my_sheet.origin.dx, my_sheet.origin.dy, my_piece.piece_origin.z_coordinate);
  }

  Piece_model rotate_rect(Piece_model my_piece) {
    double w= my_piece.piece_width;
    double h= my_piece.piece_height;

    my_piece.piece_height=w;
    my_piece.piece_width=h;

    return my_piece;
  }

  My_Sheet nesting() {

    My_Sheet sheet = My_Sheet(container.w, container.h, container.origin, []);

    sort_rect_big_to_small_by_height();
    sort_sheet_small_to_big();

    /// nest all rects

    for (int r = 0; r < pieces.length; r++) {
      Piece_model my_piece = pieces[r];
      if(pieces[r].piece_name.contains("inner") || pieces[r].piece_name.contains("Helper")){continue;}
      if (!my_piece.nested) {
        for (int sh = 0; sh < sheets.length; sh++) {
          My_Sheet my_sheet = sheets[sh];

          if (can_contain(my_piece, my_sheet)) {

            insert_rect_in_sheet(my_sheet, my_piece);

            my_piece.nested = true;
            sheet.pieces.add(my_piece);

            sheets.remove(my_sheet);
            List<My_Sheet> nsh = spilt_sheet(my_sheet, my_piece);
            nsh.forEach((element) {
              sheets.add(element);
            });

            break;
          }
        }
      }
    }

    for (int r = 0; r < pieces.length; r++) {
      if(pieces[r].piece_name.contains("inner") || pieces[r].piece_name.contains("Helper")){continue;}

      if (!pieces[r].nested) {
        Piece_model rotated_piece = rotate_rect(pieces[r]);
        pieces.removeAt(r);

        pieces.add(rotated_piece);
      }
    }

    sort_rect_big_to_small_by_height();

    /// rotate remained rects and try to nest it
    for (int r = 0; r < pieces.length; r++) {

      if(pieces[r].piece_name.contains("inner") || pieces[r].piece_name.contains("Helper")){continue;}

      if (!pieces[r].nested) {
        pieces[r] = rotate_rect(pieces[r]);

        for (int sh = 0; sh < sheets.length; sh++) {
          My_Sheet my_sheet = sheets[sh];

          if (can_contain(pieces[r], my_sheet)) {
            insert_rect_in_sheet(my_sheet, pieces[r]);
            pieces[r].nested = true;
            sheet.pieces.add(pieces[r]);


            sheets.remove(my_sheet);
            List<My_Sheet> nsh = spilt_sheet(my_sheet, pieces[r]);
            nsh.forEach((element) {
              sheets.add(element);
            });

            break;
          }
        }
      }
    }

    // rects.forEach((element) {if(element.nested){print(element.origin.dx);}});
    return sheet;
  }
}

// class My_Rect {
//   late double w;
//   late double h;
//   late Offset origin;
//   bool nested = false;
//
//   My_Rect(this.w, this.h, this.origin);
// }

class My_Sheet {
  late double w;
  late double h;
  late Offset origin;
  List<Piece_model> pieces = [];

  My_Sheet(this.w, this.h, this.origin, this.pieces);
}
