import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Box_Fitting_Editor extends StatefulWidget {
  late JoinHolePattern pattern;
  late double width;
  late double height;
  late double thickness;

  Box_Fitting_Editor(this.width, this.height, this.pattern,this.thickness);

  @override
  State<Box_Fitting_Editor> createState() => _Box_Fitting_EditorState();
}

class _Box_Fitting_EditorState extends State<Box_Fitting_Editor> {
  List<TextEditingController> _controller = [];
  String pattern_name="";

  @override
  Widget build(BuildContext context) {
    JoinHolePattern pattern = widget.pattern;
    double width = widget.width;
    double height = widget.height;
    double thickness = widget.thickness;

bool init_state=true;


    if(pattern_name==pattern.name){
      init_state=false;
    }

    List<Widget> list_text_editor() {
      double scale = 1.5;

      List<Widget> widget = [];

      widget.add(
        Positioned(
            top: 20,
            left: 200,
            child: Container(
              width: pattern.max_length * scale,
              height: 100,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Container(),
            )),
      );
      widget.add(
        Positioned(
            top: 150,
            left: 200,
            child: Container(
              width: pattern.max_length * scale,
              height: height / 2,
              decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Container(),
            )),
      );

      for (int i = 0; i < pattern.bores.length; i++) {

        _controller.add(TextEditingController());

        if(pattern.bores[i].have_nut_bore){
          if (pattern.bores[i].center)
          {
            if(init_state)
              _controller[i].text = "${pattern.max_length / 2}";
            ///face
            widget.add(Positioned(
                top: 90-thickness*scale/2,
                left: pattern.max_length * scale / 2 + 180,
                child: Container(
                  // color: Colors.blue,
                  width: 40,
                  height: 40,
                  child: Image.asset("lib/assets/images/blastic_nut.png"),
                )));
            ///screw or dowel
            widget.add(Positioned(
                top: 133,
                left: pattern.max_length * scale / 2 + 170,
                child: Container(
                  // color: Colors.blue,
                  width: 60,
                  height: 90,
                  child: Image.asset("lib/assets/images/screw.png"),
                )));
            ///nut
            widget.add(Positioned(
                top: 200,
                left: pattern.max_length * scale / 2 + 182,
                child: Container(
                  // color: Colors.blue,
                  width: 36,
                  height: 36,
                  child: Image.asset("lib/assets/images/nut.png"),
                )));


            ///text edit field
            widget.add(Positioned(
                top: 250,
                left: pattern.max_length * scale / 2 + 160,
                child: Container(
                  width: 80,
                  height: 30,
                  child: TextFormField(
                    controller: _controller[i],
                    style: TextStyle(fontSize: 12),
                    onChanged: (v) {
                      pattern.bores[i].pre_distence =
                          double.parse(_controller[i].text.toString());
                      setState(() {});
                    },
                    onEditingComplete: () {
                      _controller[i].text = "${pattern.max_length / 2}";
                    },
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
                )));
            /// delet bore button
            widget.add(Positioned(
                top: 300,
                left: pattern.max_length * scale / 2 - 11 + 200,
                child: InkWell(
                    onTap: () {
                      pattern.bores.removeAt(i);
                      setState(() {});
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                      size: 22,
                    ))));
          }
          else {
            if (pattern.bores[i].mirror)
            {
              if(init_state)
                _controller[i].text = "${pattern.bores[i].pre_distence}";

              /// main bore
              widget.add(Positioned(
                  top: 250,
                  left: pattern.bores[i].pre_distence * scale + 170,
                  child: Container(
                    width: 60,
                    height: 30,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller[i],
                      style: TextStyle(fontSize: 12),
                      onChanged: (v) {
                        pattern.bores[i].pre_distence =
                            double.parse(_controller[i].text.toString());
                        setState(() {});
                      },
                      onEditingComplete: () {
                        _controller[i].text = "${pattern.bores[i].pre_distence}";
                      },
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
                  )));

              /// delet bore button
              widget.add(Positioned(
                  top: 300,
                  left: pattern.bores[i].pre_distence * scale + 188,
                  child: InkWell(
                      onTap: () {
                        pattern.bores.removeAt(i);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 22,
                      ))));

              ///face
              widget.add(Positioned(
                  top: 90-thickness*scale/2,
                  left: pattern.bores[i].pre_distence * scale + 180,
                  child: Container(
                    // color: Colors.blue,
                    width: 40,
                    height: 40,
                    child: Image.asset("lib/assets/images/blastic_nut.png"),
                  )));
              ///screw or dowel
              widget.add(Positioned(
                  top: 133,
                  left: pattern.bores[i].pre_distence * scale + 170,
                  child: Container(
                    // color: Colors.blue,
                    width: 60,
                    height: 90,
                    child: Image.asset("lib/assets/images/screw.png"),
                  )));
              ///nut
              widget.add(Positioned(
                  top: 200,
                  left: pattern.bores[i].pre_distence * scale + 182,
                  child: Container(
                    // color: Colors.blue,
                    width: 36,
                    height: 36,
                    child: Image.asset("lib/assets/images/nut.png"),
                  )));



              ///mirror bore
              widget.add(Positioned(
                  top: 250,
                  left: 170 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),
                  child: Container(
                    width: 60,
                    height: 30,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller[i],
                      style: TextStyle(fontSize: 12),
                      onChanged: (v) {
                        pattern.bores[i].pre_distence =
                            double.parse(_controller[i].text.toString());
                        setState(() {});
                      },
                      onEditingComplete: () {
                        _controller[i].text = "${pattern.bores[i].pre_distence}";
                      },
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
                  )));

              /// delet bore button
              widget.add(Positioned(
                  top: 300,
                  left: 188 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),
                  child: InkWell(
                      onTap: () {
                        pattern.bores.removeAt(i);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 22,
                      ))));

              ///face
              widget.add(Positioned(
                  top: 90-thickness*scale/2,
                  left: 180 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),                child: Container(
                // color: Colors.blue,
                width: 40,
                height: 40,
                child: Image.asset("lib/assets/images/blastic_nut.png"),
              )));
              ///screw or dowel
              widget.add(Positioned(
                  top: 133,
                  left: 170 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),                child: Container(
                // color: Colors.blue,
                width: 60,
                height: 90,
                child: Image.asset("lib/assets/images/screw.png"),
              )));
              ///nut
              widget.add(Positioned(
                  top: 200,
                  left: 182 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),                child: Container(
                // color: Colors.blue,
                width: 36,
                height: 36,
                child: Image.asset("lib/assets/images/nut.png"),
              )));




            }
            else
            {

              if(init_state)
                _controller[i].text = "${pattern.bores[i].pre_distence}";

              ///bore
              widget.add(Positioned(
                  top: 250,
                  left: pattern.bores[i].pre_distence * scale + 170,
                  child: Container(
                    width: 60,
                    height: 30,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller[i],
                      style: TextStyle(fontSize: 12),
                      onChanged: (v) {
                        pattern.bores[i].pre_distence =
                            double.parse(_controller[i].text.toString());
                        setState(() {});
                      },
                      onEditingComplete: () {
                        _controller[i].text = "${pattern.bores[i].pre_distence}";
                      },
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
                  )));

              /// delet bore button
              widget.add(Positioned(
                  top: 280,
                  left: pattern.bores[i].pre_distence * scale + 192,
                  child: InkWell(
                      onTap: () {
                        pattern.bores.removeAt(i);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 16,
                      ))));

              ///face
              widget.add(Positioned(
                  top: 70-thickness*scale/2,
                  left: pattern.bores[i].pre_distence * scale + 175,
                  child: Container(
                    color: Colors.blue,
                    width: 50,
                    height: 50,
                    child: Image.asset("lib/assets/images/face_nut.png"),
                  )));
              ///screw or dowel
              widget.add(Positioned(
                  top: 100,
                  left: pattern.bores[i].pre_distence * scale + 175,
                  child: Container(
                    color: Colors.blue,
                    width: 50,
                    height: 50,
                    child: Image.asset("lib/assets/images/screw.png"),
                  )));
              ///nut
              widget.add(Positioned(
                  top: 200,
                  left: pattern.bores[i].pre_distence * scale + 175,
                  child: Container(
                    color: Colors.blue,
                    width: 50,
                    height: 50,
                    child: Image.asset("lib/assets/images/nut.png"),
                  )));



            }
          }
        }else{
          if (pattern.bores[i].center)
          {
            if(init_state)
              _controller[i].text = "${pattern.max_length / 2}";
            ///face
            widget.add(Positioned(
                top: 90-thickness*scale/2,
                left: pattern.max_length * scale / 2 + 180,
                child: Container(
                  // color: Colors.blue,
                  width: 40,
                  height: 40,
                  child: Image.asset("lib/assets/images/hole.png"),
                )));
            ///screw or dowel
            widget.add(Positioned(
                top: 133,
                left: pattern.max_length * scale / 2 + 170,
                child: Container(
                  // color: Colors.blue,
                  width: 60,
                  height: 90,
                  child: Image.asset("lib/assets/images/dowel.png"),
                )));
            ///nut



            ///text edit field
            widget.add(Positioned(
                top: 250,
                left: pattern.max_length * scale / 2 + 160,
                child: Container(
                  width: 80,
                  height: 30,
                  child: TextFormField(
                    controller: _controller[i],
                    style: TextStyle(fontSize: 12),
                    onChanged: (v) {
                      pattern.bores[i].pre_distence =
                          double.parse(_controller[i].text.toString());
                      setState(() {});
                    },
                    onEditingComplete: () {
                      _controller[i].text = "${pattern.max_length / 2}";
                    },
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
                )));
            /// delet bore button
            widget.add(Positioned(
                top: 300,
                left: pattern.max_length * scale / 2 - 11 + 200,
                child: InkWell(
                    onTap: () {
                      pattern.bores.removeAt(i);
                      setState(() {});
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                      size: 22,
                    ))));
          }
          else {
            if (pattern.bores[i].mirror)
            {
              if(init_state)
                _controller[i].text = "${pattern.bores[i].pre_distence}";

              /// main bore
              widget.add(Positioned(
                  top: 250,
                  left: pattern.bores[i].pre_distence * scale + 170,
                  child: Container(
                    width: 60,
                    height: 30,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller[i],
                      style: TextStyle(fontSize: 12),
                      onChanged: (v) {
                        pattern.bores[i].pre_distence =
                            double.parse(_controller[i].text.toString());
                        setState(() {});
                      },
                      onEditingComplete: () {
                        _controller[i].text = "${pattern.bores[i].pre_distence}";
                      },
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
                  )));

              /// delet bore button
              widget.add(Positioned(
                  top: 300,
                  left: pattern.bores[i].pre_distence * scale + 188,
                  child: InkWell(
                      onTap: () {
                        pattern.bores.removeAt(i);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 22,
                      ))));

              ///face
              widget.add(Positioned(
                  top: 90-thickness*scale/2,
                  left: pattern.bores[i].pre_distence * scale + 180,
                  child: Container(
                    // color: Colors.blue,
                    width: 40,
                    height: 40,
                    child: Image.asset("lib/assets/images/hole.png"),
                  )));
              ///screw or dowel
              widget.add(Positioned(
                  top: 133,
                  left: pattern.bores[i].pre_distence * scale + 170,
                  child: Container(
                    // color: Colors.blue,
                    width: 60,
                    height: 90,
                    child: Image.asset("lib/assets/images/dowel.png"),
                  )));




              ///mirror bore
              widget.add(Positioned(
                  top: 250,
                  left: 170 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),
                  child: Container(
                    width: 60,
                    height: 30,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller[i],
                      style: TextStyle(fontSize: 12),
                      onChanged: (v) {
                        pattern.bores[i].pre_distence =
                            double.parse(_controller[i].text.toString());
                        setState(() {});
                      },
                      onEditingComplete: () {
                        _controller[i].text = "${pattern.bores[i].pre_distence}";
                      },
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
                  )));

              /// delet bore button
              widget.add(Positioned(
                  top: 300,
                  left: 188 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),
                  child: InkWell(
                      onTap: () {
                        pattern.bores.removeAt(i);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 22,
                      ))));

              ///face
              widget.add(Positioned(
                  top: 90-thickness*scale/2,
                  left: 180 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),                child: Container(
                // color: Colors.blue,
                width: 40,
                height: 40,
                child: Image.asset("lib/assets/images/hole.png"),
              )));
              ///screw or dowel
              widget.add(Positioned(
                  top: 133,
                  left: 170 +
                      pattern.max_length * scale -
                      (pattern.bores[i].pre_distence * scale),                child: Container(
                // color: Colors.blue,
                width: 60,
                height: 90,
                child: Image.asset("lib/assets/images/dowel.png"),
              )));





            }
            else
            {

              if(init_state)
                _controller[i].text = "${pattern.bores[i].pre_distence}";

              ///bore
              widget.add(Positioned(
                  top: 250,
                  left: pattern.bores[i].pre_distence * scale + 170,
                  child: Container(
                    width: 60,
                    height: 30,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller[i],
                      style: TextStyle(fontSize: 12),
                      onChanged: (v) {
                        pattern.bores[i].pre_distence =
                            double.parse(_controller[i].text.toString());
                        setState(() {});
                      },
                      onEditingComplete: () {
                        _controller[i].text = "${pattern.bores[i].pre_distence}";
                      },
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
                  )));

              /// delet bore button
              widget.add(Positioned(
                  top: 280,
                  left: pattern.bores[i].pre_distence * scale + 192,
                  child: InkWell(
                      onTap: () {
                        pattern.bores.removeAt(i);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 16,
                      ))));

              ///face
              widget.add(Positioned(
                  top: 70-thickness*scale/2,
                  left: pattern.bores[i].pre_distence * scale + 175,
                  child: Container(
                    color: Colors.blue,
                    width: 50,
                    height: 50,
                    child: Image.asset("lib/assets/images/hole.png"),
                  )));
              ///screw or dowel
              widget.add(Positioned(
                  top: 100,
                  left: pattern.bores[i].pre_distence * scale + 175,
                  child: Container(
                    color: Colors.blue,
                    width: 50,
                    height: 50,
                    child: Image.asset("lib/assets/images/dowel.png"),
                  )));




            }
          }
        }


      }
      pattern_name=pattern.name;
      return widget;
    }

    return Stack(children: list_text_editor());
  }
}
