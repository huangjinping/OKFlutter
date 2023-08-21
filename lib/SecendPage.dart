import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecendPag extends StatefulWidget {
  const SecendPag({Key? key}) : super(key: key);

  @override
  State<SecendPag> createState() => _SecendPagState();
}

class _SecendPagState extends State<SecendPag>  {
  get http => null;

  _showClick() async {
    try {
      await _loadData();
    } catch (e) {}
    _showDialog();
    // Future.delayed(Duration(seconds: 3), () {
    //   _showDialog();
    // });
    // var asd = await _loadData();
    // _showDialog();
  }

  _loadData() async {
    var url = Uri.https('example.com', 'whatsit/create');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.https('example.com', 'foobar.txt')));
    return "d";
  }








  _showDialog() {
    print("_showDialog   ----------01");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              children: [
                Container(child: Text("Container")),
              ],
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("展示标题"),
      ),
      body: Container(
        child: GestureDetector(
            onTap: _showClick, child: Container(child: Text("弹出dialog"))),
      ),
    );
  }
}
