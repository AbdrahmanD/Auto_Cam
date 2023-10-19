import 'dart:math';

import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:vector_math/vector_math.dart';

class CameraTransformer {
  double C_x, C_y, C_z; // Camera position in world coordinates

  double yaw;   // Yaw angle (rotation around the vertical axis)
  double pitch; // Pitch angle (rotation around the horizontal axis)
  double roll;  // Roll angle (rotation around the line of sight)

  CameraTransformer(
    this.C_x,
    this.C_y,
    this.C_z,
    this.yaw,
    this.pitch,
    this.roll,
  );

  // Function to transform a 3D point to new camera coordinates
  Point_model transform(Point_model point) {

    // Translate the point to a new coordinate system with the camera at the origin
    double P_translated_x = point.x_coordinate - C_x;
    double P_translated_y = point.y_coordinate - C_y;
    double P_translated_z = point.z_coordinate - C_z;

    // Convert the Euler angles to rotation matrices (assuming ZYX rotation order)
    Matrix4 Rx = Matrix4(
      1, 0, 0, 0,
      0, cos(roll), -sin(roll), 0,
      0, sin(roll), cos(roll), 0,
      0, 0, 0, 1,
    );

    Matrix4 Ry = Matrix4(
      cos(pitch), 0, sin(pitch), 0,
      0, 1, 0, 0,
      -sin(pitch), 0, cos(pitch), 0,
      0, 0, 0, 1,
    );

    Matrix4 Rz = Matrix4(
      cos(yaw), -sin(yaw), 0, 0,
      sin(yaw), cos(yaw), 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    );

    // Combine the rotation matrices to get the final rotation matrix (Z * Y * X order)
    Matrix4 R_camera = Rz * Ry * Rx;

    // Apply the rotation to the translated point
    Vector3 P_camera = R_camera.transform3(Vector3(P_translated_x, P_translated_y, P_translated_z));

    // Return the transformed point in camera coordinates
    return Point_model(P_camera.x, P_camera.y, P_camera.z);
  }
  

  // Function to move a 3D point in camera coordinates
  Point_model move(Point_model point, double dx, double dy, double dz) {
    // Convert the Euler angles to rotation matrices (assuming ZYX rotation order)
    Matrix4 Rx = Matrix4(
      1, 0, 0, 0,
      0, cos(roll), -sin(roll), 0,
      0, sin(roll), cos(roll), 0,
      0, 0, 0, 1,
    );

    Matrix4 Ry = Matrix4(
      cos(pitch), 0, sin(pitch), 0,
      0, 1, 0, 0,
      -sin(pitch), 0, cos(pitch), 0,
      0, 0, 0, 1,
    );

    Matrix4 Rz = Matrix4(
      cos(yaw), -sin(yaw), 0, 0,
      sin(yaw), cos(yaw), 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    );

    // Combine the rotation matrices to get the final rotation matrix (Z * Y * X order)
    Matrix4 R_camera = Rz * Ry * Rx;

    // Apply the rotation to the translation vector to get the movement vector in camera coordinates
    Vector3 movementVector = R_camera.transform3(Vector3(dx, dy, dz));

    // Move the point by the calculated movement vector
    double x_c = point.x_coordinate + movementVector.x;
    double y_c = point.y_coordinate + movementVector.y;
    double z_c = point.z_coordinate + movementVector.z;

    // Return the new 3D point in camera coordinates after the movement
    return Point_model(x_c, y_c, z_c);
  }



  // Function to rotate a 3D shape about the X-axis in camera coordinates
Point_model rotate_X(Point_model old_point, double angle) {
    final double cosAngle = cos(angle);
    final double sinAngle = sin(angle);

      final double newY = old_point.y_coordinate * cosAngle - old_point.z_coordinate * sinAngle;
      final double newZ = old_point.y_coordinate * sinAngle + old_point.z_coordinate * cosAngle;

      Point_model rotated_point=Point_model(old_point.x_coordinate, newY, newZ);

    return rotated_point;
  }



}





