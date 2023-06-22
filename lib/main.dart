import 'package:final_exam_flutter/screen/todo/view/add_screen.dart';
import 'package:final_exam_flutter/screen/todo/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';
void main()
{
  runApp(
    Sizer(builder: (context, orientation, deviceType) =>GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => Home_screen()),
        GetPage(name: '/add', page: () => Add_screen()),
      ],
    ))
  );
}