
import 'dart:io';


import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:path_provider/path_provider.dart';

class kdt_file {

  late String directory;
  String kdt_file_content = "";
  late Piece_model piece_model;


  kdt_file(this.directory,this.piece_model) {


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



    ///  Add boring hole for horizontal pieces
    if(piece_model.piece_direction=="H")
    {
      for(int f =0 ; f<piece_model.piece_faces.faces.length;f++){

        Single_Face single_face = piece_model.piece_faces.faces[f];

        if(single_face.name==1){
          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

                  kdt_file_content += "<CAD>\n";
                  kdt_file_content += "  <TypeNo>1</TypeNo>\n";
                  kdt_file_content += "  <TypeName>Vertical Hole</TypeName>\n";
                  kdt_file_content += "  <X1>${x}</X1>\n";
                  kdt_file_content += "  <Y1>${z}</Y1>\n";
                  kdt_file_content += "  <Depth>${dpth}</Depth>\n";
                  kdt_file_content += "  <Diameter>${d}</Diameter>\n";
                  kdt_file_content += "  <Enable>1</Enable>\n";
                  kdt_file_content += " </CAD>\n";

          }

          for(int g=0;g<single_face.groves.length;g++){

            Groove_model b=single_face.groves[g];

            double sx= b.start_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double sy= b.start_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double sz= b.start_point.z_coordinate-piece_model.piece_origin.z_coordinate;

            double ex= b.end_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double ey= b.end_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double ez= b.end_point.z_coordinate-piece_model.piece_origin.z_coordinate;



            double dpth=b.groove_depth;
            double dw= b.groove_width;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "<TypeNo>3</TypeNo>\n";
            kdt_file_content += "<TypeName>Vertical Line</TypeName>\n";
            kdt_file_content += "<ToolName></ToolName>\n";
            kdt_file_content += "<BeginX>$sx</BeginX>\n";
            kdt_file_content += "<BeginY>$sz</BeginY>\n";
            kdt_file_content += "<EndX>$ex</EndX>\n";
            kdt_file_content += "<EndY>$ez</EndY>\n";
            kdt_file_content += "<Width>$dw</Width>\n";
            kdt_file_content += "<Correction>0</Correction>\n";
            kdt_file_content += "<Depth>$dpth</Depth>\n";
            kdt_file_content += "<Enable>1</Enable>\n";
            kdt_file_content += "<UseSaw>0</UseSaw>\n";
            kdt_file_content += "<UseDZ>0</UseDZ>\n";
            kdt_file_content += "<BeginZ>0</BeginZ>\n";
            kdt_file_content += "<EndZ>0</EndZ>\n";
            kdt_file_content += "</CAD>\n";

          }

        }
        else if(single_face.name==2){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${z}</Y1>\n";
            kdt_file_content += "  <Z1>${y}</Z1>\n";
            kdt_file_content += "  <Quadrant>2</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }


        }
        else if(single_face.name==3){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>8</TypeNo>\n";
            kdt_file_content += "  <TypeName>Back Vertical Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${z}</Y1>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }

          for(int g=0;g<single_face.groves.length;g++){

            Groove_model b=single_face.groves[g];

            double sx= b.start_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double sy= b.start_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double sz= b.start_point.z_coordinate-piece_model.piece_origin.z_coordinate;

            double ex= b.end_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double ey= b.end_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double ez= b.end_point.z_coordinate-piece_model.piece_origin.z_coordinate;



            double dpth=b.groove_depth;
            double dw= b.groove_width;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "<TypeNo>13</TypeNo>\n";
            kdt_file_content += "<TypeName>Back Vertical Line</TypeName>\n";
            kdt_file_content += "<ToolName></ToolName>\n";
            kdt_file_content += "<BeginX>$sx</BeginX>\n";
            kdt_file_content += "<BeginY>$sz</BeginY>\n";
            kdt_file_content += "<EndX>$ex</EndX>\n";
            kdt_file_content += "<EndY>$ez</EndY>\n";
            kdt_file_content += "<Width>$dw</Width>\n";
            kdt_file_content += "<Correction>0</Correction>\n";
            kdt_file_content += "<Depth>$dpth</Depth>\n";
            kdt_file_content += "<Enable>1</Enable>\n";
            kdt_file_content += "<UseSaw>0</UseSaw>\n";
            kdt_file_content += "<UseDZ>0</UseDZ>\n";
            kdt_file_content += "<BeginZ>0</BeginZ>\n";
            kdt_file_content += "<EndZ>0</EndZ>\n";
            kdt_file_content += "</CAD>\n";

          }



        }
        else if(single_face.name==4){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${z}</Y1>\n";
            kdt_file_content += "  <Z1>${y}</Z1>\n";
            kdt_file_content += "  <Quadrant>1</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";

          }
        }
        else if(single_face.name==5){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${z}</Y1>\n";
            kdt_file_content += "  <Z1>${y}</Z1>\n";
            kdt_file_content += "  <Quadrant>3</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }

        }
        else if(single_face.name==6){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${z}</Y1>\n";
            kdt_file_content += "  <Z1>${y}</Z1>\n";
            kdt_file_content += "  <Quadrant>4</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";

          }
        }
      }

    }

    ///  Add boring hole for vertical pieces
    else if(piece_model.piece_direction=="V")
    {
      for(int f =0 ; f<piece_model.piece_faces.faces.length;f++){
        Single_Face single_face = piece_model.piece_faces.faces[f];

        if(single_face.name==2){
          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>1</TypeNo>\n";
            kdt_file_content += "  <TypeName>Vertical Hole</TypeName>\n";
            kdt_file_content += "  <X1>${z}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";

          }
          for(int g=0;g<single_face.groves.length;g++){

            Groove_model b=single_face.groves[g];

            double sx= b.start_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double sy= b.start_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double sz= b.start_point.z_coordinate-piece_model.piece_origin.z_coordinate;

            double ex= b.end_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double ey= b.end_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double ez= b.end_point.z_coordinate-piece_model.piece_origin.z_coordinate;



            double dpth=b.groove_depth;
            double dw= b.groove_width;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "<TypeNo>3</TypeNo>\n";
            kdt_file_content += "<TypeName>Vertical Line</TypeName>\n";
            kdt_file_content += "<ToolName></ToolName>\n";
            kdt_file_content += "<BeginX>$sz</BeginX>\n";
            kdt_file_content += "<BeginY>$sy</BeginY>\n";
            kdt_file_content += "<EndX>$ez</EndX>\n";
            kdt_file_content += "<EndY>$ey</EndY>\n";
            kdt_file_content += "<Width>$dw</Width>\n";
            kdt_file_content += "<Correction>0</Correction>\n";
            kdt_file_content += "<Depth>$dpth</Depth>\n";
            kdt_file_content += "<Enable>1</Enable>\n";
            kdt_file_content += "<UseSaw>0</UseSaw>\n";
            kdt_file_content += "<UseDZ>0</UseDZ>\n";
            kdt_file_content += "<BeginZ>0</BeginZ>\n";
            kdt_file_content += "<EndZ>0</EndZ>\n";
            kdt_file_content += "</CAD>\n";

          }


        }
        else if(single_face.name==4){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>8</TypeNo>\n";
            kdt_file_content += "  <TypeName>Back Vertical Hole</TypeName>\n";
            kdt_file_content += "  <X1>${z}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }
          for(int g=0;g<single_face.groves.length;g++){

            Groove_model b=single_face.groves[g];

            double sx= b.start_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double sy= b.start_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double sz= b.start_point.z_coordinate-piece_model.piece_origin.z_coordinate;

            double ex= b.end_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double ey= b.end_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double ez= b.end_point.z_coordinate-piece_model.piece_origin.z_coordinate;



            double dpth=b.groove_depth;
            double dw= b.groove_width;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "<TypeNo>13</TypeNo>\n";
            kdt_file_content += "<TypeName>Back Vertical Line</TypeName>\n";
            kdt_file_content += "<ToolName></ToolName>\n";
            kdt_file_content += "<BeginX>$sz</BeginX>\n";
            kdt_file_content += "<BeginY>$sy</BeginY>\n";
            kdt_file_content += "<EndX>$ez</EndX>\n";
            kdt_file_content += "<EndY>$ey</EndY>\n";
            kdt_file_content += "<Width>$dw</Width>\n";
            kdt_file_content += "<Correction>0</Correction>\n";
            kdt_file_content += "<Depth>$dpth</Depth>\n";
            kdt_file_content += "<Enable>1</Enable>\n";
            kdt_file_content += "<UseSaw>0</UseSaw>\n";
            kdt_file_content += "<UseDZ>0</UseDZ>\n";
            kdt_file_content += "<BeginZ>0</BeginZ>\n";
            kdt_file_content += "<EndZ>0</EndZ>\n";
            kdt_file_content += "</CAD>\n";

          }


        }
        else if(single_face.name==5){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${z}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Z1>${x}</Z1>\n";
            kdt_file_content += "  <Quadrant>1</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";

          }
        }
        else if(single_face.name==6){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${z}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Z1>${x}</Z1>\n";
            kdt_file_content += "  <Quadrant>2</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }


        }

        else if(single_face.name==3){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${z}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Z1>${x}</Z1>\n";
            kdt_file_content += "  <Quadrant>3</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }

        }
        else if(single_face.name==1){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${z}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Z1>${x}</Z1>\n";
            kdt_file_content += "  <Quadrant>4</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";

          }
        }
      }

    }

    ///  Add boring hole for faces pieces
    else if(piece_model.piece_direction=="F")
    {
      for(int f =0 ; f<piece_model.piece_faces.faces.length;f++){
        Single_Face single_face = piece_model.piece_faces.faces[f];

        if(single_face.name==5){
          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>1</TypeNo>\n";
            kdt_file_content += "  <TypeName>Vertical Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";

          }

          for(int g=0;g<single_face.groves.length;g++){

            Groove_model b=single_face.groves[g];

            double sx= b.start_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double sy= b.start_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double sz= b.start_point.z_coordinate-piece_model.piece_origin.z_coordinate;

            double ex= b.end_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double ey= b.end_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double ez= b.end_point.z_coordinate-piece_model.piece_origin.z_coordinate;



            double dpth=b.groove_depth;
            double dw= b.groove_width;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "<TypeNo>3</TypeNo>\n";
            kdt_file_content += "<TypeName>Vertical Line</TypeName>\n";
            kdt_file_content += "<ToolName></ToolName>\n";
            kdt_file_content += "<BeginX>$sx</BeginX>\n";
            kdt_file_content += "<BeginY>$sy</BeginY>\n";
            kdt_file_content += "<EndX>$ex</EndX>\n";
            kdt_file_content += "<EndY>$ey</EndY>\n";
            kdt_file_content += "<Width>$dw</Width>\n";
            kdt_file_content += "<Correction>0</Correction>\n";
            kdt_file_content += "<Depth>$dpth</Depth>\n";
            kdt_file_content += "<Enable>1</Enable>\n";
            kdt_file_content += "<UseSaw>0</UseSaw>\n";
            kdt_file_content += "<UseDZ>0</UseDZ>\n";
            kdt_file_content += "<BeginZ>0</BeginZ>\n";
            kdt_file_content += "<EndZ>0</EndZ>\n";
            kdt_file_content += "</CAD>\n";

          }


        }
        else if(single_face.name==2){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Z1>${z}</Z1>\n";
            kdt_file_content += "  <Quadrant>2</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }


        }
        else if(single_face.name==6){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>8</TypeNo>\n";
            kdt_file_content += "  <TypeName>Back Vertical Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }
          for(int g=0;g<single_face.groves.length;g++){

            Groove_model b=single_face.groves[g];

            double sx= b.start_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double sy= b.start_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double sz= b.start_point.z_coordinate-piece_model.piece_origin.z_coordinate;

            double ex= b.end_point.x_coordinate-piece_model.piece_origin.x_coordinate;
            double ey= b.end_point.y_coordinate-piece_model.piece_origin.y_coordinate;
            double ez= b.end_point.z_coordinate-piece_model.piece_origin.z_coordinate;



            double dpth=b.groove_depth;
            double dw= b.groove_width;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "<TypeNo>13</TypeNo>\n";
            kdt_file_content += "<TypeName>Back Vertical Line</TypeName>\n";
            kdt_file_content += "<ToolName></ToolName>\n";
            kdt_file_content += "<BeginX>$sx</BeginX>\n";
            kdt_file_content += "<BeginY>$sy</BeginY>\n";
            kdt_file_content += "<EndX>$ex</EndX>\n";
            kdt_file_content += "<EndY>$ey</EndY>\n";
            kdt_file_content += "<Width>$dw</Width>\n";
            kdt_file_content += "<Correction>0</Correction>\n";
            kdt_file_content += "<Depth>$dpth</Depth>\n";
            kdt_file_content += "<Enable>1</Enable>\n";
            kdt_file_content += "<UseSaw>0</UseSaw>\n";
            kdt_file_content += "<UseDZ>0</UseDZ>\n";
            kdt_file_content += "<BeginZ>0</BeginZ>\n";
            kdt_file_content += "<EndZ>0</EndZ>\n";
            kdt_file_content += "</CAD>\n";

          }



        }
        else if(single_face.name==4){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Z1>${z}</Z1>\n";
            kdt_file_content += "  <Quadrant>1</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";

          }
        }
        else if(single_face.name==3){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Z1>${z}</Z1>\n";
            kdt_file_content += "  <Quadrant>3</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";


          }

        }
        else if(single_face.name==1){

          for(int h=0;h<single_face.bores.length;h++){

            Bore_model b=single_face.bores[h];
            double x= b.origin.x_coordinate-piece_model.piece_origin.x_coordinate;
            double y= b.origin.y_coordinate-piece_model.piece_origin.y_coordinate;
            double z= b.origin.z_coordinate-piece_model.piece_origin.z_coordinate;

            double dpth=b.depth;
            double d= b.diameter;

            kdt_file_content += "<CAD>\n";
            kdt_file_content += "  <TypeNo>2</TypeNo>\n";
            kdt_file_content += "  <TypeName>Horizontal Hole</TypeName>\n";
            kdt_file_content += "  <X1>${x}</X1>\n";
            kdt_file_content += "  <Y1>${y}</Y1>\n";
            kdt_file_content += "  <Z1>${z}</Z1>\n";
            kdt_file_content += "  <Quadrant>4</Quadrant>\n";
            kdt_file_content += "  <Depth>${dpth}</Depth>\n";
            kdt_file_content += "  <Diameter>${d}</Diameter>\n";
            kdt_file_content += "  <Enable>1</Enable>\n";
            kdt_file_content += " </CAD>\n";

          }
        }
      }

    }



    kdt_file_content += "</KDTPanelFormat>";

    extract_xml_file("${piece_model.piece_id}-${piece_model.piece_name}");


  }

  extract_xml_file( String file_name)async{


    final Directory finalDirectory = Directory('$directory');
    finalDirectory.createSync();

    final path = await finalDirectory.path;
    File file =await File("$path/$file_name.xml");

    // File file =await File('$file_path.xml');
    file.writeAsString('$kdt_file_content');
// print(directory);

  }

}
