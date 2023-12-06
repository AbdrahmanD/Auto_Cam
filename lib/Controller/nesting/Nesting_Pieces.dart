import 'dart:ui';

class Nesting_Pieces {
  List<My_Rect> rects = [];
  List<My_Sheet> sheets = [];
  late My_Sheet container;

  Nesting_Pieces() {
    rects.add(My_Rect(580, 750, Offset(0, 0)));
    rects.add(My_Rect(580, 750, Offset(0, 0)));

    rects.add(My_Rect(564, 580, Offset(0, 0)));
    rects.add(My_Rect(564, 580, Offset(0, 0)));
    rects.add(My_Rect(564, 500, Offset(0, 0)));

    rects.add(My_Rect(600, 750, Offset(0, 0)));

    sheets.add(My_Sheet(1220, 2440, Offset(0, 0) ));
    // sheets.add(My_Sheet(500, 800, Offset(0, 0) ));

    container =My_Sheet(500, 800, Offset(0, 0) );

    for (var n = 0; n<rects.length; n++) {

    }
    nesting();


  }

  sort_rect_big_to_small_by_height() {
    List<My_Rect> revers_rects = [];

    rects.sort((a, b) {
      return (a.h).compareTo((b.h));
    });

    for (int i = rects.length - 1; i > -1; i--) {
      revers_rects.add(rects[i]);
    }
    rects = revers_rects;
  }

  sort_rect_big_to_small_by_width() {
    List<My_Rect> revers_rects = [];

    rects.sort((a, b) {
      return (a.w).compareTo((b.w));
    });

    for (int i = rects.length - 1; i > -1; i--) {
      revers_rects.add(rects[i]);
    }
    rects = revers_rects;
  }

  sort_sheet_small_to_big() {
    sheets.sort((a, b) {
      return (a.h).compareTo((b.h));
    });
  }

  bool can_contain(My_Rect my_rect, My_Sheet my_sheet) {
    bool can_contain = false;

    bool compare_w = my_sheet.w >= my_rect.w;
    bool compare_h = my_sheet.h >= my_rect.h;

    if (compare_w && compare_h) {
      can_contain = true;
    }

    return can_contain;
  }

  List<My_Sheet> spilt_sheet(My_Sheet my_sheet , My_Rect my_rect){

    List<My_Sheet> new_sheets=[];

    My_Sheet my_sheet_1=My_Sheet(my_sheet.w-my_rect.w, my_rect.h,  Offset(my_rect.w+my_sheet.origin.dx ,my_sheet.origin.dy));
    My_Sheet my_sheet_2=My_Sheet(my_sheet.w,my_sheet.h- my_rect.h, Offset(          my_sheet.origin.dx ,my_sheet.origin.dy+my_rect.h));

    new_sheets.add(my_sheet_1);
    new_sheets.add(my_sheet_2);

    return new_sheets;

  }

  insert_rect_in_sheet(My_Sheet my_sheet , My_Rect my_rect){
    my_rect.origin=my_sheet.origin;

  }

  My_Rect rotate_rect(My_Rect my_rect){
    My_Rect rotated_rect = My_Rect(my_rect.h, my_rect.w, my_rect.origin);

    return rotated_rect;
  }

  nesting() {

    sort_rect_big_to_small_by_height();
    sort_sheet_small_to_big();

    /// nest all rects
    for(int r=0;r<rects.length;r++){

      My_Rect my_rect=rects[r];

      if (!my_rect.nested) {
        for(int sh=0;sh<sheets.length;sh++){

          My_Sheet my_sheet=sheets[sh];

            if(can_contain(my_rect, my_sheet)){

              insert_rect_in_sheet(my_sheet, my_rect);
              my_rect.nested=true;

              sheets.remove(my_sheet);
              List<My_Sheet> nsh= spilt_sheet(my_sheet, my_rect);
              nsh.forEach((element) {sheets.add(element);});

              break;
            }

        }

      }

    }

    for(int r=0;r<rects.length;r++){
      if(!rects[r].nested){

        My_Rect rotated_rect=rotate_rect(rects[r]);
        rects.removeAt(r);

        rects.add(rotated_rect);

      }
    }

sort_rect_big_to_small_by_height();

    /// rotate remained rects and try to nest it
    for(int r=0;r<rects.length;r++){

      if (!rects[r].nested) {

        rects[r]=rotate_rect(rects[r]);

        for(int sh=0;sh<sheets.length;sh++){

          My_Sheet my_sheet=sheets[sh];

          if(can_contain(rects[r], my_sheet)){

            insert_rect_in_sheet(my_sheet, rects[r]);
            rects[r].nested=true;

            sheets.remove(my_sheet);
            List<My_Sheet> nsh= spilt_sheet(my_sheet, rects[r]);
            nsh.forEach((element) {sheets.add(element);});

            break;
          }

        }

      }

    }



    // rects.forEach((element) {if(element.nested){print(element.origin.dx);}});


  }

}

class My_Rect {
  late double w;
  late double h;
  late Offset origin;
  bool nested=false;

  My_Rect(this.w, this.h, this.origin);
}

class My_Sheet {
  late double w;
  late double h;
  late Offset origin;

  My_Sheet(this.w, this.h, this.origin );
}
