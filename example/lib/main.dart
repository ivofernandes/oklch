import 'package:flutter/material.dart';
import 'package:oklch/oklch.dart';

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

  @override
  void initState() {
    super.initState();
    _updateColorControllers(_selectedColor);
  }

  void _updateColorControllers(Color color) {
    // Assuming OKLCHColor has a method to convert Color to OKLCH
    var oklch = OKLCHColor.convertColorToOKLCH(color);
    rgbController.text = 'RGB(${color.red}, ${color.green}, ${color.blue})';
    oklchController.text =
    'OKLCH(${oklch[0].toStringAsFixed(2)}, ${oklch[1].toStringAsFixed(2)}, ${oklch[2].toStringAsFixed(2)})';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OKLCH Color Picker Demo'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: _selectedColor,
              child: Center(
                child: Text(
                  'Background Color',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
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
        ],
      ),
    );
  }
}
