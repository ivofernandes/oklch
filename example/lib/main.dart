import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oklch/oklch.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
  static Color startColor = Colors.blue;
  Color _selectedColor = startColor;
  TextEditingController rgbController = TextEditingController();
  TextEditingController oklchController = TextEditingController();
  TextEditingController hexController = TextEditingController();

  OKLCHColor _oKLCHColor = OKLCHColor.fromColor(startColor);

  @override
  void initState() {
    super.initState();
    _updateColorControllers(_selectedColor);
  }

  void _updateColorControllers(Color color) {
    _oKLCHColor = OKLCHColor.fromColor(color);
    rgbController.text = 'RGB(${color.red}, ${color.green}, ${color.blue})';
    oklchController.text = _oKLCHColor.textDescription;
    hexController.text = _oKLCHColor.rgbHex;
  }

  String _generateOKLCHUrl() {
    return 'https://oklch.com/#${_oKLCHColor.lightness.toStringAsFixed(2)},${_oKLCHColor.chroma.toStringAsFixed(2)},${_oKLCHColor.hue.toStringAsFixed(2)},100';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OKLCH Color Picker Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () {
              final String url = _generateOKLCHUrl();
              debugPrint(url);
              launchUrl(Uri.parse(url));
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
              child: const Center(
                child: Text(
                  'Background Color',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            OKLCHColorPickerWidget(
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
                decoration: const InputDecoration(labelText: 'RGB Value'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: oklchController,
                decoration: const InputDecoration(labelText: 'OKLCH Value'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: hexController,
                decoration: const InputDecoration(labelText: 'Hex Value'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  child: const Text('Copy RGB'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: rgbController.text));
                  },
                ),
                MaterialButton(
                  child: const Text('Copy OKLCH'),
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: oklchController.text));
                  },
                ),
                MaterialButton(
                  child: const Text('Copy Hex'),
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
