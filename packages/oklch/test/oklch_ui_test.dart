import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';
import 'package:oklch/src/color_extensions.dart';
import 'package:oklch/src/ui/gradient_rect_slider_track_shape.dart';

class _TestRenderBox extends RenderBox {
  _TestRenderBox(this._size);

  final Size _size;

  @override
  Size get size => _size;
}

void main() {
  group('OKLCHColor', () {
    test('withOpacity returns updated alpha', () {
      const color = OKLCHColor(0.5, 0.1, 200, 0.8);

      final updated = color.withOpacity(0.25);

      expect(updated.alpha, 0.25);
      expect(updated.lightness, color.lightness);
      expect(updated.chroma, color.chroma);
      expect(updated.hue, color.hue);
    });

    test('rgbHex clamps channels', () {
      const color = OKLCHColor(1.2, 0.8, 40);

      final hex = color.rgbHex;

      expect(hex.length, 7);
      expect(hex.startsWith('#'), isTrue);
    });

    test('mix returns endpoints for 0 and 1', () {
      const colorA = OKLCHColor(0.3, 0.1, 80);
      const colorB = OKLCHColor(0.8, 0.2, 250);

      final mixFullA = OKLCHColor.mix(colorA, colorB, 1);
      final mixFullB = OKLCHColor.mix(colorA, colorB, 0);

      expect(mixFullA.lightness, closeTo(colorA.lightness, 1e-6));
      expect(mixFullB.lightness, closeTo(colorB.lightness, 1e-6));
    });
  });

  group('ColorExtensions', () {
    test('toLinearRGB uses gamma correction', () {
      const color = Color(0xFFFFFFFF);

      final (r, g, b) = color.toLinearRGB();

      expect(r, closeTo(1, 1e-6));
      expect(g, closeTo(1, 1e-6));
      expect(b, closeTo(1, 1e-6));
    });
  });

  group('OKLABColor', () {
    test('round-trips OKLCH conversion', () {
      const source = OKLCHColor(0.7, 0.18, 210);

      final oklab = OKLABColor.fromOKLCH(source);
      final roundTrip = oklab.toOKLCH();

      expect(roundTrip.lightness, closeTo(source.lightness, 1e-6));
      expect(roundTrip.chroma, closeTo(source.chroma, 1e-6));
      expect(roundTrip.hue, closeTo(source.hue, 1e-6));
    });
  });

  group('OKLCHColorExtensions', () {
    test('mixWithOKLCHBlack returns black at 100%', () {
      const color = Color(0xFF4488CC);

      final mixed = color.mixWithOKLCHBlack(1);

      expect(mixed, equals(OKLCHColor.black.toColor()));
    });

    test('mixWithOKLCHWhite returns white at 100%', () {
      const color = Color(0xFF4488CC);

      final mixed = color.mixWithOKLCHWhite(1);

      expect(mixed, equals(OKLCHColor.white.toColor()));
    });
  });

  group('GradientRectSliderTrackShape', () {
    test('getPreferredRect matches parent size and track height', () {
      const trackShape =
          GradientRectSliderTrackShape([Colors.red, Colors.blue]);
      final parentBox = _TestRenderBox(const Size(200, 40));

      final rect = trackShape.getPreferredRect(
        parentBox: parentBox,
        sliderTheme: const SliderThemeData(trackHeight: 10),
        offset: const Offset(5, 8),
      );

      expect(rect.width, 200);
      expect(rect.height, 10);
      expect(rect.left, 5);
      expect(rect.top, closeTo(8 + (40 - 10) / 2, 1e-6));
    });
  });

  group('OKLCHColorPickerWidget', () {
    testWidgets('uses custom labels and spacing', (tester) async {
      const labels = OKLCHColorPickerLabels(
        previewTitle: 'Preview',
        lightnessLabel: 'Light',
        lightnessDescription: 'Lightness desc',
        chromaLabel: 'Chroma label',
        chromaDescription: 'Chroma desc',
        hueLabel: 'Hue label',
        hueDescription: 'Hue desc',
        oklchChipLabel: 'OKLCH values',
        hexChipLabel: 'Hex value',
        helperText: 'Helper text',
      );
      const spacing = OKLCHColorPickerSpacing(
        previewHeight: 100,
        previewRadius: 14,
        previewBottom: 12,
        sectionGap: 10,
        descriptionGap: 6,
        sliderGap: 9,
        chipSectionGap: 14,
        chipSpacing: 11,
        chipRunSpacing: 13,
        helperTextTop: 7,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: OKLCHColorPickerWidget(
              color: const Color(0xFF4488CC),
              labels: labels,
              spacing: spacing,
              onColorChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Preview'), findsOneWidget);
      expect(find.text('Lightness desc'), findsOneWidget);
      expect(find.text('Chroma desc'), findsOneWidget);
      expect(find.text('Hue desc'), findsOneWidget);
      expect(find.text('OKLCH values'), findsOneWidget);
      expect(find.text('Hex value'), findsOneWidget);
      expect(find.text('Helper text'), findsOneWidget);

      expect(
        find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.height == 12,
        ),
        findsOneWidget,
      );
    });
  });
}
