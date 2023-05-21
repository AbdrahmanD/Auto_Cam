import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Piece_Painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Piece_List_view extends StatefulWidget {
  const Piece_List_view({Key? key}) : super(key: key);

  @override
  State<Piece_List_view> createState() => _Piece_List_viewState();
}

class _Piece_List_viewState extends State<Piece_List_view> {

  Draw_Controller draw_controller=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal[200],),
      body: Container(
        width: double.infinity,height: double.infinity,color: Colors.grey[100],
        child: Row(
          children: [
            Container(width: 250,color: Colors.grey[300],

              child: Column(
                children: [
                  Container(  height: 70,child: Center(child: Text('List of Pieces',style: TextStyle(fontSize: 22),))),
                  Container( height: 50,child: Center(child: Text('to delete any piece from the cut list : un check it'))),
                  Container(height: 700,
                    child: ListView.builder(
                        itemCount: draw_controller.box_repository.box_model.value.box_pieces.length,
                        itemBuilder: (context,i){
                          if(draw_controller.box_repository.box_model.value.box_pieces[i].piece_name=='inner'){return SizedBox();}
                          else {return Row(
                            children: [
                              Checkbox(value: false, onChanged: (v){}),
                              SizedBox(height: 12,),
                              Text(draw_controller.box_repository.box_model.value.box_pieces[i].piece_name)
                            ],
                          );
                        }}
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12,),
            Container(width: 600,color: Colors.grey[300],

              child: ListView.builder(
                  itemCount: draw_controller.box_repository.box_model.value.box_pieces.length,
                  itemBuilder: (context,i){
                    if(draw_controller.box_repository.box_model.value.box_pieces[i].piece_name=='inner'){return SizedBox();}

                    else{
                      return Column(
                        children: [
                          Container(width: 500,color: Colors.white,height: 700,child:
                          CustomPaint(
                            painter: Piece_Painter(draw_controller.box_repository.box_model.value.box_pieces[i]),
                          )),
                          SizedBox(height: 33,)
                        ],
                      );
                    }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
