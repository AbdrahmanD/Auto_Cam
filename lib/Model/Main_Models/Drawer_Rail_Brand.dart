import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:get/get.dart';

class Drawer_Rail_Brand{


  late String       brand_name;
  late bool         brand_enable;

  late List<double> distances;

  late double diameter;
  late double depth;

 Drawer_Rail_Brand(this.brand_name, this.brand_enable, this.distances,this.diameter,this.depth){

   if(brand_name!="null") {
     save_patterns();
   }
  }

  Drawer_Rail_Brand.fromJson(Map<String,dynamic> map){

   this.brand_name=map["brand_name"];
   this.brand_enable=map["brand_enable"];
   this.diameter=map["diameter"];
   this.depth=map["depth"];
   if(map["distances"]!=null){
     distances=[];
     map["distances"].forEach((element){
       distances.add(element);
     });
   }
   if(brand_enable){
     save_patterns();
   }

  }

  Map<String,dynamic> toJson(){

   Map<String,dynamic> map={};

   map["brand_name"]=this.brand_name;
   map["brand_enable"]=this.brand_enable;
   map["diameter"]=this.diameter;
   map["depth"]=this.depth;
   map["distances"]=this.distances;

   return map;
  }

  save_patterns() async{

    Draw_Controller draw_controller = Get.find();

    draw_controller.box_repository.join_patterns["Drawer_Rail_Side"]=brand_to_drawer_side();
    draw_controller.box_repository.join_patterns["Drawer_Rail_Box"]=brand_to_drawer_box();

    //
    // List<JoinHolePattern> drawer_joinHolePattern=brand_to_drawer_side();
    //
    // List<JoinHolePattern> box_joinHolePattern   =brand_to_drawer_box();
    //
    // for(int i=0;i<drawer_joinHolePattern.length;i++) {
    //
    //   await draw_controller.save_joinHolePattern(
    //       drawer_joinHolePattern[i], "Drawer_Rail_Side");
    //
    //   await draw_controller.save_joinHolePattern(
    //       box_joinHolePattern[i], "Drawer_Rail_Box");
    //
    // }


  }


  List<JoinHolePattern> brand_to_drawer_side(){

    List<JoinHolePattern> drawer_patterns=[];

    Bore_model main_hole=Bore_model(Point_model(0,0,0), diameter, depth);
    Bore_model empty_hole=Bore_model(Point_model(0,0,0), 0, 0);


    // distances[0]

    Bore_unit unit_B=Bore_unit(distances[0]+distances[1], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
    Bore_unit unit_C=Bore_unit(distances[0]+distances[1]+distances[2], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
    Bore_unit unit_D=Bore_unit(distances[0]+distances[1]+distances[3], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
    Bore_unit unit_E=Bore_unit(distances[0]+distances[1]+distances[4], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
    Bore_unit unit_F=Bore_unit(distances[0]+distances[1]+distances[5], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
    Bore_unit unit_G=Bore_unit(distances[0]+distances[1]+distances[6], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
    Bore_unit unit_H=Bore_unit(distances[0]+distances[1]+distances[7], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);


    JoinHolePattern pattern_300=JoinHolePattern("${brand_name}_300", 299, 349, 1, 0, [ unit_B,unit_C,unit_E   ], brand_enable);
    JoinHolePattern pattern_350=JoinHolePattern("${brand_name}_350", 349, 399, 1, 0, [  unit_B,unit_C,unit_E,unit_F  ], brand_enable);
    JoinHolePattern pattern_400=JoinHolePattern("${brand_name}_400", 399, 449, 1, 0, [  unit_B,unit_C,unit_D,unit_F  ], brand_enable);
    JoinHolePattern pattern_450=JoinHolePattern("${brand_name}_450", 449, 499, 1, 0, [   unit_B,unit_C,unit_D,unit_G  ], brand_enable);
    JoinHolePattern pattern_500=JoinHolePattern("${brand_name}_500", 499, 549, 1, 0, [   unit_B,unit_C,unit_D,unit_G  ], brand_enable);
    JoinHolePattern pattern_550=JoinHolePattern("${brand_name}_550", 549, 599, 1, 0, [  unit_B,unit_C,unit_D,unit_G ,unit_H  ], brand_enable);
    JoinHolePattern pattern_600=JoinHolePattern("${brand_name}_600", 599, 650, 1, 0, [  unit_B,unit_C,unit_D,unit_G ,unit_H  ], brand_enable);


    drawer_patterns.add( pattern_300 );
    drawer_patterns.add( pattern_350 );
    drawer_patterns.add( pattern_400 );
    drawer_patterns.add( pattern_450 );
    drawer_patterns.add( pattern_500 );
    drawer_patterns.add( pattern_550 );
    drawer_patterns.add( pattern_600 );



    return drawer_patterns;

  }


  List<JoinHolePattern> brand_to_drawer_box(){

    List<JoinHolePattern> drawer_patterns=[];

    Bore_model main_hole=Bore_model(Point_model(0,0,0), diameter, depth);
    Bore_model empty_hole=Bore_model(Point_model(0,0,0), 0, 0);





  // distances[8]


  Bore_unit unit_J=Bore_unit(distances[8]+distances[9], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
  Bore_unit unit_K=Bore_unit(distances[8]+distances[9]+distances[10], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
  Bore_unit unit_L=Bore_unit(distances[8]+distances[9]+distances[11], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
  Bore_unit unit_M=Bore_unit(distances[8]+distances[9]+distances[12], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
  Bore_unit unit_N=Bore_unit(distances[8]+distances[9]+distances[13], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
  Bore_unit unit_O=Bore_unit(distances[8]+distances[9]+distances[14], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
  Bore_unit unit_P=Bore_unit(distances[8]+distances[9]+distances[15], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);
  Bore_unit unit_Q=Bore_unit(distances[8]+distances[9]+distances[16], 0, 0, empty_hole, false, 0, empty_hole, main_hole, false, false);



JoinHolePattern pattern_300=JoinHolePattern("${brand_name}_300", 299, 349, 1, 0, [ unit_J, unit_K  ], brand_enable);
JoinHolePattern pattern_350=JoinHolePattern("${brand_name}_350", 349, 399, 1, 0, [ unit_J, unit_K,unit_L  ], brand_enable);
JoinHolePattern pattern_400=JoinHolePattern("${brand_name}_400", 399, 449, 1, 0, [ unit_J,unit_K,unit_M,   ], brand_enable);
JoinHolePattern pattern_450=JoinHolePattern("${brand_name}_450", 449, 499, 1, 0, [ unit_J,unit_K,unit_M,unit_N   ], brand_enable);
JoinHolePattern pattern_500=JoinHolePattern("${brand_name}_500", 499, 549, 1, 0, [ unit_J,unit_K,unit_M, unit_O  ], brand_enable);
JoinHolePattern pattern_550=JoinHolePattern("${brand_name}_550", 549, 599, 1, 0, [ unit_J,unit_K,unit_M, unit_P  ], brand_enable);
JoinHolePattern pattern_600=JoinHolePattern("${brand_name}_600", 599, 650, 1, 0, [ unit_J,unit_K,unit_M, unit_P ,unit_Q ], brand_enable);


    drawer_patterns.add( pattern_300 );
    drawer_patterns.add( pattern_350 );
    drawer_patterns.add( pattern_400 );
    drawer_patterns.add( pattern_450 );
    drawer_patterns.add( pattern_500 );
    drawer_patterns.add( pattern_550 );
    drawer_patterns.add( pattern_600 );



    return drawer_patterns;

  }






}
