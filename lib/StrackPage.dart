import 'package:flutter/material.dart';

class Strackpage extends StatefulWidget {
  const Strackpage({super.key});

  @override
  State<Strackpage> createState() => _StrackpageState();
}

class _StrackpageState extends State<Strackpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Thumbnail')),
      body: Container(

        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Text('Hello World'),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0), // 根据需要调整内边距
                child: Text('Hello World'),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // 设置圆角大小
              child: Container(
                color: Colors.blue, // 容器颜色
                child: Center(child: Text('Hello World')), // 子组件
              ),
            )
            ,
            ElevatedButton(
              onPressed: () => print('Clicked'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('Submit'),
            ),
            Text("ddd"),
          ],
        ),
      ),
    );
  }
}
