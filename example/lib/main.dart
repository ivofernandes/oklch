import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oklch/oklch.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF7D87FF),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF0B0B12),
      cardColor: const Color(0xFF151825),
    );
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F61FF),
        brightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'OKLCH Color Picker Example',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: ColorPickerDemo(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class GradientSliderTrackShape extends SliderTrackShape {
  const GradientSliderTrackShape({
    required this.gradient,
  });

  final LinearGradient gradient;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 2.0;
    final trackLeft = offset.dx + (sliderTheme.thumbShape?.getPreferredSize(isEnabled, isDiscrete).width ?? 0) / 2;
    final trackWidth =
        parentBox.size.width - (sliderTheme.thumbShape?.getPreferredSize(isEnabled, isDiscrete).width ?? 0);
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final paint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..style = PaintingStyle.fill;
    final radius = Radius.circular(trackRect.height / 2);
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, radius),
      paint,
    );
  }
}

class ColorPickerDemo extends StatefulWidget {
  const ColorPickerDemo({
    required this.isDarkMode,
    required this.onToggleTheme,
    super.key,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  State<ColorPickerDemo> createState() => _ColorPickerDemoState();
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
    final r = (color.r * 255).round();
    final g = (color.g * 255).round();
    final b = (color.b * 255).round();
    rgbController.text = 'RGB($r, $g, $b)';
    oklchController.text = _oKLCHColor.toString();
    hexController.text = _oKLCHColor.rgbHex;
  }

  String _generateOKLCHUrl() {
    return 'https://oklch.com/#${_oKLCHColor.lightness.toStringAsFixed(2)},${_oKLCHColor.chroma.toStringAsFixed(2)},${_oKLCHColor.hue.toStringAsFixed(2)},100';
  }

  void _updateFromOKLCH({
    double? lightness,
    double? chroma,
    double? hue,
  }) {
    final updated = OKLCHColor(
      lightness ?? _oKLCHColor.lightness,
      chroma ?? _oKLCHColor.chroma,
      hue ?? _oKLCHColor.hue,
      _oKLCHColor.alpha,
    ).toColor();
    setState(() {
      _selectedColor = updated;
      _updateColorControllers(updated);
    });
  }

  List<Color> _gradientSamples({
    required double start,
    required double end,
    required Color Function(double value) builder,
    int steps = 6,
  }) {
    final samples = <Color>[];
    for (var i = 0; i < steps; i++) {
      final t = i / (steps - 1);
      final value = start + (end - start) * t;
      samples.add(builder(value));
    }
    return samples;
  }

  Widget _buildInfluenceRow({
    required String label,
    required String description,
    required List<Color> colors,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 12,
            trackShape: GradientSliderTrackShape(
              gradient: LinearGradient(colors: colors),
            ),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 8,
              pressedElevation: 4,
            ),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('OKLCH Color Picker Demo'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: widget.isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onToggleTheme,
          ),
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: OKLCHColorPickerWidget(
                        color: _selectedColor,
                        onColorChanged: (color) {
                          setState(() {
                            _selectedColor = color;
                            _updateColorControllers(color);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Color values',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: rgbController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'RGB Value',
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: oklchController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'OKLCH Value',
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: hexController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Hex Value',
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.copy),
                                label: const Text('Copy RGB'),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(text: rgbController.text),
                                  );
                                },
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.copy),
                                label: const Text('Copy OKLCH'),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: oklchController.text,
                                    ),
                                  );
                                },
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.copy),
                                label: const Text('Copy Hex'),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(text: hexController.text),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
