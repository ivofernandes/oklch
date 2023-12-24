import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oklch/oklch.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OKLCH Color Picker Example',
      home: ColorPickerDemo(),
    );
  }
}

class ColorPickerDemo extends StatefulWidget {
  @override
  _ColorPickerDemoState createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  Color _selectedColor = Colors.blue;
  TextEditingController rgbController = TextEditingController();
  TextEditingController oklchController = TextEditingController();
  TextEditingController hexController = TextEditingController(); // Hex controller

  List<double> _selectedOKLCH = [0,0,0];

  @override
  void initState() {
    super.initState();
    _selectedOKLCH = RGBtoOKLCH.convertColorToOKLCH(_selectedColor);
    _updateColorControllers(_selectedColor);
  }

  String colorToHex(Color color) {
    return '#${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  void _updateColorControllers(Color color) {
    _selectedOKLCH = OKLCHColor.convertColorToOKLCH(color);
    rgbController.text = 'RGB(${color.red}, ${color.green}, ${color.blue})';
    oklchController.text = 'OKLCH(${_selectedOKLCH[0].toStringAsFixed(2)}, ${_selectedOKLCH[1].toStringAsFixed(2)}, ${_selectedOKLCH[2].toStringAsFixed(2)})';
    hexController.text = colorToHex(color); // Update for hex value
  }

  String _generateOKLCHUrl() {
    return 'https://oklch.com/#${_selectedOKLCH[0].toStringAsFixed(2)},${_selectedOKLCH[1].toStringAsFixed(2)},${_selectedOKLCH[2].toStringAsFixed(2)},100';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OKLCH Color Picker Demo'),
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () {
              launchUrl(Uri.parse(_generateOKLCHUrl()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: _selectedColor,
              child: Center(
                child: Text(
                  'Background Color',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            OKLCHColorPicker(
              color: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                  _updateColorControllers(color);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: rgbController,
                decoration: InputDecoration(labelText: 'RGB Value'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: oklchController,
                decoration: InputDecoration(labelText: 'OKLCH Value'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: hexController,
                decoration: InputDecoration(labelText: 'Hex Value'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  child: Text('Copy RGB'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: rgbController.text));
                  },
                ),
                MaterialButton(
                  child: Text('Copy OKLCH'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: oklchController.text));
                  },
                ),
                MaterialButton(
                  child: Text('Copy Hex'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: hexController.text));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
