import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Drawer_Rail_Brand.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Drawer_Slide_Setting extends StatefulWidget {
  const Drawer_Slide_Setting({Key? key}) : super(key: key);

  @override
  State<Drawer_Slide_Setting> createState() => _Drawer_Slide_SettingState();
}

class _Drawer_Slide_SettingState extends State<Drawer_Slide_Setting> {

  Draw_Controller draw_controller = Get.find();


  TextEditingController brand_name_controller = TextEditingController();
  TextEditingController depth_controller = TextEditingController();
  TextEditingController diameter_controller = TextEditingController();


  TextEditingController A_controller = TextEditingController();
  TextEditingController B_controller = TextEditingController();
  TextEditingController C_controller = TextEditingController();
  TextEditingController D_controller = TextEditingController();
  TextEditingController E_controller = TextEditingController();
  TextEditingController F_controller = TextEditingController();
  TextEditingController G_controller = TextEditingController();
  TextEditingController H_controller = TextEditingController();
  TextEditingController I_controller = TextEditingController();
  TextEditingController J_controller = TextEditingController();
  TextEditingController K_controller = TextEditingController();
  TextEditingController L_controller = TextEditingController();
  TextEditingController M_controller = TextEditingController();
  TextEditingController N_controller = TextEditingController();
  TextEditingController O_controller = TextEditingController();
  TextEditingController P_controller = TextEditingController();
  TextEditingController Q_controller = TextEditingController();


List<Drawer_Rail_Brand> brands=[];

int corrent_brand_index=0;
bool corrent_brand_enable=false;

  Drawer_Rail_Brand corrent_brand=Drawer_Rail_Brand("null", false, [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], 3, 3);

  read_patterns()async{

 await     draw_controller.read_brands();

 brands=draw_controller.box_repository.brands;

  corrent_brand=brands[corrent_brand_index];

 refresh();


setState(() {

});

  }

  enable_brand_changed(){

    if(corrent_brand.brand_enable){
      corrent_brand.brand_enable=false;
    }else{
      corrent_brand.brand_enable=true;
      for(Drawer_Rail_Brand b in brands){
        if (b.brand_name!=corrent_brand.brand_name) {
          b.brand_enable=false;
          draw_controller.save_brand(b);
        }
      }
    }
    corrent_brand_enable=corrent_brand.brand_enable;
    refresh();

    save_changed();

  }

  save_changed(){

    String brand_name=brand_name_controller.text.toString();

    double depth        =double.parse(depth_controller.text.toString());
    double diameter     =double.parse(diameter_controller.text.toString());

    bool brand_enable=corrent_brand_enable;


    double A    =double.parse(A_controller.text.toString());
    double B    =double.parse(B_controller.text.toString());
    double C    =double.parse(C_controller.text.toString());
    double D    =double.parse(D_controller.text.toString());
    double E    =double.parse(E_controller.text.toString());
    double F    =double.parse(F_controller.text.toString());
    double G    =double.parse(G_controller.text.toString());
    double H    =double.parse(H_controller.text.toString());
    double I    =double.parse(I_controller.text.toString());
    double J    =double.parse(J_controller.text.toString());
    double K    =double.parse(K_controller.text.toString());
    double L    =double.parse(L_controller.text.toString());
    double M    =double.parse(M_controller.text.toString());
    double N    =double.parse(N_controller.text.toString());
    double O    =double.parse(O_controller.text.toString());
    double P    =double.parse(P_controller.text.toString());
    double Q    =double.parse(Q_controller.text.toString());


    List<double> distances=[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q,];


Drawer_Rail_Brand corrent_brand=Drawer_Rail_Brand(brand_name, brand_enable, distances, diameter, depth);


draw_controller.save_brand(corrent_brand);


  }

  delete_category(){
    print(draw_controller.box_repository.brands.length);

  }



  refresh(){

corrent_brand=brands[corrent_brand_index];

     brand_name_controller.text="${corrent_brand.brand_name}";
     depth_controller.text="${corrent_brand.depth}";
     diameter_controller.text="${corrent_brand.diameter}";



    A_controller.text="${corrent_brand.distances[0]}";
    B_controller.text="${corrent_brand.distances[1]}";
    C_controller.text="${corrent_brand.distances[2]}";
    D_controller.text="${corrent_brand.distances[3]}";
    E_controller.text="${corrent_brand.distances[4]}";
    F_controller.text="${corrent_brand.distances[5]}";
    G_controller.text="${corrent_brand.distances[6]}";
    H_controller.text="${corrent_brand.distances[7]}";
    I_controller.text="${corrent_brand.distances[8]}";
    J_controller.text="${corrent_brand.distances[9]}";
    K_controller.text="${corrent_brand.distances[10]}";
    L_controller.text="${corrent_brand.distances[11]}";
    M_controller.text="${corrent_brand.distances[12]}";
    N_controller.text="${corrent_brand.distances[13]}";
    O_controller.text="${corrent_brand.distances[14]}";
    P_controller.text="${corrent_brand.distances[15]}";
    Q_controller.text="${corrent_brand.distances[16]}";



  }



  @override
  void initState() {

    read_patterns();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;



    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: w,height: h,
        child:
        Row(
          children: [
            Container(color: Colors.grey[100],
                width: 250,
                child: /// list of patterns
                Column(
                  children: [
                    SizedBox(height: 24,),
                    Text("Door patterns list",style: TextStyle(fontSize: 18),),

                    Container(
                        width: 200,
                        height: h - 450,
                        color: Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: ListView.builder(
                              itemCount: brands.length,
                              itemBuilder: (context, i) {

                                bool corrent = (corrent_brand_index == i);
                                bool enable_brand = brands[i].brand_enable;

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: enable_brand,
                                            onChanged: (v) {
                                              corrent_brand_index=i;
corrent_brand=brands[i];
setState(() {

});
                                              enable_brand_changed();

                                            }),

                                        InkWell(
                                          onTap: () {
                                            corrent_brand_index=i;
                                            refresh();
                                            setState(() {});
                                          },
                                          child: Container(
                                            width: corrent ? 150 : 100,
                                            color: corrent
                                                ? Colors.teal[200]
                                                : Colors.grey[100],
                                            child: Center(
                                              child: Text(
                                                "${brands[i].brand_name}",
                                                style: TextStyle(
                                                    fontSize: corrent ? 18 : 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )

                    ),

                    SizedBox(
                      height: 32,
                    ),

                    /// add new pattern
                    Container(
                      width: 65,
                      height: 65,
                      child: InkWell(
                        onTap: () {
                          // add_new_pattern();


                          // for (var v = 0; v<7; v++) {
                          //   print("side patterns length = ${draw_controller.box_repository.join_patterns["Drawer_Rail_Side"]![v].name}");
                          // }

                          print("side patterns length = ${draw_controller.box_repository.join_patterns["Drawer_Rail_Side"]!.length}");
                          print("box patterns length = ${draw_controller.box_repository.join_patterns["Drawer_Rail_Box"]!.length}");


                          },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.teal,
                          size: 24,
                        ),
                      ),
                    ),




                    SizedBox(
                      height: 12,
                    ),

                    /// save pattern
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          save_changed();
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'save changes',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    /// delete pattern
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          delete_category();
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.redAccent[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'delete brand',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 32,
                    ),



                  ],
                ),
            ),
            Container(width: 250,color: Colors.white54,
            child:
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [


                  SizedBox(height: 24,),
                  Center(child: Text("Brand initialize ",style: TextStyle(fontSize: 18),)),
                  SizedBox(height: 24,),

                  ///brand name
              Container(
                width: 100,
                height: 24,
                child: Center(
                  child: Center(
                    child: Text(
                      'Brand name',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: 100,
                height: 32,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  controller: brand_name_controller,
                  onChanged: (_) {},
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'add value please';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

               SizedBox(height: 12,),

                  ///depth
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'Depth',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 90,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: depth_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///diameter
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'Diameter',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 90,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: diameter_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),


                  Container(height: 2,color: Colors.grey,),

                  SizedBox(height: 12,),
                  ///A
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'A',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: A_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),


                  ///B
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'B',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: B_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///C
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'C',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: C_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///D
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'D',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: D_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///E
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'E',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: E_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///F
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'F',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: F_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///G
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'G',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: G_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///H
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'H',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: H_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///I
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'I',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: I_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///J
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'J',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: J_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12),

                  ///K
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'K',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: K_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),


                  ///L
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'L',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: L_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///M
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'M',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: M_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///N
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'N',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: N_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///O
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'O',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: O_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///P
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'P',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: P_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),

                  ///Q
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 24,
                        child: Center(
                          child: Center(
                            child: Text(
                              'Q',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [DecimalTextInputFormatter(2)],
                          controller: Q_controller,
                          onChanged: (_) {},
                          validator: (d) {
                            if (d!.isEmpty) {
                              return 'add value please';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ), SizedBox(height: 12,),


                ],
              ),
            ),),
            Container(
       color: Colors.white,       width: w-650,child:
            SingleChildScrollView(child: Image.asset("lib/assets/images/drawer_rail.png")),
            )
          ],
        ),
      ),
    );
  }
}
