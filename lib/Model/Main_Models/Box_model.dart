
import 'package:auto_cam/Model/Main_Models/Face_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Model/Main_Models/Point_model.dart';

class Box_model {

  late int box_id;
  late double box_width;
  late double box_height;
  late double box_depth;
  late double material_thickness;
  late double backpanel_thickness;
  late Point_model box_origin;
  late List<Piece_model> box_pieces;


  Box_model(this.box_width, this.box_height, this.box_depth,
      this.material_thickness, this.backpanel_thickness) {
    box_id = 2;
    box_origin = Point_model(0,0,0);

    ////////////////////////////////////////////////////////////////////////////

    /// initiate the details of the box (id,name,size,Pieces)
    /// every piece need also details (id , name , size , faces )

    /// we will  define the thickness of all pieces to use it while we initiate the other pieces
    /// and as more explanation we need to separate this value because maybe one of box side or pieces
    /// has different thickness or even different material

    Map<String, double> pieces_thickness = {
      "top_thickness": material_thickness,
      "base_thickness": material_thickness,
      "right_thickness": material_thickness,
      "left_thickness": material_thickness,
    };

    /// we need to define the id of initiate pieces
    /// note : we consider the main inner or inner area has the id of back panel
    /// and it will always like this , the different id for inner will be for new inners

    Map<String, int> pices_id = {
      "out_off_the_box": 0,
      "the_box_front": 1,
      "back_panel_id": 2,
      "top_id": 3,
      "right_id": 4,
      "base_id": 5,
      "left_id": 6,
      "inner_id": 7,
    };

    ////////////////////////////////////////////////////////////////////////////

    /// 1- initiate the (top) piece of the box
    /// 1-1 initiate the Faces of the top piece
    Face_model top_piece_right_face =
        Face_model('right_face', [pices_id['right_id']!], [], []);
    Face_model top_piece_left_face =
        Face_model('left_face', [pices_id['left_id']!], [], []);
    Face_model top_piece_front_face =
        Face_model('front_face', [pices_id['the_box_front']!], [], []);
    Face_model top_piece_back_face =
        Face_model('back_face', [pices_id['out_off_the_box']!], [], []);
    Face_model top_piece_top_face =
        Face_model('top_face', [pices_id['out_off_the_box']!], [], []);
    Face_model top_piece_base_face =
        Face_model('bottom_face', [pices_id['back_panel_id']!], [], []);

    List<Face_model> top_piece_piece_faces = [
      top_piece_right_face,
      top_piece_left_face,
      top_piece_front_face,
      top_piece_back_face,
      top_piece_top_face,
      top_piece_base_face,
    ];

    ///1-2 initiate the top piece itself
    Piece_model top_piece = Piece_model(
        pices_id['top_id']!,
        'top',
        'H',
        'box_material',
        box_depth,
        box_width - 2 * material_thickness,
        material_thickness,
        Point_model(
            box_origin.x_coordinate + pieces_thickness['left_thickness']!,
            box_origin.y_coordinate + box_height-pieces_thickness['top_thickness']!,
            0),
        top_piece_piece_faces);

    ////////////////////////////////////////////////////////////////////////////

    /// 2- initiate the (right) piece of the box
    /// 2-1 initiate the Faces of the right piece
    Face_model right_piece_right_face =
        Face_model('right_face', [pices_id['out_off_the_box']!], [], []);
    Face_model right_piece_left_face =
        Face_model('left_face', [pices_id['back_panel_id']!], [], []);
    Face_model right_piece_front_face =
        Face_model('front_face', [pices_id['the_box_front']!], [], []);
    Face_model right_piece_back_face =
        Face_model('back_face', [pices_id['out_off_the_box']!], [], []);
    Face_model right_piece_top_face =
        Face_model('top_face', [pices_id['out_off_the_box']!], [], []);
    Face_model right_piece_base_face =
        Face_model('bottom_face', [pices_id['out_off_the_box']!], [], []);

    List<Face_model> right_piece_piece_faces = [
      right_piece_right_face,
      right_piece_left_face,
      right_piece_front_face,
      right_piece_back_face,
      right_piece_top_face,
      right_piece_base_face,
    ];

    ///2-2 initiate the right piece itself
    Piece_model right_piece = Piece_model(
        pices_id['right_id']!,
        'right',
        'V',
        'box_material',
        box_depth,
        box_height,
        material_thickness,
        Point_model(
            box_origin.x_coordinate +
                box_width -
                pieces_thickness['right_thickness']!,
            box_origin.y_coordinate,
            0),
        right_piece_piece_faces);

    ////////////////////////////////////////////////////////////////////////////

    /// 3- initiate the (left) piece of the box
    /// 3-1 initiate the Faces of the left piece
    Face_model left_piece_right_face =
        Face_model('right_face', [pices_id['back_panel_id']!], [], []);
    Face_model left_piece_left_face =
        Face_model('left_face', [pices_id['out_off_the_box']!], [], []);
    Face_model left_piece_front_face =
        Face_model('front_face', [pices_id['the_box_front']!], [], []);
    Face_model left_piece_back_face =
        Face_model('back_face', [pices_id['out_off_the_box']!], [], []);
    Face_model left_piece_top_face =
        Face_model('top_face', [pices_id['out_off_the_box']!], [], []);
    Face_model left_piece_base_face =
        Face_model('bottom_face', [pices_id['out_off_the_box']!], [], []);

    List<Face_model> left_piece_piece_faces = [
      left_piece_right_face,
      left_piece_left_face,
      left_piece_front_face,
      left_piece_back_face,
      left_piece_top_face,
      left_piece_base_face,
    ];

    ///3-2 initiate the left piece itself
    Piece_model left_piece = Piece_model(
        pices_id['left_id']!,
        'left',
        'V',
        'box_material',
        box_depth,
        box_height,
        material_thickness,
        Point_model(
            box_origin.x_coordinate, box_origin.y_coordinate, 0),
        left_piece_piece_faces);

    ////////////////////////////////////////////////////////////////////////////

    /// 4- initiate the (base) piece of the box
    /// 4-1 initiate the Faces of the base piece
    Face_model base_piece_right_face =
        Face_model('right_face', [pices_id['right_id']!], [], []);
    Face_model base_piece_left_face =
        Face_model('left_face', [pices_id['left_id']!], [], []);
    Face_model base_piece_front_face =
        Face_model('front_face', [pices_id['the_box_front']!], [], []);
    Face_model base_piece_back_face =
        Face_model('back_face', [pices_id['out_off_the_box']!], [], []);
    Face_model base_piece_top_face =
        Face_model('top_face', [pices_id['back_panel_id']!], [], []);
    Face_model base_piece_base_face =
        Face_model('bottom_face', [pices_id['out_off_the_box']!], [], []);

    List<Face_model> base_piece_piece_faces = [
      base_piece_right_face,
      base_piece_left_face,
      base_piece_front_face,
      base_piece_back_face,
      base_piece_top_face,
      base_piece_base_face,
    ];

    ///4-2 initiate the base piece itself
    Piece_model base_piece = Piece_model(
        pices_id['base_id']!,
        'base',
        'H',
        'box_material',
        box_depth,
        box_width - 2 * material_thickness,
        material_thickness,
        Point_model(
            box_origin.x_coordinate + pieces_thickness['left_thickness']!,
            box_origin.y_coordinate ,
            0),
        base_piece_piece_faces);

    ////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////

    /// 5- initiate the (back_panel) piece of the box
    /// 5-1 initiate the Faces of the back_panel piece
    Face_model back_panel_piece_right_face =
        Face_model('right_face', [pices_id['right_id']!], [], []);
    Face_model back_panel_piece_left_face =
        Face_model('left_face', [pices_id['left_id']!], [], []);
    Face_model back_panel_piece_front_face =
        Face_model('front_face', [pices_id['the_box_front']!], [], []);
    Face_model back_panel_piece_back_face =
        Face_model('back_face', [pices_id['out_off_the_box']!], [], []);
    Face_model back_panel_piece_top_face =
        Face_model('top_face', [pices_id['top_id']!], [], []);
    Face_model back_panel_piece_base_face =
        Face_model('bottom_face', [pices_id['base_id']!], [], []);

    List<Face_model> back_panel_piece_piece_faces = [
      back_panel_piece_right_face,
      back_panel_piece_left_face,
      back_panel_piece_front_face,
      back_panel_piece_back_face,
      back_panel_piece_top_face,
      back_panel_piece_base_face,
    ];

    ///5-2 initiate the base piece itself
    Piece_model back_panel_piece = Piece_model(
        pices_id['back_panel_id']!,
        'back_panel',
        'F',
        'back_panel_id_material',
        box_width - 18,
        box_height -18,
        backpanel_thickness,
        Point_model(
            box_origin.x_coordinate + 9, box_origin.y_coordinate + 9, 0),
        back_panel_piece_piece_faces);

    ////////////////////////////////////////////////////////////////////////////

    /// 6- initiate the (main inner) piece of the box
    /// 6-1 initiate the Faces of the inner piece
    ///
    Face_model inner_piece_right_face  = Face_model('right_face', [pices_id['right_id']!], [], []);
    Face_model inner_piece_left_face   = Face_model('left_face', [pices_id['left_id']!], [], []);
    Face_model inner_piece_top_face    = Face_model('top_face', [pices_id['top_id']!], [], []);
    Face_model inner_piece_base_face   = Face_model('bottom_face', [pices_id['base_id']!], [], []);

    List<Face_model> inner_piece_piece_faces = [
     inner_piece_right_face,
     inner_piece_left_face ,
     inner_piece_top_face  ,
     inner_piece_base_face ,
    ];

    ///6-2 initiate the inner piece itself
    Piece_model inner_piece = Piece_model(
        pices_id['inner_id']!,
        'inner',
        'F',
        'inner_id_material',
        box_width - 36,
        box_height -36,
        backpanel_thickness,
        Point_model(
            box_origin.x_coordinate +18,
            box_origin.y_coordinate +18, 0),
        inner_piece_piece_faces);

    ////////////////////////////////////////////////////////////////////////////

    box_pieces = [];
    box_pieces.add(top_piece);
    box_pieces.add(right_piece);
    box_pieces.add(base_piece);
    box_pieces.add(left_piece);
    box_pieces.add(back_panel_piece);
    box_pieces.add(inner_piece);

    print_pieces_coordinate();

  }

  Add_shelf() {}

  Add_partation() {}

  Add_Drawer() {}

  Add_Door() {}


  print_pieces_coordinate(){
    for(int i=0;i<box_pieces.length;i++){

      print(' piece name :${box_pieces[i].piece_id}');
      print(' piece id  :${box_pieces[i].piece_name}');

       print('p L D : X${box_pieces[i].cordinate_3d.xy_0_plane[0].x_coordinate} , Y:${box_pieces[i].cordinate_3d.xy_0_plane[0].y_coordinate}');
       print('p L U : X${box_pieces[i].cordinate_3d.xy_0_plane[1].x_coordinate} , Y:${box_pieces[i].cordinate_3d.xy_0_plane[1].y_coordinate}');
       print('p R U : X${box_pieces[i].cordinate_3d.xy_0_plane[2].x_coordinate} , Y:${box_pieces[i].cordinate_3d.xy_0_plane[2].y_coordinate}');
       print('p R D : X${box_pieces[i].cordinate_3d.xy_0_plane[3].x_coordinate} , Y:${box_pieces[i].cordinate_3d.xy_0_plane[3].y_coordinate}');
       print('=============');

    }
  }
}
