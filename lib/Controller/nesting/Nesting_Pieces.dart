import 'dart:math';
import 'dart:ui';

import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';

class Nesting_Pieces {


   int sheet_num=1;


  late List<Piece_model> all_pieces;
  late double cut_tool_diameter;




  Nesting_Pieces(this.all_pieces,this.cut_tool_diameter);


  List<Piece_model> sort_rect_big_to_small_by_height(List<Piece_model> piece_list) {

    List<Piece_model> revers_pieces = [];

    piece_list.sort((a, b) {
      return (a.piece_height).compareTo((b.piece_height));
    });

    for (int i = piece_list.length - 1; i > -1; i--) {
      revers_pieces.add(piece_list[i]);
    }
    return revers_pieces;
  }

  sort_sheet_small_to_big(List<My_Sheet> sheets) {
    sheets.sort((a, b) {
      return (a.h).compareTo((b.h));
    });
  }

  bool can_contain(Piece_model piece, My_Sheet my_sheet) {

    bool can_contain = false;

    bool compare_w = my_sheet.w >= piece.piece_width+cut_tool_diameter;
    bool compare_h = my_sheet.h >= piece.piece_height+cut_tool_diameter;

    if (compare_w && compare_h) {
      can_contain = true;
    }

    return can_contain;
  }

  List<My_Sheet> spilt_sheet(My_Sheet my_sheet, Piece_model my_piece) {

    List<My_Sheet> new_sheets = [];

    My_Sheet my_sheet_1 = My_Sheet("1",my_sheet.w - (my_piece.piece_width+cut_tool_diameter), my_piece.piece_height+cut_tool_diameter,
        Offset(my_piece.piece_width + my_sheet.origin.dx+cut_tool_diameter, my_sheet.origin.dy), []);

    My_Sheet my_sheet_2 = My_Sheet("2",my_sheet.w, my_sheet.h - my_piece.piece_height-cut_tool_diameter,
        Offset(my_sheet.origin.dx, my_sheet.origin.dy + my_piece.piece_height+cut_tool_diameter), []);

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

  List<Piece_model> detect_remain_pieces(List<Piece_model> my_pieces){
    List<Piece_model> remain_pieces=[];

    for(int r=0;r<my_pieces.length;r++){
      Piece_model p = my_pieces[r];
      if(!p.piece_inable){
        remain_pieces.add(p);

      }
    }

    return remain_pieces;
   }


  Nested_and_Remained nesting(List<Piece_model> pieces0,My_Sheet my_container) {

    List<My_Sheet> sheets = [];



    My_Sheet sheet = My_Sheet("sheet=$sheet_num",my_container.w, my_container.h, my_container.origin, []);
    my_container = My_Sheet("sheet=$sheet_num",my_container.w, my_container.h, my_container.origin, []);

    sheets.add(sheet);



    List<Piece_model> pieces= sort_rect_big_to_small_by_height(pieces0);
    sort_sheet_small_to_big(sheets);

    /// nest all rects

    for (int r = 0; r < pieces.length; r++) {
      Piece_model my_piece = pieces[r];
      if (!my_piece.piece_inable) {
        for (int sh = 0; sh < sheets.length; sh++) {
          My_Sheet my_sheet = sheets[sh];

          if (can_contain(my_piece, my_sheet)) {

            insert_rect_in_sheet(my_sheet, my_piece);

            my_piece.piece_inable = true;
            my_container.pieces.add(my_piece);

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

      if (!pieces[r].piece_inable) {
        Piece_model rotated_piece = rotate_rect(pieces[r]);
        pieces.removeAt(r);

        pieces.add(rotated_piece);
      }
    }


    List<Piece_model> remain_pieces= sort_rect_big_to_small_by_height(detect_remain_pieces(pieces));

    /// rotate remained rects and try to nest it
    for (int r = 0; r < remain_pieces.length; r++) {


      if (!remain_pieces[r].piece_inable) {
        remain_pieces[r] = rotate_rect(remain_pieces[r]);

        for (int sh = 0; sh < sheets.length; sh++) {
          My_Sheet my_sheet = sheets[sh];

          if (can_contain(remain_pieces[r], my_sheet)) {
            insert_rect_in_sheet(my_sheet, remain_pieces[r]);
            remain_pieces[r].piece_inable = true;
            my_container.pieces.add(remain_pieces[r]);


            sheets.remove(my_sheet);
            List<My_Sheet> nsh = spilt_sheet(my_sheet, remain_pieces[r]);
            nsh.forEach((element) {
              sheets.add(element);
            });

            break;
          }
        }
      }
    }

    Nested_and_Remained nested_and_remained = Nested_and_Remained(my_container,remain_pieces);
    return nested_and_remained;
  }


}


class My_Sheet {
  late String name;
  late double w;
  late double h;
  late Offset origin;
  List<Piece_model> pieces = [];

  My_Sheet(this.name,this.w, this.h, this.origin, this.pieces);
}


class Nested_and_Remained{

 late My_Sheet  nested_sheet;
 late List<Piece_model> remain_pieces;

 Nested_and_Remained(this.nested_sheet, this.remain_pieces);
}
