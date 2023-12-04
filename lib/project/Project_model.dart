import 'package:auto_cam/Model/Main_Models/Box_model.dart';

class Project_model{
  late String project_name;
  late int day;
  late int month;
  late int year;
  late String project_description;
  late String project_note;

  late List<Box_model> boxes;

  Project_model(this.project_name,
      this.day,
      this.month,
      this.year,
      this.project_description,
      this.project_note, this.boxes);



  Project_model.fromjson(Map<String,dynamic> map){

    project_name=map['project_name'];
    day=  map["day"];
    month=map["month"];
    year= map["year"];
    project_description=map["project_description"];
    project_note=map["project_note"];

    if(map["boxes"].length!=null){
this.boxes=[];
map["boxes"].forEach((v){
  boxes.add(Box_model.fromJson(v));
});
    }


  }


  Map <String , dynamic>  toJson(){
    Map<String , dynamic> map =Map<String , dynamic> ();
    map['project_name']= this.project_name;
    map["day"]=this.day;
    map["month"]=this.month;
    map["year"]=this.year;
    map["project_description"]=this.project_description;
    map["project_note"]=this.project_note;


    if(this.boxes!=null){
      map['boxes']=boxes.map((e) => e.toJson()).toList();
    }



    return map;
  }



}