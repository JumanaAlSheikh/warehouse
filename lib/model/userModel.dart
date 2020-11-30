import 'dart:ffi';

import 'package:flutter/material.dart';





class User {

  String id,roleId,username;
  String sessionId;
  String RequireRestPassword;

  User(
      { this.id,
        this.roleId,
        this.username,
this.RequireRestPassword,
        this.sessionId,
       });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['Id'].toString(),
      roleId: json['RoleId'].toString(),
      username: json['Username'].toString(),
      sessionId: json['Session'],

        RequireRestPassword:json['RequireRestPassword'].toString()


    );
  }

}
