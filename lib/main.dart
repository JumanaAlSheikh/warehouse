import 'package:flutter/material.dart';
import 'package:warehouse/pages/splashPage.dart';

void main() {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      showSemanticsDebugger: false,
      theme: ThemeData(primaryColor: Colors.praimarydark,hintColor: Colors.praimarydark,accentColor:Colors.red),
      showPerformanceOverlay: false,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}





/// IMPORTANT: running the following code on its own won't work as there is setup required for each platform head project.
/// Please download the complete example app from the GitHub repository where all the setup has been done




