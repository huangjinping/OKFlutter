import 'package:flutter/material.dart';

import 'SecendPage.dart';

class AutoPage extends StatefulWidget {
  const AutoPage({Key? key}) : super(key: key);

  @override
  State<AutoPage> createState() => _AutoPageState();
}

class _AutoPageState extends State<AutoPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("didChangeAppLifecycleState---1");

    if (state == AppLifecycleState.resumed) {
      print("didChangeAppLifecycleState---2");
    }
  }

  _onnext() {
    print("object");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SecendPag();
    })).then((value) => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Column(
            children: [
              Text("dat11a"),
              GestureDetector(
                  onTap: _onnext, child: Container(child: Text("点击跳转到下一个页面")))
            ],
          ),
        ],
      ),
    );
  }
}
