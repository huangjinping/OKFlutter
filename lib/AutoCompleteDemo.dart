import 'package:flutter/material.dart';
import 'package:okflutter/pop/CountriesField.dart';
import 'package:okflutter/pop/PopupWindow.dart';
import 'package:textfield_search/textfield_search.dart';

//https://www.duidaima.com/Group/Topic/Flutter/14545
class AutoCompleteDemo extends StatefulWidget {
  const AutoCompleteDemo({super.key});

  @override
  // 堆代码 duidaima.com
  // ignore: library_private_types_in_public_api
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  final List<Country> countries = [
    Country(id: 1, name: '中国'),
    Country(id: 2, name: '美国'),
    Country(id: 3, name: '印度'),
    Country(id: 4, name: '俄罗斯'),
    Country(id: 5, name: '英国'),
    Country(id: 6, name: '巴西'),
    Country(id: 7, name: '法国'),
    Country(id: 8, name: '德国'),
  ];

  Future<List> fetchData() async {
    await Future.delayed(Duration(milliseconds: 5000));
    List _list = [];
    String _inputText = myController.text;
    // create a list from the text input of three items
    // to mock a list of items from an http call
    _list.add(_inputText + ' Item 1');
    _list.add(_inputText + ' Item 2');
    _list.add(_inputText + ' Item 3');
    return _list;
  }

  var selectedCountry = '';
  GlobalKey popBottomKey = GlobalKey();
  TextEditingController myController = TextEditingController();

  inputListener(e, type) {
    late OverlayEntry _overlayEntry;

    PopupWindow.showPopWindow(
        context, "", popBottomKey, PopDirection.bottom, buildWidget(), 5);
  }

  buildWidget() {
    return Text("data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoComplete Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Expanded(child: Text("ddd")),


            Container(
                height: 1000,
                child: Text("data")),

            TextFieldSearch(
                label: "My Label",
                future: () {
                  return fetchData();
                },
                controller: myController),
            Container(
              height: 100,
            ),
            CountriesField(),

            Container(
              key: popBottomKey,
              height: 50,
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              alignment: Alignment(1, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: Colors.red)),
              child: TextField(
                style: TextStyle(
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                ),
                onChanged: (e) {
                  inputListener(e, 1);
                },
                cursorColor: Colors.red,
              ),
            ),
            Container(
              child: Autocomplete<Country>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return Future.delayed(const Duration(milliseconds: 100), () {
                    return countries
                        .where((country) =>
                            country.name.contains(textEditingValue.text))
                        .toList();
                  });
                },
                onSelected: (Country country) {
                  selectedCountry = country.name;
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onChanged: (text) {
                      selectedCountry = text;
                    },
                    decoration: const InputDecoration(
                      labelText: '国家',
                    ),
                  );
                },
                displayStringForOption: (Country country) =>
                    '[${country.id}] ${country.name}',
                initialValue: TextEditingValue(text: selectedCountry),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Country {
  final int id;
  final String name;

  Country({required this.id, required this.name});
}
