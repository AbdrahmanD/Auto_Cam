import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Filler_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Box_model {
  late String box_name;
  late String box_type;
  late double box_width;
  late double box_height;
  late double box_depth;
  late double init_material_thickness;
  late String init_material_name;
  late double back_panel_thickness;
  late double grove_value;
 late double bac_panel_distence;
 late double top_base_piece_width;
 late bool   is_back_panel;
 late Point_model box_origin;
   List<Piece_model> box_pieces=[];
   int piece_id=0;


  Box_model(
      this.box_name,
      this.box_type,
      this.box_width,
      this.box_height,
      this.box_depth,
      this.init_material_thickness,
      this.init_material_name,
      this.back_panel_thickness,
      this.grove_value,
      this.bac_panel_distence,
      this.top_base_piece_width,
      this.is_back_panel,
      this.box_origin
      )

  {
    if(box_type=="wall_cabinet")
      { wall_cabinet();}
    else if(box_type=="base_cabinet")
    { base_cabinet();}
    else if(box_type=="inner_cabinet")
    { inner_cabinet();}

  }

 int  get_id(){
    piece_id++;
    // print("piece_id : $piece_id");
    return piece_id;
  }

  wall_cabinet()
  {
    Piece_model  top_piece = Piece_model(
        get_id(),
        'top',
        'H',
        init_material_name,
        box_depth,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,box_origin.z_coordinate)
    );
    box_pieces.add(top_piece);

    Piece_model  base_piece = Piece_model(
        get_id(),
        'base',
        'H',
        init_material_name,
        box_depth,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );
    box_pieces.add(base_piece);

    Piece_model  right_piece = Piece_model(
        get_id(),
        'right',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate+box_width - init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id(),
        'left',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );
    box_pieces.add(left_piece);

    if(is_back_panel){
      Piece_model  back_panel = Piece_model(
          get_id(),
          'back_panel',
          'F',
          init_material_name,
          box_width-2*init_material_thickness+2*grove_value-2,
          box_height-2*init_material_thickness+2*grove_value-2,
          back_panel_thickness,
          Point_model(box_origin.x_coordinate+init_material_thickness-grove_value+1,
              box_origin.y_coordinate+init_material_thickness-grove_value+1 ,
              box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
      );
      box_pieces.add(back_panel);
    }
    Piece_model  inner = Piece_model(
        get_id(),
        'inner',
        'F',
        'inner',
        box_width-2*init_material_thickness,
        box_height-2*init_material_thickness,
        (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),
        Point_model(box_origin.x_coordinate+init_material_thickness,
            box_origin.y_coordinate+init_material_thickness ,
            box_origin.z_coordinate)
    );
    box_pieces.add(inner);

  }

  base_cabinet()
  {
    Piece_model  top_piece_1 = Piece_model(
        get_id(),
        'top_1',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,box_origin.z_coordinate)
    );
    Piece_model  top_piece_2 = Piece_model(
        get_id(),
        'top_2',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,box_origin.z_coordinate+box_depth-top_base_piece_width)
    );

    box_pieces.add(top_piece_1);
    box_pieces.add(top_piece_2);

    Piece_model  base_piece = Piece_model(
        get_id(),
        'base',
        'H',
        init_material_name,
        box_depth,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );
    box_pieces.add(base_piece);

    Piece_model  right_piece = Piece_model(
        get_id(),
        'right',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate+box_width - init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id(),
        'left',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );
    box_pieces.add(left_piece);

    if(is_back_panel){
      Piece_model  back_panel = Piece_model(
          get_id(),
          'back_panel',
          'F',
          init_material_name,
          box_width-2*init_material_thickness+2*grove_value-2,
          box_height-2*init_material_thickness+2*grove_value-2,
          back_panel_thickness,
          Point_model(box_origin.x_coordinate+init_material_thickness-grove_value+1,
              box_origin.y_coordinate+init_material_thickness-grove_value+1 ,box_origin.z_coordinate+box_depth-bac_panel_distence)
      );
      box_pieces.add(back_panel);
    }
    Piece_model  inner = Piece_model(
        get_id(),
        'inner',
        'F',
        'inner',
        box_width-2*init_material_thickness,
        box_height-2*init_material_thickness,
        (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),

        Point_model(box_origin.x_coordinate+init_material_thickness,
            box_origin.y_coordinate+init_material_thickness ,
            box_origin.z_coordinate)
    );
    box_pieces.add(inner);

  }


  inner_cabinet()
  {
    Piece_model  top_piece_1 = Piece_model(
        get_id(),
        'top_1',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,box_origin.z_coordinate)
    );
    Piece_model  top_piece_2 = Piece_model(
        get_id(),
        'top_2',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,
            box_origin.z_coordinate+box_depth-top_base_piece_width)
    );

    box_pieces.add(top_piece_1);
    box_pieces.add(top_piece_2);

    Piece_model  base_piece_1 = Piece_model(
        get_id(),
        'base_1',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate+box_depth-top_base_piece_width)
    );
    Piece_model  base_piece_2 = Piece_model(
        get_id(),
        'base_2',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );

    box_pieces.add(base_piece_1);
    box_pieces.add(base_piece_2);

    Piece_model  right_piece = Piece_model(
        get_id(),
        'right',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate+box_width - init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id(),
        'left',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate,
            box_origin.y_coordinate ,box_origin.z_coordinate)
    );
    box_pieces.add(left_piece);

    if(is_back_panel){
      Piece_model  back_panel = Piece_model(
          get_id(),
          'back_panel',
          'F',
          init_material_name,
          box_width-2*init_material_thickness+2*grove_value-2,
          box_height-2*init_material_thickness+2*grove_value-2,
          back_panel_thickness,
          Point_model(box_origin.x_coordinate+init_material_thickness-grove_value+1,
              box_origin.y_coordinate+init_material_thickness-grove_value+1 ,box_origin.z_coordinate+box_depth-bac_panel_distence)
      );
      box_pieces.add(back_panel);
    }
    Piece_model  inner = Piece_model(
        get_id(),
        'inner',
        'F',
        'inner',
        box_width-2*init_material_thickness,
        box_height-2*init_material_thickness,
        0,
        Point_model(box_origin.x_coordinate+init_material_thickness,
            box_origin.y_coordinate+init_material_thickness ,
            box_origin.z_coordinate)
    );
    box_pieces.add(inner);

  }


  add_Shelf_pattern(int inner, double top_Distence, double frontage_Gap,
      double shelf_material_thickness, String shelf_type,bool is_copy,int shelf_quantity,double back_distance) {
    double down_Distence = box_pieces[inner].piece_height -
        top_Distence -
        shelf_material_thickness;

    double depth_of_shelf = (is_back_panel)?(box_depth - bac_panel_distence-back_panel_thickness - frontage_Gap):
    (box_depth -frontage_Gap);

    Piece_model old_inner = Piece_model(
        get_id(),
        'inner',
        'F',
        'inner',
        box_pieces[inner].piece_width,
        top_Distence,
        (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate +
                down_Distence +
                shelf_material_thickness,
            box_pieces[inner].piece_origin.z_coordinate)
    );

    Piece_model new_inner = Piece_model(
      get_id(),
        'inner',
        'F',
        'inner',
        box_pieces[inner].piece_width,
        down_Distence,
      (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate),
        );

    Piece_model new_piece = Piece_model(
      get_id(),
        '$shelf_type-${piece_id}',
       'H',
        init_material_name,
        depth_of_shelf,
        box_pieces[inner].piece_width,
        shelf_material_thickness,
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate + down_Distence,
            box_pieces[inner].piece_origin.z_coordinate+frontage_Gap),
         );



    box_pieces.add(old_inner);
    box_pieces.add(new_piece);
    box_pieces.add(new_inner);

    box_pieces.remove(box_pieces[inner]);

  }

  add_Shelf(int inner, double top_Distence, double frontage_Gap,
      double shelf_material_thickness, int Quantity, String shelf_type,double back_distance) {
    if (Quantity == 1) {
      if (box_pieces[inner].piece_height > top_Distence && top_Distence >= 0) {
        add_Shelf_pattern(inner, top_Distence, frontage_Gap,
            shelf_material_thickness, shelf_type,false,Quantity, back_distance);
        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    } else {
      if (((Quantity - 1) * top_Distence +
              Quantity * shelf_material_thickness) <
          box_pieces[inner].piece_height) {
        double distance = double.parse(
            ((box_pieces[inner].piece_height - Quantity * shelf_material_thickness) / (Quantity + 1)).toStringAsFixed(1)
        );

        add_Shelf_pattern(inner, distance, frontage_Gap,
            shelf_material_thickness, shelf_type,false,Quantity, back_distance);

        for (int i = 1; i < Quantity; i++) {
          add_Shelf_pattern(box_pieces.length - 1, distance, frontage_Gap,
              shelf_material_thickness, shelf_type,true,Quantity, back_distance);

        }

        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }
  }

  /// start Partition

  add_Partition_pattern(int inner, double left_Distence, double frontage_Gap,
      double partition_material_thickness,bool is_copy,int Partition_quantity,double back_distance)
  {


    double right_Distence = box_pieces[inner].piece_width - left_Distence - partition_material_thickness;

    double depth_of_partition =(is_back_panel)? (box_depth - back_distance-back_panel_thickness - frontage_Gap):
    (box_depth - frontage_Gap);

    Piece_model old_inner = Piece_model(
      get_id(),
        'inner',
        'F',
        'inner',
        left_Distence,
        box_pieces[inner].piece_height,
      (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate
        ),
        );


    Piece_model new_inner = Piece_model(
      get_id(),
        'inner',
        'F',
        'inner',
        right_Distence,
        box_pieces[inner].piece_height,
      (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate +
                left_Distence +
                partition_material_thickness,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate),
         );


    /// new piece partition


    Piece_model new_piece = Piece_model(
      get_id(),
        'partition-${piece_id}',
        'V',
        init_material_name,
        depth_of_partition,
        box_pieces[inner].piece_height,
        partition_material_thickness,
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate + left_Distence,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate+frontage_Gap),
         );







    ///
    ///


    box_pieces.add(old_inner);
    box_pieces.add(new_piece);
    box_pieces.add(new_inner);


    box_pieces.remove(box_pieces[inner]);

  }

  add_Partition(int inner, double left_Distence, double frontage_Gap,
      double partition_material_thickness, int Quantity,double back_distance)
  {
    if (Quantity == 1) {
      if (box_pieces[inner].piece_width-18 >= left_Distence && left_Distence >= 0) {
        add_Partition_pattern(
            inner, left_Distence, frontage_Gap, partition_material_thickness,false,Quantity,back_distance);
        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }


    else {

      if (
      ( (Quantity - 1) * left_Distence + Quantity * partition_material_thickness) < box_pieces[inner].piece_width
         )
      {
        double distance = double.parse((
                (box_pieces[inner].piece_width - Quantity * partition_material_thickness) / (Quantity + 1)
            ).toStringAsFixed(1));

          add_Partition_pattern(inner                , distance, frontage_Gap, partition_material_thickness,false,Quantity,back_distance);

        for (int i = 1; i < Quantity; i++) {
          add_Partition_pattern(box_pieces.length - 1, distance, frontage_Gap, partition_material_thickness,true ,Quantity,back_distance);
        }


        Navigator.of(Get.overlayContext!).pop();


      }
      else
      {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }
  }

  /// end door

  add_door(Door_Model door_model) {
    if (door_model.door_num == 1) {
      add_single_door_pattern(door_model);
    }
    else {
      add_double_door_pattern(door_model);
    }
  }

  add_filler(Filler_model filler_model , int hover_id){

    double x = 0;
    double y = 0;
    double z = 0;


    late double filler_w;
    late double filler_h;
    late double filler_th;

    /// vertical filler
    if(filler_model.filler_vertical){

        filler_w =box_pieces[hover_id].piece_width;
        filler_h = filler_model.height;
        filler_th = filler_model.thickness;


      double origin_x=box_pieces[hover_id].piece_origin.x_coordinate;
      double origin_y=box_pieces[hover_id].piece_origin.y_coordinate;
      double origin_z=box_pieces[hover_id].piece_origin.z_coordinate;

      if (filler_model.corner == 1) {
        x = origin_x;
        y = origin_y + filler_model.y_move;
        z = origin_z + filler_model.x_move;
      }
      else if (filler_model.corner == 2) {
        x = origin_x;
        y = origin_y + filler_model.y_move;
        z = origin_z + filler_model.x_move +   box_depth - ((filler_model.filler_vertical)?filler_th:filler_w );
      }
      else if (filler_model.corner == 3) {
        x = origin_x;
        y = origin_y + filler_model.y_move +   box_pieces[hover_id].piece_height -
            ((filler_model.filler_vertical)?filler_h:filler_th ) ;
        z = origin_z + filler_model.x_move + box_depth  -  ((filler_model.filler_vertical)?filler_th:filler_w );
      }
      else if (filler_model.corner == 4){
        x = origin_x;
        y = origin_y + filler_model.y_move+  box_pieces[hover_id].piece_height -
            ((filler_model.filler_vertical)?filler_h:filler_th ) ;
        z = origin_z + filler_model.x_move;
      }


      Point_model filler_origin = Point_model(x, y, z);
int id=get_id();
      Piece_model filler = Piece_model(
          id ,
          'filler_$id',
          "F",
          init_material_name,
          filler_w,
          filler_h,
          filler_th,
          filler_origin);

      box_pieces.add(filler);

    }
    /// horizontal filler
    else{

        filler_h = box_pieces[hover_id].piece_width;
        filler_w = filler_model.height;
        filler_th = filler_model.thickness;


      double origin_x=box_pieces[hover_id].piece_origin.x_coordinate;
      double origin_y=box_pieces[hover_id].piece_origin.y_coordinate;
      double origin_z=box_pieces[hover_id].piece_origin.z_coordinate;

      if (filler_model.corner == 1) {
        x = origin_x;
        y = origin_y + filler_model.y_move;
        z = origin_z + filler_model.x_move;
      }
      else if (filler_model.corner == 2) {
        x = origin_x;
        y = origin_y + filler_model.y_move;
        z = origin_z + filler_model.x_move +   box_depth - ((filler_model.filler_vertical)?filler_th:filler_w );
      }
      else if (filler_model.corner == 3) {
        x = origin_x;
        y = origin_y + filler_model.y_move +   box_pieces[hover_id].piece_height -
            ((filler_model.filler_vertical)?filler_h:filler_th ) ;
        z = origin_z + filler_model.x_move + box_depth  -  ((filler_model.filler_vertical)?filler_th:filler_w );
      }
      else if (filler_model.corner == 4){
        x = origin_x;
        y = origin_y + filler_model.y_move+  box_pieces[hover_id].piece_height -
            ((filler_model.filler_vertical)?filler_h:filler_th ) ;
        z = origin_z + filler_model.x_move;
      }


      Point_model filler_origin = Point_model(x, y, z);
        int id=get_id();

      Piece_model filler = Piece_model(
          id ,
          'filler_$id',
          "H",
          init_material_name,
          filler_w,
          filler_h,
          filler_th,
          filler_origin);

      box_pieces.add(filler);
    }

  }

  add_single_door_pattern(Door_Model door_model) {

    Piece_model door_inner = box_pieces[door_model.inner_id];

    double right_thickness =(door_model.inner_door)? (-door_model.right_gap):(init_material_thickness - door_model.right_gap);
    double left_thickness  =(door_model.inner_door)? (-door_model.left_gap):(init_material_thickness - door_model.left_gap);
    double top_thickness   =(door_model.inner_door)? (-door_model.up_gap):(init_material_thickness - door_model.up_gap);
    double base_thickness  =(door_model.inner_door)? (-door_model.down_gap):(init_material_thickness - door_model.down_gap);

    double door_width = door_inner.piece_width +
        right_thickness +
        left_thickness ;

    double door_hight = door_inner.piece_height +
        top_thickness +
        base_thickness ;



    Point_model door_origin = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness ,
        door_inner.piece_origin.y_coordinate -
            base_thickness ,
        (!door_model.inner_door)?
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness ):
        (door_inner.piece_origin.z_coordinate)
    );
    int id=get_id();

    Piece_model door_piece = Piece_model(
      id,
        'Door_$id',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin,
         );

    box_pieces.add(door_piece);
  }

  add_double_door_pattern(Door_Model door_model) {

    Piece_model door_inner = box_pieces[door_model.inner_id];

    double right_thickness =(door_model.inner_door)? (-door_model.right_gap):(init_material_thickness - door_model.right_gap);
    double left_thickness  =(door_model.inner_door)? (-door_model.left_gap):(init_material_thickness - door_model.left_gap);
    double top_thickness   =(door_model.inner_door)? (-door_model.up_gap):(init_material_thickness - door_model.up_gap);
    double base_thickness  =(door_model.inner_door)? (-door_model.down_gap):(init_material_thickness - door_model.down_gap);

    double door_width = double.parse(((door_inner.piece_width +
        right_thickness +
        left_thickness-door_model.center_gap) /
        2 ).toStringAsFixed(1));

    double door_hight = double.parse((door_inner.piece_height +
        top_thickness +
        base_thickness - door_model.center_gap).toStringAsFixed(1));

    Point_model door_origin_1 = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness ,
        door_inner.piece_origin.y_coordinate -
            base_thickness ,
        (!door_model.inner_door)?
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness ):
        (door_inner.piece_origin.z_coordinate)
    );

    Point_model door_origin_2 = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness +
            door_width +
            door_model.center_gap,
        door_inner.piece_origin.y_coordinate -
            base_thickness ,
        (!door_model.inner_door)?
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness ):
        (door_inner.piece_origin.z_coordinate)
    );


    ///  ///////////////////////////////////////


int id = get_id();
    Piece_model door_piece_1 = Piece_model(
     id,
        'Door_$id Right',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_1,
         );
    Piece_model door_piece_2 = Piece_model(
      id,
      'Door_$id left',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_2,
         );

    box_pieces.add(door_piece_1);
    box_pieces.add(door_piece_2);
  }




}
