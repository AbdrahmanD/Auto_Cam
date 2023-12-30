import 'package:auto_cam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Filler_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
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
   List<Piece_model> box_deleted_pieces=[];
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

  Box_model.fromJson(Map<String, dynamic> json) {
    box_name = json['box_name'];
    box_type = json['box_type'];
    box_width = json['box_width'];
    box_height = json['box_height'];
    box_depth = json['box_depth'];
    init_material_thickness = json['init_material_thickness'];
    init_material_name = json['init_material_name'];
    back_panel_thickness = json['back_panel_thickness'];
    grove_value = json['grove_value'];
    bac_panel_distence = json['bac_panel_distence'];
    top_base_piece_width = json['top_base_piece_width'];
    is_back_panel = json['is_back_panel'];
    box_origin =Point_model.fromJson(json['box_origin']) ;
  if (json['box_pieces'] != null) {
    box_pieces = <Piece_model>[];
  json['box_pieces'].forEach((v) { box_pieces!.add(new Piece_model.fromJson(v)); });
  }
    piece_id = json['piece_id'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['box_name'] = this.box_name;
  data['box_type'] = this.box_type;
  data['box_width'] = this.box_width;
  data['box_height'] = this.box_height;
  data['box_depth'] = this.box_depth;
  data['init_material_thickness'] = this.init_material_thickness;
  data['init_material_name'] = this.init_material_name;
  data['back_panel_thickness'] = this.back_panel_thickness;
  data['grove_value'] = this.grove_value;
  data['bac_panel_distence'] = this.bac_panel_distence;
  data['top_base_piece_width'] = this.top_base_piece_width;
  data['is_back_panel'] = this.is_back_panel;
  if (this.box_origin != null) {
    data['box_origin'] = this.box_origin!.toJson();
  }
  if (this.box_pieces != null) {
    data['box_pieces'] = this.box_pieces!.map((v) => v.toJson()).toList();
  }
  data['piece_id'] = this.piece_id;
  return data;
}

  String  get_id(){
    piece_id++;
    // print("piece_id : $piece_id");
    return "$box_name-$piece_id";
  }

  wall_cabinet()
  {
    Piece_model  top_piece = Piece_model(
        get_id(),
        'top',
        'H',
        init_material_name,
        correct_value(box_depth),
       correct_value( box_width - 2 * init_material_thickness),
       correct_value( init_material_thickness),
        Point_model(
            correct_value(box_origin.x_coordinate + init_material_thickness),
            correct_value(box_origin.y_coordinate + box_height - init_material_thickness),
            correct_value(box_origin.z_coordinate)
        ),"inner_0"
    );
    box_pieces.add(top_piece);

    Piece_model  base_piece = Piece_model(
        get_id(),
        'base',
        'H',
        init_material_name,
        correct_value(box_depth),
            correct_value( box_width - 2 * init_material_thickness),
                correct_value(init_material_thickness),
        Point_model(
           correct_value( box_origin.x_coordinate + init_material_thickness),
           correct_value( box_origin.y_coordinate ),
           correct_value( box_origin.z_coordinate)
        ),"inner_0"
    );
    box_pieces.add(base_piece);

    Piece_model  right_piece = Piece_model(
        get_id(),
        'right',
        'V',
        init_material_name,
       correct_value( box_depth),
       correct_value( box_height),
       correct_value( init_material_thickness),
        Point_model(
           correct_value(box_origin.x_coordinate+box_width - init_material_thickness),
           correct_value(box_origin.y_coordinate) ,
           correct_value(box_origin.z_coordinate)
        ),"inner_0"
    );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id(),
        'left',
        'V',
        init_material_name,
       correct_value( box_depth),
       correct_value( box_height),
       correct_value( init_material_thickness),
        Point_model(
          correct_value( box_origin.x_coordinate),
          correct_value( box_origin.y_coordinate ),
          correct_value( box_origin.z_coordinate)
        ),"inner_0"
    );
    box_pieces.add(left_piece);

    if(is_back_panel){
      Piece_model  back_panel = Piece_model(
          get_id(),
          'back_panel',
          'F',
          init_material_name,
         correct_value(box_width-2*init_material_thickness+2*grove_value-1),
         correct_value(box_height-2*init_material_thickness+2*grove_value-1),
         correct_value(back_panel_thickness),
          Point_model(
             correct_value( box_origin.x_coordinate+init_material_thickness-grove_value+1),
             correct_value( box_origin.y_coordinate+init_material_thickness-grove_value+1 ),
             correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
          ),"inner-0"
      );

      Piece_model  back_panel_Helper = Piece_model(
          get_id(),
          'back_panel_Helper',
          'F',
          init_material_name,
          correct_value(box_width-2*init_material_thickness),
          correct_value(box_height-2*init_material_thickness),
          correct_value(back_panel_thickness),
          Point_model(
              correct_value( box_origin.x_coordinate+init_material_thickness),
              correct_value( box_origin.y_coordinate+init_material_thickness ),
              correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
          ),"inner-0"
      );

      box_pieces.add(back_panel);
      box_pieces.add(back_panel_Helper);
    }

    Piece_model  inner = Piece_model(
        get_id(),
        'inner_0',
        'F',
        'inner',
       correct_value( box_width-2*init_material_thickness),
       correct_value( box_height-2*init_material_thickness),
       correct_value( (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
        Point_model(
           correct_value(box_origin.x_coordinate+init_material_thickness),
           correct_value(box_origin.y_coordinate+init_material_thickness) ,
           correct_value(box_origin.z_coordinate)
        ),""
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
        ,"inner_0");
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
        ,"inner_0");

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
        ,"inner_0");
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
        ,"inner_0");
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
        ,"inner_0");
    box_pieces.add(left_piece);

    if(is_back_panel){
      Piece_model  back_panel = Piece_model(
          get_id(),
          'back_panel',
          'F',
          init_material_name,
          box_width-2*init_material_thickness+2*grove_value-1,
          box_height-2*init_material_thickness+2*grove_value-1,
          back_panel_thickness,
          Point_model(box_origin.x_coordinate+init_material_thickness-grove_value+1,
              box_origin.y_coordinate+init_material_thickness-grove_value+1
              ,box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
          ,"inner-0"  );
      Piece_model  back_panel_Helper = Piece_model(
          get_id(),
          'back_panel_Helper',
          'F',
          init_material_name,
          correct_value(box_width-2*init_material_thickness),
          correct_value(box_height-2*init_material_thickness),
          correct_value(back_panel_thickness),
          Point_model(
              correct_value( box_origin.x_coordinate+init_material_thickness),
              correct_value( box_origin.y_coordinate+init_material_thickness ),
              correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
          )
          ,"inner-0");

      box_pieces.add(back_panel);
      box_pieces.add(back_panel_Helper);
    }
    Piece_model  inner = Piece_model(
        get_id(),
        'inner_0',
        'F',
        'inner',
        box_width-2*init_material_thickness,
        box_height-2*init_material_thickness,
        (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),

        Point_model(box_origin.x_coordinate+init_material_thickness,
            box_origin.y_coordinate+init_material_thickness ,
            box_origin.z_coordinate)
        ,"" );
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
        ,"inner_0");
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
        ,"inner_0");

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
        ,"inner_0");
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
        ,"inner_0");

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
        ,"inner_0");
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
        ,"inner_0");
    box_pieces.add(left_piece);

    if(is_back_panel){
      Piece_model  back_panel = Piece_model(
          get_id(),
          'back_panel',
          'F',
          init_material_name,
          box_width-2*init_material_thickness+2*grove_value-1,
          box_height-2*init_material_thickness+2*grove_value-1,
          back_panel_thickness,
          Point_model(box_origin.x_coordinate+init_material_thickness-grove_value+1,
              box_origin.y_coordinate+init_material_thickness-grove_value+1 ,
              box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
          ,"inner-0"  );
      Piece_model  back_panel_Helper = Piece_model(
          get_id(),
          'back_panel_Helper',
          'F',
          init_material_name,
          correct_value(box_width-2*init_material_thickness),
          correct_value(box_height-2*init_material_thickness),
          correct_value(back_panel_thickness),
          Point_model(
              correct_value( box_origin.x_coordinate+init_material_thickness),
              correct_value( box_origin.y_coordinate+init_material_thickness ),
              correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
          )
          ,"inner-0" );

      box_pieces.add(back_panel);
      box_pieces.add(back_panel_Helper);
    }
    Piece_model  inner = Piece_model(
        get_id(),
        'inner_0',
        'F',
        'inner',
        box_width-2*init_material_thickness,
        box_height-2*init_material_thickness,
        0,
        Point_model(box_origin.x_coordinate+init_material_thickness,
            box_origin.y_coordinate+init_material_thickness ,
            box_origin.z_coordinate)
        ,"");
    box_pieces.add(inner);

  }


  add_Shelf_pattern(int inner, double top_Distence, double frontage_Gap,
      double shelf_material_thickness, String shelf_type,bool is_copy,int shelf_quantity,double back_distance)
  {

    double down_Distence = correct_value(box_pieces[inner].piece_height -
        top_Distence -
        shelf_material_thickness);

    double depth_of_shelf = correct_value((is_back_panel)?(box_depth - bac_panel_distence-back_panel_thickness - frontage_Gap):
    (box_depth -frontage_Gap));

    Piece_model old_inner = Piece_model(
        get_id(),
        '${box_pieces[inner].piece_name}_1',
        'F',
        'inner',
        box_pieces[inner].piece_width,
        top_Distence,
        correct_value((is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate +
                down_Distence +
                shelf_material_thickness,
            box_pieces[inner].piece_origin.z_coordinate).correct_cordinate()
        ,"");

    Piece_model new_inner = Piece_model(
      get_id(),
        '${box_pieces[inner].piece_name}_2',
        'F',
        'inner',
        box_pieces[inner].piece_width,
        down_Distence,
      correct_value((is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
        Point_model(
            box_pieces[inner].piece_origin.x_coordinate,
            box_pieces[inner].piece_origin.y_coordinate,
            box_pieces[inner].piece_origin.z_coordinate).correct_cordinate(),
       "");

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
            box_pieces[inner].piece_origin.z_coordinate+frontage_Gap).correct_cordinate(),"${box_pieces[inner].piece_name}"
         );



    box_pieces.add(old_inner);
    box_pieces.add(new_piece);
    box_pieces.add(new_inner);

    box_deleted_pieces.add(box_pieces[inner]);
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
      double partition_material_thickness,bool is_copy,int Partition_quantity,double back_distance,bool helper)
  {


    double right_Distence =correct_value(box_pieces[inner].piece_width - left_Distence - partition_material_thickness);

    double depth_of_partition =correct_value((is_back_panel)? (box_depth - back_distance-back_panel_thickness - frontage_Gap):
    (box_depth - frontage_Gap));

    Piece_model old_inner = Piece_model(
      get_id(),
        '${box_pieces[inner].piece_name}_1',
        'F',
        'inner',
        correct_value(left_Distence),
        correct_value(box_pieces[inner].piece_height),
      correct_value((is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
        Point_model(
           correct_value(box_pieces[inner].piece_origin.x_coordinate) ,
           correct_value(box_pieces[inner].piece_origin.y_coordinate) ,
           correct_value(box_pieces[inner].piece_origin.z_coordinate)
        ),""
        );


    Piece_model new_inner = Piece_model(
      get_id(),
        '${box_pieces[inner].piece_name}_1',
        'F',
        'inner',
      correct_value( right_Distence),
      correct_value(  box_pieces[inner].piece_height),
      correct_value((is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
        Point_model(
            correct_value(box_pieces[inner].piece_origin.x_coordinate + left_Distence + partition_material_thickness),
            correct_value(box_pieces[inner].piece_origin.y_coordinate),
            correct_value(box_pieces[inner].piece_origin.z_coordinate)),""
         );


    /// new piece partition




    Piece_model new_piece = Piece_model(
      get_id(),
      helper?"HELPER": 'partition-${piece_id}',
        'V',
       init_material_name,
       correct_value( depth_of_partition),
       correct_value( box_pieces[inner].piece_height),
       correct_value( partition_material_thickness),
        Point_model(
            correct_value( box_pieces[inner].piece_origin.x_coordinate + left_Distence)  ,
            correct_value( box_pieces[inner].piece_origin.y_coordinate  )  ,
            correct_value( box_pieces[inner].piece_origin.z_coordinate+frontage_Gap )  ,
        ),"${box_pieces[inner].piece_name}"
         );

    ///
    ///


    box_pieces.add(old_inner);
    box_pieces.add(new_piece);
    box_pieces.add(new_inner);


    box_deleted_pieces.add(box_pieces[inner]);
    box_pieces.remove(box_pieces[inner]);

  }

  add_Partition(int inner, double left_Distence, double frontage_Gap,
      double partition_material_thickness, int Quantity,double back_distance,bool helper)
  {
    if (Quantity == 1) {
      if (box_pieces[inner].piece_width-partition_material_thickness >= left_Distence && left_Distence >= 0) {
        add_Partition_pattern(
            inner, left_Distence, frontage_Gap, partition_material_thickness,false,Quantity,back_distance,helper );
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
        double distance = double.parse(((box_pieces[inner].piece_width - Quantity * partition_material_thickness)
            / (Quantity + 1))
            .toStringAsFixed(1));

          add_Partition_pattern(inner, distance, frontage_Gap, partition_material_thickness,
              false,Quantity,back_distance,helper);

        for (int i = 1; i < Quantity; i++) {
          add_Partition_pattern(box_pieces.length - 1, distance, frontage_Gap, partition_material_thickness,true
              ,Quantity,back_distance,helper);
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


  add_door(Door_Model door_model) {
    if (door_model.door_num == 1) {
      add_single_door_pattern(door_model);
    }
    else {
      add_double_door_pattern(door_model);
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
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness-2 ):
        (door_inner.piece_origin.z_coordinate)
    );
    String id=get_id();

    Piece_model door_piece = Piece_model(
      id,
        (door_model.direction=="R")?('Door_right_$id'):('Door_left_$id'),
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin,"inner-0"
         );


    double hw=correct_value((22.5-(init_material_thickness - door_model.right_gap))*2);
    double hh=init_material_thickness;
    if(door_model.inner_door){
      hh=door_hight;
    }
    else{
      if(door_model.up_gap > init_material_thickness)
      {

        hh=door_hight-init_material_thickness+door_model.down_gap-0.5;
      }
      else{
       hh= door_inner.piece_height - 1;
      }
    }
    double hth=76;

    if(door_model.direction=="R"){

      Point_model door_helper_origin = Point_model(
          door_inner.piece_origin.x_coordinate +door_inner.piece_width-hw ,

          (door_model.inner_door)?
          (door_inner.piece_origin.y_coordinate+door_model.down_gap):
          (door_inner.piece_origin.y_coordinate+0.5)  ,

          ! (door_model.inner_door)?
          (door_inner.piece_origin.z_coordinate-2 ):
          (door_inner.piece_origin.z_coordinate+door_model.material_thickness)
          
      );

      String hid=get_id();

      Piece_model door_Hinges_Helper = Piece_model(
        hid,
        'Door_Helper',
        'F',
        door_model.material_name,
        hw,
        hh,
        hth,
        door_helper_origin,""
      );

      box_pieces.add(door_Hinges_Helper);


    }
   else if(door_model.direction=="L"){

      Point_model door_helper_origin = Point_model(
          door_inner.piece_origin.x_coordinate  ,
          door_inner.piece_origin.y_coordinate +0.5 ,
          (!door_model.inner_door)?
          (door_inner.piece_origin.z_coordinate-2 ):
          (door_inner.piece_origin.z_coordinate)
      );

      String hid=get_id();

      Piece_model door_Hinges_Helper = Piece_model(
        hid,
        'Door_Helper',
        'F',
        door_model.material_name,
        hw,
        hh,
        hth,
        door_helper_origin,""
      );

      box_pieces.add(door_Hinges_Helper);


    }






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
        top_thickness + base_thickness).toStringAsFixed(1)
    );

    Point_model door_origin_1 = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness ,
        door_inner.piece_origin.y_coordinate -
            base_thickness ,
        (!door_model.inner_door)?
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness -2):
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
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness -2):
        (door_inner.piece_origin.z_coordinate)
    );


    ///  ///////////////////////////////////////


String id = get_id();
    Piece_model door_piece_1 = Piece_model(
     id,
        'Door_$id left',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_1,""
         );
    String id2 = get_id();
    Piece_model door_piece_2 = Piece_model(
      id2,
      'Door_$id right',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_2,""
         );

    box_pieces.add(door_piece_1);
    box_pieces.add(door_piece_2);


    // double hw=(22.5-(init_material_thickness - door_model.right_gap))*2;
    //
    // double hh=door_hight-(init_material_thickness-door_model.down_gap)-1;
    // double hth=76;
    //


    double hw=correct_value((22.5-(init_material_thickness - door_model.right_gap))*2);



    double hh=init_material_thickness;
    if(door_model.inner_door){
      hh=door_hight;
    }
    else{
      if(door_model.up_gap > init_material_thickness)
      {

        hh=door_hight-init_material_thickness+door_model.down_gap-0.5;
      }
      else{
       hh= door_inner.piece_height - 1;
      }
    }

    double hth=76;




    Point_model rdoor_helper_origin = Point_model(
    door_inner.piece_origin.x_coordinate +door_inner.piece_width-hw ,
    door_inner.piece_origin.y_coordinate+0.5 ,
    (!door_model.inner_door)?
    (door_inner.piece_origin.z_coordinate-2 ):
    (door_inner.piece_origin.z_coordinate)
    );

    String rhid=get_id();

    Piece_model rdoor_Hinges_Helper = Piece_model(
    rhid,
    'Door_Helper',
    'F',
    door_model.material_name,
    hw,
    hh,
    hth,
    rdoor_helper_origin,""
    );


    box_pieces.add(rdoor_Hinges_Helper);


    Point_model ldoor_helper_origin = Point_model(
    door_inner.piece_origin.x_coordinate  ,
    door_inner.piece_origin.y_coordinate+0.5 ,
    (!door_model.inner_door)?
    (door_inner.piece_origin.z_coordinate-2 ):
    (door_inner.piece_origin.z_coordinate)
    );

    String lhid=get_id();

    Piece_model ldoor_Hinges_Helper = Piece_model(
    lhid,
    'Door_Helper',
    'F',
    door_model.material_name,
    hw,
    hh,
    hth,
    ldoor_helper_origin,""
    );

    box_pieces.add(ldoor_Hinges_Helper);






  }

  add_filler(Filler_model filler_model , int hover_id){

    double x = 0;
    double y = 0;
    double z = 0;


    late double filler_w;
    late double filler_h;
    late double filler_th;

    /// filler inside
    if (filler_model.filler_inside) {
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
        String id=get_id();
        Piece_model filler = Piece_model(
            id ,
            'filler_$id',
            "F",
            init_material_name,
            filler_w,
            filler_h,
            filler_th,
            filler_origin,"");

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
        String id=get_id();

        Piece_model filler = Piece_model(
            id ,
            'filler_$id',
            "H",
            init_material_name,
            filler_w,
            filler_h,
            filler_th,
            filler_origin,"");

        box_pieces.add(filler);
      }
    }

    /// filler outside
    else{


      if(filler_model.corner==1||filler_model.corner==2){
        filler_w=filler_model.width;
        filler_h=box_height;
        filler_th=filler_model.thickness;
      }else{
        filler_w= box_width;
        filler_h=filler_model.width ;
        filler_th=filler_model.thickness;

      }
      Piece_model p =  box_pieces.where((element) => element.piece_name=="left").first;

      double origin_x=p.piece_origin.x_coordinate;
      double origin_y=p.piece_origin.y_coordinate;
      double origin_z=p.piece_origin.z_coordinate;




      if (filler_model.corner == 1) {
        x = origin_x-filler_model.width;
        y = origin_y ;
        z = origin_z ;
      }
      else if (filler_model.corner == 2) {
        x = origin_x+box_width;
        y = origin_y ;
        z = origin_z ;
      }
      else if (filler_model.corner == 3) {
        x = origin_x;
        y = origin_y +box_height  ;
        z = origin_z  ;
      }
      else if (filler_model.corner == 4){
        x = origin_x;
        y = origin_y -filler_h ;
        z = origin_z  ;
      }



      Point_model filler_origin = Point_model(x, y, z);
      String id=get_id();

      Piece_model filler = Piece_model(
          id ,
          'filler_$id',
          "F",
          init_material_name,
          filler_w,
          filler_h,
          filler_th,
          filler_origin,"");

      box_pieces.add(filler);
    }

  }

  double  correct_value(double v){
    double resault= double.parse(v.toStringAsFixed(2));
    return resault;
  }


  delete_piece(Piece_model piece_model){

    String inner_1="${piece_model.enner_name}_1";
    String inner_2="${piece_model.enner_name}_2";

    Piece_model old_inner=box_deleted_pieces.where((element) => element.piece_name==piece_model.enner_name).first;


    box_pieces.removeWhere((element) => element.piece_name==inner_1);
    box_pieces.removeWhere((element) => element.piece_name==inner_2);

    box_pieces.add(old_inner);

    box_pieces.removeWhere((element) => element.piece_id==piece_id);



  }


}
