

 import 'package:flutter/material.dart';
 import 'package:get/get.dart';




class Box_Fitting_Setting extends StatefulWidget {
  const Box_Fitting_Setting({Key? key}) : super(key: key);

  @override
  State<Box_Fitting_Setting> createState() => _Box_Fitting_SettingState();
}

class _Box_Fitting_SettingState extends State<Box_Fitting_Setting> {



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [

            Flexible(flex: 2,
              child: Column(
                children: [
Row(
  children: [
    Container(width: 100,height:50,child: Text("N"),),
    Container(width: 100,height:50,child: Text("N"),),


    Container(width: 100,height:100,child: Text("Depth"),),

    InkWell(onTap: (){
      Get.defaultDialog(
        title: "chose type ",
        content: Column(
          children: [
            InkWell(onTap: (){Navigator.of(Get.overlayContext!).pop();},child: Icon(Icons.add),),
            SizedBox(height: 32,),
            InkWell(onTap: (){Navigator.of(Get.overlayContext!).pop();},child: Icon(Icons.account_balance_outlined),),
          ],
        )
      );
    },
      child:     Container(width: 100,height:50,color: Colors.teal,child: Text("type"),),

    ),



  ],
)




                ],
              ),
            ),
            Flexible(flex: 1,child: Container(
              color: Colors.grey[100],

            ))
            ,
          ],
        ),
      );
  }
}
