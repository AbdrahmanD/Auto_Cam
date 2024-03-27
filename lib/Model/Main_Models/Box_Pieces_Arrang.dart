

import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Group_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';

class Box_Pieces_Arrang {

  late Box_model box_model;

  List<Piece_model> body=[];
  List<Piece_model> shelves=[];
  List<Piece_model> partitions=[];
  List<Piece_model> doors=[];
  List<List<Group_model> > drawers=[];
  List<Piece_model> supports=[];
  List<Piece_model> back_panels=[];


  Box_Pieces_Arrang(this.box_model){
    for(Piece_model p in box_model.box_pieces){

      /// body
      if(p.piece_name.contains("Helper"))
      {
        continue;
      }

      /// body
      if(
          (p.piece_name.contains("top") ||
          p.piece_name.contains("base") ||
          p.piece_name.contains("right") ||
          p.piece_name.contains("left")

          )
              &&(!p.piece_name.contains("Door"))
      &&!(p.piece_name.contains("Drawer"))
      )
      {
        body.add(p);
      }

      /// shelves
      else if(
      p.piece_name.contains("shelf")
      )
      {
        shelves.add(p);
      }

      /// partitions
      else if(
      p.piece_name.contains("partition")
      )
      {
        partitions.add(p);
      }

      /// doors
      else if(
      p.piece_name.contains("Door")
      )
      {
        doors.add(p);
      }

      /// supports
      else if(
      p.piece_name.contains("support")
      )
      {
        supports.add(p);
      }

      /// drawers
      else if(
      p.piece_name.contains("Drawer")
      )
      {
continue;
      }


      /// back_panels
      else if(
      p.piece_name.contains("back_panel")
      )
      {
        back_panels.add(p);
      }

    }

         drawers=box_model.drawer_groups;




  }





}
