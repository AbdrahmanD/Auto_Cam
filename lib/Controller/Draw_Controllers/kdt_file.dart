
import 'dart:io';


import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:path_provider/path_provider.dart';

class kdt_file {

  late String box_name;
  String kdt_file_content = "";
  late Piece_model piece_model;


  kdt_file(this.piece_model,this.box_name) {


    kdt_file_content += "<KDTPanelFormat>\n";

    kdt_file_content += "<PANEL>\n";
    kdt_file_content += "<CoordinateSystem>3</CoordinateSystem>\n";


    if(piece_model.piece_direction=="V")
    {
      kdt_file_content += "<PanelLength>${piece_model.piece_width}</PanelLength>\n";
      kdt_file_content += "<PanelWidth>${piece_model.piece_height}</PanelWidth>\n";

    }
    else if(piece_model.piece_direction=="H")
    {
      kdt_file_content += "<PanelLength>${piece_model.piece_height}</PanelLength>\n";
      kdt_file_content += "<PanelWidth>${piece_model.piece_width}</PanelWidth>\n";

    }
    else if(piece_model.piece_direction=="F")
    {
      kdt_file_content += "<PanelLength>${piece_model.piece_width}</PanelLength>\n";
      kdt_file_content += "<PanelWidth>${piece_model.piece_height}</PanelWidth>\n";

    }


    kdt_file_content +=
    "<PanelThickness>${piece_model.piece_thickness}</PanelThickness>\n";
    kdt_file_content += "<PanelName>${piece_model.piece_name}</PanelName>\n";
    kdt_file_content += "<PanelMaterial>${piece_model.material_name}</PanelMaterial>\n";
    kdt_file_content += "<PanelTexture>0</PanelTexture>\n";
    kdt_file_content += "<PanelQuantity>1</PanelQuantity>\n";

    kdt_file_content += "<Params>\n";
    kdt_file_content += '<Param Value=\'${piece_model
        .piece_height}\' Key=\'L\' Comment=\'Length\'/>\n';
    kdt_file_content += "<Param Value=\"${piece_model
        .piece_width}\" Key=\"W\" Comment=\"Width\"/>\n";
    kdt_file_content += "<Param Value=\"${piece_model
        .piece_thickness}\" Key=\"T\" Comment=\"Thickness\"/>\n";
    kdt_file_content += "</Params>\n";

    kdt_file_content += "</PANEL>\n";


    //
    // if (piece_model.piece_faces.top_face.join_list.length > 0) {
    //   for (int i = 0; i <
    //       piece_model.piece_faces.top_face.join_list.length; i++) {
    //     var x = piece_model.piece_faces.top_face.join_list[i].hole_point
    //         .x_coordinate;
    //     var y = piece_model.piece_faces.top_face.join_list[i].hole_point
    //         .y_coordinate;
    //     var z = piece_model.piece_thickness / 2;
    //     var d = piece_model.piece_faces.top_face.join_list[i].hole_diameter;
    //     var dpth = piece_model.piece_faces.top_face.join_list[i].hole_depth;
    //
    //     if (piece_model.piece_direction == 'V') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>4</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'H') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>8</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Back Vertical Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'F') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>4</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //   }
    // }
    //
    // if (piece_model.piece_faces.right_face.join_list.length > 0) {
    //   for (int i = 0; i <
    //       piece_model.piece_faces.right_face.join_list.length; i++) {
    //     var x = piece_model.piece_faces.right_face.join_list[i].hole_point
    //         .x_coordinate;
    //     var y = piece_model.piece_faces.right_face.join_list[i].hole_point
    //         .y_coordinate;
    //     var z = piece_model.piece_thickness / 2;
    //     var d = piece_model.piece_faces.right_face.join_list[i].hole_diameter;
    //     var dpth = piece_model.piece_faces.right_face.join_list[i].hole_depth;
    //
    //     if (piece_model.piece_direction == 'V') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>8</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Back Vertical Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'H') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>0</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>2</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'F') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>0</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>2</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //   }
    // }
    //
    // if (piece_model.piece_faces.left_face.join_list.length > 0) {
    //   for (int i = 0; i <
    //       piece_model.piece_faces.left_face.join_list.length; i++) {
    //     var x = piece_model.piece_faces.left_face.join_list[i].hole_point
    //         .x_coordinate;
    //     var y = piece_model.piece_faces.left_face.join_list[i].hole_point
    //         .y_coordinate;
    //     var z = piece_model.piece_thickness / 2;
    //     var d = piece_model.piece_faces.left_face.join_list[i].hole_diameter;
    //     var dpth = piece_model.piece_faces.left_face.join_list[i].hole_depth;
    //
    //     if (piece_model.piece_direction == 'V') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>1</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Vertical Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'H') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${piece_model.piece_height}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>1</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'F') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${piece_model.piece_width}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>1</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //   }
    // }
    //
    // if (piece_model.piece_faces.base_face.join_list.length > 0) {
    //   for (int i = 0; i <
    //       piece_model.piece_faces.base_face.join_list.length; i++) {
    //     var x = piece_model.piece_faces.base_face.join_list[i].hole_point
    //         .x_coordinate;
    //     var y = piece_model.piece_faces.base_face.join_list[i].hole_point
    //         .y_coordinate;
    //     var z = piece_model.piece_thickness / 2;
    //     var d = piece_model.piece_faces.base_face.join_list[i].hole_diameter;
    //     var dpth = piece_model.piece_faces.base_face.join_list[i].hole_depth;
    //
    //     if (piece_model.piece_direction == 'H') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>1</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Vertical Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'V') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>3</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'F') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>3</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //   }
    // }
    //
    // if (piece_model.piece_faces.front_face.join_list.length > 0) {
    //   for (int i = 0; i <
    //       piece_model.piece_faces.front_face.join_list.length; i++) {
    //     var x = piece_model.piece_faces.front_face.join_list[i].hole_point
    //         .x_coordinate;
    //     var y = piece_model.piece_faces.front_face.join_list[i].hole_point
    //         .y_coordinate;
    //     var z = piece_model.piece_thickness / 2;
    //     var d = piece_model.piece_faces.front_face.join_list[i].hole_diameter;
    //     var dpth = piece_model.piece_faces.front_face.join_list[i].hole_depth;
    //
    //     if (piece_model.piece_direction == 'F') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>1</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Vertical Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'V') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${piece_model.piece_width }</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>1</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'H') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${0}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>4</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //   }
    // }
    //
    // if (piece_model.piece_faces.back_face.join_list.length > 0) {
    //   for (int i = 0; i <
    //       piece_model.piece_faces.back_face.join_list.length; i++) {
    //     var x = piece_model.piece_faces.back_face.join_list[i].hole_point
    //         .x_coordinate;
    //     var y = piece_model.piece_faces.back_face.join_list[i].hole_point
    //         .y_coordinate;
    //     var z = piece_model.piece_thickness / 2;
    //     var d = piece_model.piece_faces.back_face.join_list[i].hole_diameter;
    //     var dpth = piece_model.piece_faces.back_face.join_list[i].hole_depth;
    //
    //     if (piece_model.piece_direction == 'F') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>8</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Back Vertical Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'V') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${piece_model.piece_width}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>1</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //     else if (piece_model.piece_direction == 'H') {
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += "  <TypeNo>2</TypeNo>\n";
    //       kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
    //       kdt_file_content += "  <X1>${x}</X1>\n";
    //       kdt_file_content += "  <Y1>${y}</Y1>\n";
    //       kdt_file_content += "  <Z1>${z}</Z1>\n";
    //       kdt_file_content += "  <Quadrant>3</Quadrant>\n";
    //       kdt_file_content += "  <Depth>${dpth}</Depth>\n";
    //       kdt_file_content += "  <Diameter>${d}</Diameter>\n";
    //       kdt_file_content += "  <Enable>1</Enable>\n";
    //       kdt_file_content += " </CAD>\n";
    //     }
    //   }
    // }
    //
    //
    // ///////////////////////////////
    // ///////////////////////////////
    //
    // if(piece_model.piece_direction=="V"){
    //
    //   if (piece_model.piece_faces.right_face.groove_list.length > 0) {
    //
    //     for (int i = 0; i < piece_model.piece_faces.right_face.groove_list.length; i++) {
    //
    //       var x1 = piece_model.piece_faces.right_face.groove_list[i].start_point.x_coordinate;
    //       var y1 = piece_model.piece_faces.right_face.groove_list[i].start_point.y_coordinate;
    //       var x2= piece_model.piece_faces.right_face.groove_list[i].end_point.x_coordinate;
    //       var y2 = piece_model.piece_faces.right_face.groove_list[i].end_point.y_coordinate;
    //       var d = piece_model.piece_faces.right_face.groove_list[i].groove_depth;
    //       var width = piece_model.piece_faces.right_face.groove_list[i].groove_width;
    //
    //
    //         kdt_file_content += "<CAD>\n";
    //         kdt_file_content += " <TypeNo>13</TypeNo>\n";
    //         kdt_file_content += " <TypeName>Back Vertical Line</TypeName>\n";
    //         kdt_file_content += " <ToolName></ToolName>\n";
    //         kdt_file_content += " <BeginX>${x1}</BeginX>\n";
    //         kdt_file_content += " <BeginY>${y1}</BeginY>\n";
    //         kdt_file_content += " <EndX>${x2}</EndX>\n";
    //         kdt_file_content += " <EndY>${y2}</EndY>\n";
    //         kdt_file_content += " <Width>${width}</Width>\n";
    //         kdt_file_content += " <Correction>0</Correction>\n";
    //         kdt_file_content += " <Depth>${d}</Depth>\n";
    //         kdt_file_content += " <Enable>1</Enable>\n";
    //         kdt_file_content += " <UseSaw>0</UseSaw>\n";
    //         kdt_file_content += " <UseDZ>0</UseDZ>\n";
    //         kdt_file_content += " <BeginZ>0.00</BeginZ>\n";
    //         kdt_file_content += " <EndZ>0.00</EndZ>\n";
    //         kdt_file_content += "</CAD>\n";
    //
    //     }
    //
    //   }
    //
    //   if (piece_model.piece_faces.left_face.groove_list.length > 0) {
    //
    //     for (int i = 0; i < piece_model.piece_faces.left_face.groove_list.length; i++) {
    //
    //       var x1 = piece_model.piece_faces.left_face.groove_list[i].start_point.x_coordinate;
    //       var y1 = piece_model.piece_faces.left_face.groove_list[i].start_point.y_coordinate;
    //       var x2= piece_model.piece_faces.left_face.groove_list[i].end_point.x_coordinate;
    //       var y2 = piece_model.piece_faces.left_face.groove_list[i].end_point.y_coordinate;
    //       var d = piece_model.piece_faces.left_face.groove_list[i].groove_depth;
    //       var width = piece_model.piece_faces.left_face.groove_list[i].groove_width;
    //
    //
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += " <TypeNo>3</TypeNo>\n";
    //       kdt_file_content += " <TypeName>Vertical Line</TypeName>\n";
    //       kdt_file_content += " <ToolName></ToolName>\n";
    //       kdt_file_content += " <BeginX>${x1}</BeginX>\n";
    //       kdt_file_content += " <BeginY>${y1}</BeginY>\n";
    //       kdt_file_content += " <EndX>${x2}</EndX>\n";
    //       kdt_file_content += " <EndY>${y2}</EndY>\n";
    //       kdt_file_content += " <Width>${width}</Width>\n";
    //       kdt_file_content += " <Correction>0</Correction>\n";
    //       kdt_file_content += " <Depth>${d}</Depth>\n";
    //       kdt_file_content += " <Enable>1</Enable>\n";
    //       kdt_file_content += " <UseSaw>0</UseSaw>\n";
    //       kdt_file_content += " <UseDZ>0</UseDZ>\n";
    //       kdt_file_content += " <BeginZ>0.00</BeginZ>\n";
    //       kdt_file_content += " <EndZ>0.00</EndZ>\n";
    //       kdt_file_content += "</CAD>\n";
    //
    //     }
    //   }
    //
    // }
    //
    // else if(piece_model.piece_direction=="H"){
    //
    //   if (piece_model.piece_faces.top_face.groove_list.length > 0) {
    //
    //     for (int i = 0; i < piece_model.piece_faces.top_face.groove_list.length; i++) {
    //
    //       var x1 = piece_model.piece_faces.top_face.groove_list[i].start_point.x_coordinate;
    //       var y1 = piece_model.piece_faces.top_face.groove_list[i].start_point.y_coordinate;
    //       var x2= piece_model.piece_faces.top_face.groove_list[i].end_point.x_coordinate;
    //       var y2 = piece_model.piece_faces.top_face.groove_list[i].end_point.y_coordinate;
    //       var d = piece_model.piece_faces.top_face.groove_list[i].groove_depth;
    //       var width = piece_model.piece_faces.top_face.groove_list[i].groove_width;
    //
    //
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += " <TypeNo>13</TypeNo>\n";
    //       kdt_file_content += " <TypeName>Back Vertical Line</TypeName>\n";
    //       kdt_file_content += " <ToolName></ToolName>\n";
    //       kdt_file_content += " <BeginX>${x1}</BeginX>\n";
    //       kdt_file_content += " <BeginY>${y1}</BeginY>\n";
    //       kdt_file_content += " <EndX>${x2}</EndX>\n";
    //       kdt_file_content += " <EndY>${y2}</EndY>\n";
    //       kdt_file_content += " <Width>${width}</Width>\n";
    //       kdt_file_content += " <Correction>0</Correction>\n";
    //       kdt_file_content += " <Depth>${d}</Depth>\n";
    //       kdt_file_content += " <Enable>1</Enable>\n";
    //       kdt_file_content += " <UseSaw>0</UseSaw>\n";
    //       kdt_file_content += " <UseDZ>0</UseDZ>\n";
    //       kdt_file_content += " <BeginZ>0.00</BeginZ>\n";
    //       kdt_file_content += " <EndZ>0.00</EndZ>\n";
    //       kdt_file_content += "</CAD>\n";
    //
    //     }
    //
    //   }
    //
    //
    //   if (piece_model.piece_faces.base_face.groove_list.length > 0) {
    //
    //     for (int i = 0; i < piece_model.piece_faces.base_face.groove_list.length; i++) {
    //
    //       var x1 = piece_model.piece_faces.base_face.groove_list[i].start_point.x_coordinate;
    //       var y1 = piece_model.piece_faces.base_face.groove_list[i].start_point.y_coordinate;
    //       var x2= piece_model.piece_faces.base_face.groove_list[i].end_point.x_coordinate;
    //       var y2 = piece_model.piece_faces.base_face.groove_list[i].end_point.y_coordinate;
    //       var d = piece_model.piece_faces.base_face.groove_list[i].groove_depth;
    //       var width = piece_model.piece_faces.base_face.groove_list[i].groove_width;
    //
    //
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += " <TypeNo>3</TypeNo>\n";
    //       kdt_file_content += " <TypeName>Vertical Line</TypeName>\n";
    //       kdt_file_content += " <ToolName></ToolName>\n";
    //       kdt_file_content += " <BeginX>${x1}</BeginX>\n";
    //       kdt_file_content += " <BeginY>${y1}</BeginY>\n";
    //       kdt_file_content += " <EndX>${x2}</EndX>\n";
    //       kdt_file_content += " <EndY>${y2}</EndY>\n";
    //       kdt_file_content += " <Width>${width}</Width>\n";
    //       kdt_file_content += " <Correction>0</Correction>\n";
    //       kdt_file_content += " <Depth>${d}</Depth>\n";
    //       kdt_file_content += " <Enable>1</Enable>\n";
    //       kdt_file_content += " <UseSaw>0</UseSaw>\n";
    //       kdt_file_content += " <UseDZ>0</UseDZ>\n";
    //       kdt_file_content += " <BeginZ>0.00</BeginZ>\n";
    //       kdt_file_content += " <EndZ>0.00</EndZ>\n";
    //       kdt_file_content += "</CAD>\n";
    //
    //     }
    //
    //   }
    //
    // }
    //
    // else if(piece_model.piece_direction=="F"){
    //   if (piece_model.piece_faces.front_face.groove_list.length > 0) {
    //     {
    //
    //       for (int i = 0; i < piece_model.piece_faces.front_face.groove_list.length; i++) {
    //
    //         var x1 = piece_model.piece_faces.front_face.groove_list[i].start_point.x_coordinate;
    //         var y1 = piece_model.piece_faces.front_face.groove_list[i].start_point.y_coordinate;
    //         var x2= piece_model.piece_faces.front_face.groove_list[i].end_point.x_coordinate;
    //         var y2 = piece_model.piece_faces.front_face.groove_list[i].end_point.y_coordinate;
    //         var d = piece_model.piece_faces.front_face.groove_list[i].groove_depth;
    //         var width = piece_model.piece_faces.front_face.groove_list[i].groove_width;
    //
    //
    //         kdt_file_content += "<CAD>\n";
    //         kdt_file_content += " <TypeNo>3</TypeNo>\n";
    //         kdt_file_content += " <TypeName>Vertical Line</TypeName>\n";
    //         kdt_file_content += " <ToolName></ToolName>\n";
    //         kdt_file_content += " <BeginX>${x1}</BeginX>\n";
    //         kdt_file_content += " <BeginY>${y1}</BeginY>\n";
    //         kdt_file_content += " <EndX>${x2}</EndX>\n";
    //         kdt_file_content += " <EndY>${y2}</EndY>\n";
    //         kdt_file_content += " <Width>${width}</Width>\n";
    //         kdt_file_content += " <Correction>0</Correction>\n";
    //         kdt_file_content += " <Depth>${d}</Depth>\n";
    //         kdt_file_content += " <Enable>1</Enable>\n";
    //         kdt_file_content += " <UseSaw>0</UseSaw>\n";
    //         kdt_file_content += " <UseDZ>0</UseDZ>\n";
    //         kdt_file_content += " <BeginZ>0.00</BeginZ>\n";
    //         kdt_file_content += " <EndZ>0.00</EndZ>\n";
    //         kdt_file_content += "</CAD>\n";
    //
    //       }
    //
    //     }
    //   }
    //
    //   if (piece_model.piece_faces.back_face.groove_list.length > 0) {
    //
    //
    //     for (int i = 0; i < piece_model.piece_faces.back_face.groove_list.length; i++) {
    //
    //       var x1 = piece_model.piece_faces.back_face.groove_list[i].start_point.x_coordinate;
    //       var y1 = piece_model.piece_faces.back_face.groove_list[i].start_point.y_coordinate;
    //       var x2= piece_model.piece_faces.back_face.groove_list[i].end_point.x_coordinate;
    //       var y2 = piece_model.piece_faces.back_face.groove_list[i].end_point.y_coordinate;
    //       var d = piece_model.piece_faces.back_face.groove_list[i].groove_depth;
    //       var width = piece_model.piece_faces.back_face.groove_list[i].groove_width;
    //
    //
    //       kdt_file_content += "<CAD>\n";
    //       kdt_file_content += " <TypeNo>13</TypeNo>\n";
    //       kdt_file_content += " <TypeName>Back Vertical Line</TypeName>\n";
    //       kdt_file_content += " <ToolName></ToolName>\n";
    //       kdt_file_content += " <BeginX>${x1}</BeginX>\n";
    //       kdt_file_content += " <BeginY>${y1}</BeginY>\n";
    //       kdt_file_content += " <EndX>${x2}</EndX>\n";
    //       kdt_file_content += " <EndY>${y2}</EndY>\n";
    //       kdt_file_content += " <Width>${width}</Width>\n";
    //       kdt_file_content += " <Correction>0</Correction>\n";
    //       kdt_file_content += " <Depth>${d}</Depth>\n";
    //       kdt_file_content += " <Enable>1</Enable>\n";
    //       kdt_file_content += " <UseSaw>0</UseSaw>\n";
    //       kdt_file_content += " <UseDZ>0</UseDZ>\n";
    //       kdt_file_content += " <BeginZ>0.00</BeginZ>\n";
    //       kdt_file_content += " <EndZ>0.00</EndZ>\n";
    //       kdt_file_content += "</CAD>\n";
    //
    //     }
    //
    //
    //   }
    // }

    kdt_file_content += "</KDTPanelFormat>";

    extract_xml_file(piece_model.piece_name);


  }

  extract_xml_file(String file_name)async{


    final directory = await getApplicationDocumentsDirectory();

    final Directory oldDirectory = Directory('${directory.path}/Auto_Cam');
    oldDirectory.createSync();


    final Directory newDirectory = Directory('${oldDirectory.path}/$box_name');
    newDirectory.createSync();

    final Directory finalDirectory = Directory('${newDirectory.path}/XML_files');
    finalDirectory.createSync();

    final path = await finalDirectory.path;
    File file =await File('$path/$file_name.xml');
    file.writeAsString('$kdt_file_content');




  }

}