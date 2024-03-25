import 'package:auto_cam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam/Model/Main_Models/Box_Pieces_Arrang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Box_Pieces_List extends StatefulWidget {
  const Box_Pieces_List({Key? key}) : super(key: key);

  @override
  State<Box_Pieces_List> createState() => _Box_Pieces_ListState();
}

class _Box_Pieces_ListState extends State<Box_Pieces_List> {

  Box_Repository box_repository = Get.find();

  late Box_Pieces_Arrang box_pieces_arrang;

  @override
  void initState() {
    // TODO: implement initState
    box_pieces_arrang = box_repository.arrange_box();

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return
      Container(
          width: 200, height: h-100, color: Colors.teal[100],
child: List_item([
"1",
"1",
"1",
"1",
]),

      );
  }
}

class List_item extends StatelessWidget {
double w1=200;
double h1=50;
late List<String> items;


List_item(this.items);

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Container(width: w1,height: h1, child: Row(
          children: [
            SizedBox(width: 16,),
            Icon(Icons.folder),
            Text("item name"),
            Checkbox(value: true, onChanged: (v){}),
          ],
        ),),
        Container(
          height: h1*items.length,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,i){
              return Row(
                children: [
                  SizedBox(width: h1,),
                  Text("${items[i]}"),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class final_List_item extends StatelessWidget {
  double w1=100;
  double h1=50;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: w1,height: h1,
          child: Row(
            children: [
              SizedBox(width: h1,),
              Icon(Icons.folder),
              Text("item name"),
              Checkbox(value: true, onChanged: (v){}),
            ],
          ),)
      ],
    );
  }
}