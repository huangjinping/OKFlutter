import 'package:flutter/material.dart';

class CountriesField extends StatefulWidget {
  const CountriesField({super.key});

  @override
  State<CountriesField> createState() => _CountriesFieldState();
}

class _CountriesFieldState extends State<CountriesField> {
  final FocusNode _focusNode = FocusNode();

  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
      } else {
        this._overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 5.0,
              width: size.width,
              child: Material(
                elevation: 4.0,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text('Syria'),
                    ),
                    ListTile(
                      title: Text('Lebanon'),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: this._focusNode,
      decoration: const InputDecoration(labelText: "Country"),
    );
  }
}
