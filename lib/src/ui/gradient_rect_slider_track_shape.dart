import 'package:flutter/material.dart';

/// Slider track shape that renders a rounded rectangle with a gradient fill.
class GradientRectSliderTrackShape extends SliderTrackShape {
  /// Creates a gradient track shape for sliders.
  const GradientRectSliderTrackShape(
    this.colors, {
    this.borderRadius = const Radius.circular(12),
  });

  /// Colors used to build the linear gradient across the track.
  final List<Color> colors;

  /// Border radius applied to the gradient track.
  final Radius borderRadius;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset, // Add this parameter
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Gradient gradient = LinearGradient(
      colors: colors,
    );

    final paint = Paint()..shader = gradient.createShader(trackRect);
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, borderRadius),
      paint,
    );
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    // Define the shape and size of the slider track
    // Adjust these values as per your design needs
    final trackHeight = sliderTheme.trackHeight ?? 4;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
