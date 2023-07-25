

import 'package:auto_cam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam/Model/Main_Models/Join_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Model/Main_Models/Point_model.dart';

class Join_controller {

  Box_Repository box_repository=Box_Repository();

  join_pieces(Piece_model first_piece , Piece_model second_piece)
  {

  }

  detect_shared_face(Piece_model first_piece , Piece_model second_piece)
  {

  }

  List<Point_model>  join_line(Piece_model first_piece , Piece_model second_piece)
  {
    List<Point_model> start_and_end_points=[];


    return start_and_end_points;
  }

  List<Point_model> join_points(Jion_line jion_line)
  {
    List<Point_model> join_points_list=[];

    Point_model start_point=jion_line.start_point;
    Point_model end_point=jion_line.end_point;

    if(start_point.x_coordinate==end_point.x_coordinate){

      // y_Axis_extraxt_points();
    }

    else if(start_point.y_coordinate==end_point.y_coordinate){

      // x_Axis_extraxt_points();
    }


    return join_points_list;
  }


  // x_Axis_extraxt_points(){
  //   double distence=(p1.x_coordinate-p2.x_coordinate).abs();
  //
  //   if(distence<=100){
  //
  //     Point_model np1=Point_model(p1.x_coordinate+box_repository.absolute_fix_distence_small,p1.y_coordinate, 0);
  //     Point_model np2=Point_model(p1.x_coordinate+distence/2                                ,p1.y_coordinate, 0);
  //     Point_model np3=Point_model(p2.x_coordinate-box_repository.absolute_fix_distence_small,p1.y_coordinate, 0);
  //
  //     hole_model h1 =hole_model(np1, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h2 =hole_model(np2, box_repository.nut_pen_diameter,box_repository.nut_pen_depth);
  //     hole_model h3 =hole_model(np3, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //
  //     vertical_hole.add(h1);
  //     vertical_hole.add(h2);
  //     vertical_hole.add(h3);
  //
  //   }
  //
  //   if(distence>100 && distence<=300){
  //
  //     Point_model np1=Point_model(p1.x_coordinate+box_repository.absolute_fix_distence_big,p1.y_coordinate,   0);
  //     Point_model np2=Point_model(p1.x_coordinate+distence/2                              ,p1.y_coordinate, 0);
  //     Point_model np3=Point_model(p2.x_coordinate-box_repository.absolute_fix_distence_big,p1.y_coordinate,   0);
  //
  //     hole_model h1 =hole_model(np1, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h2 =hole_model(np2, box_repository.nut_pen_diameter,box_repository.nut_pen_depth);
  //     hole_model h3 =hole_model(np3, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //
  //     vertical_hole.add(h1);
  //     vertical_hole.add(h2);
  //     vertical_hole.add(h3);
  //
  //   }
  //
  //   else  if(distence>300){
  //
  //     Point_model np1=Point_model(p1.x_coordinate+box_repository.absolute_fix_distence_big                                              ,p1.y_coordinate, 0);
  //     Point_model np2=Point_model(p1.x_coordinate+box_repository.absolute_fix_distence_big+box_repository.absolute_fix_distence_standerd,p1.y_coordinate, 0);
  //     Point_model np3=Point_model(p1.x_coordinate+distence/2                                                                            ,p1.y_coordinate, 0);
  //     Point_model np4=Point_model(p2.x_coordinate-box_repository.absolute_fix_distence_big-box_repository.absolute_fix_distence_standerd,p1.y_coordinate, 0);
  //     Point_model np5=Point_model(p2.x_coordinate-box_repository.absolute_fix_distence_big,                                              p1.y_coordinate, 0);
  //
  //     hole_model h1 =hole_model(np1, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h2 =hole_model(np2, box_repository.nut_pen_diameter,box_repository.nut_pen_depth);
  //     hole_model h3 =hole_model(np3, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h4 =hole_model(np4, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h5 =hole_model(np5, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //
  //
  //
  //     vertical_hole.add(h1);
  //     vertical_hole.add(h2);
  //     vertical_hole.add(h3);
  //     vertical_hole.add(h4);
  //     vertical_hole.add(h5);
  //
  //
  //   }
  // }
  //
  // y_Axis_extraxt_points(){
  //
  //   double distence=(p1.y_coordinate-p2.y_coordinate).abs();
  //
  //   if(distence<=100){
  //
  //     Point_model np1=Point_model(p1.x_coordinate,p1.y_coordinate+box_repository.absolute_fix_distence_small, 0);
  //     Point_model np2=Point_model(p1.x_coordinate,p1.y_coordinate+distence/2                                , 0);
  //     Point_model np3=Point_model(p1.x_coordinate,p2.y_coordinate-box_repository.absolute_fix_distence_small, 0);
  //
  //
  //     hole_model h1 =hole_model(np1, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h2 =hole_model(np2, box_repository.nut_pen_diameter,box_repository.nut_pen_depth);
  //     hole_model h3 =hole_model(np3, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //
  //
  //
  //     Point_model mini_fix_horizontal_point=Point_model(p1.x_coordinate,p1.y_coordinate+distence/2   , 0);
  //
  //     hole_model h_horezontal =hole_model(mini_fix_horizontal_point,
  //         box_repository.minifix_diameter,box_repository.minifix_depth);
  //     horizontal_hole.add(h_horezontal);
  //
  //
  //     vertical_hole.add(h1);
  //     vertical_hole.add(h2);
  //     vertical_hole.add(h3);
  //
  //
  //   }
  //
  //   else if(distence>100 && distence<=300){
  //
  //     Point_model np1=Point_model(p1.x_coordinate,p1.y_coordinate+box_repository.absolute_fix_distence_big, 0);
  //     Point_model np2=Point_model(p1.x_coordinate,p1.y_coordinate+distence/2                                , 0);
  //     Point_model np3=Point_model(p1.x_coordinate,p2.y_coordinate-box_repository.absolute_fix_distence_big, 0);
  //
  //     hole_model h1 =hole_model(np1, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h2 =hole_model(np2, box_repository.nut_pen_diameter,box_repository.nut_pen_depth);
  //     hole_model h3 =hole_model(np3, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //
  //     vertical_hole.add(h1);
  //     vertical_hole.add(h2);
  //     vertical_hole.add(h3);
  //
  //   }
  //
  //   else  if(distence>300){
  //
  //     Point_model np1=Point_model(p1.x_coordinate,p1.y_coordinate+box_repository.absolute_fix_distence_big , 0);
  //     Point_model np2=Point_model(p1.x_coordinate,p1.y_coordinate+box_repository.absolute_fix_distence_big+box_repository.absolute_fix_distence_standerd, 0);
  //     Point_model np3=Point_model(p1.x_coordinate,p1.y_coordinate+distence/2                                , 0);
  //     Point_model np4=Point_model(p1.x_coordinate,p2.y_coordinate-box_repository.absolute_fix_distence_big-box_repository.absolute_fix_distence_standerd, 0);
  //     Point_model np5=Point_model(p1.x_coordinate,p2.y_coordinate-box_repository.absolute_fix_distence_big, 0);
  //
  //     hole_model h1 =hole_model(np1, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h2 =hole_model(np2, box_repository.nut_pen_diameter,box_repository.nut_pen_depth);
  //     hole_model h3 =hole_model(np3, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h4 =hole_model(np4, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //     hole_model h5 =hole_model(np5, box_repository.wood_pen_diameter,box_repository.wood_pen_vertical_depth);
  //
  //
  //
  //     vertical_hole.add(h1);
  //     vertical_hole.add(h2);
  //     vertical_hole.add(h3);
  //     vertical_hole.add(h4);
  //     vertical_hole.add(h5);
  //
  //
  //   }
  // }

}