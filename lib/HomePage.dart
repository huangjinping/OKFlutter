import 'package:flutter/material.dart';
import 'package:okflutter/FirbaseTestPage.dart';
import 'package:okflutter/FirstPage.dart';

import 'AnimationPage.dart';
import 'AutoCompleteDemo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Wrap(
        children: [
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FirbaseTestPage();
              }));
            },
            child: Text("FireBase"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FirstPage();
              }));
            },
            child: Text("Image01"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AnimationPage();
              }));
            },
            child: Text("Animation"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AutoCompleteDemo();
              }));
            },
            child: Text("AutoComplete"),
          ),
        ],
      ),
    );
  }
}
