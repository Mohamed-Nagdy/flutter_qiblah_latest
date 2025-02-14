import 'package:flutter/material.dart';
import 'package:flutter_qiblah_latest/flutter_qiblah_latest.dart';
import 'package:flutter_qiblah_latest_example/loading_indicator.dart';
import 'package:flutter_qiblah_latest_example/qiblah_compass.dart';
import 'package:flutter_qiblah_latest_example/qiblah_maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff0c7b93),
        primaryColorLight: Color(0xff00a8cc),
        primaryColorDark: Color(0xff27496d),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xffecce6d),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xffecce6d),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingIndicator();
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error.toString()}"));
            }

            if (snapshot.data!) {
              return QiblahCompass();
            } else {
              return QiblahMaps();
            }
          },
        ),
      ),
    );
  }
}
