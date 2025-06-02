

import 'package:flutter/material.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';

class VariationTablePainter extends CustomPainter {
  final VariationTable table;

  VariationTablePainter(this.table);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.2;

    final columns = table.intervals!.length;
    const rows = 4; // Intervals, Values, f', f''

    final cellWidth = size.width / columns;
    final cellHeight = size.height / rows;

    // Draw grid
    for (int i = 0; i <= columns; i++) {
      canvas.drawLine(
        Offset(i * cellWidth, 0),
        Offset(i * cellWidth, size.height),
        paint,
      );
    }
    for (int i = 0; i <= rows; i++) {
      canvas.drawLine(
        Offset(0, i * cellHeight),
        Offset(size.width, i * cellHeight),
        paint,
      );
    }

    const  textStyle = TextStyle(color: Colors.black, fontSize: 13);

    // Draw intervals
    for (int i = 0; i < columns; i++) {
      final interval = table.intervals![i];
      final text = '[${interval[0]}, ${interval[1]}]';
      _drawText(canvas, text, Offset(i * cellWidth + cellWidth / 2, cellHeight / 2), textStyle);
    }

    // Draw values
    for (int i = 0; i < columns; i++) {
      final vals = table.values![i];
      final text = '${vals[0]} → ${vals[1]}';
      _drawText(canvas, text, Offset(i * cellWidth + cellWidth / 2, cellHeight * 1.5), textStyle);
    }

    // Draw directions (arrows)
    for (int i = 0; i < columns; i++) {
      final dir = table.directions![i];
      final center = Offset(i * cellWidth + cellWidth / 2, cellHeight * 2.5);
      if (dir == 'increasing') {
        _drawArrow(canvas, center, true);
      } else if (dir == 'decreasing') {
        _drawArrow(canvas, center, false);
      } else {
        _drawText(canvas, '?', center, textStyle);
      }
    }

    // Draw f' and f'' signs
    for (int i = 0; i < columns; i++) {
      final f1 = table.firstDerivativeSign![i];
      final f2 = table.secondDerivativeSign![i];
      _drawText(canvas, "f': $f1", Offset(i * cellWidth + cellWidth / 2, cellHeight * 3.2), textStyle);
      _drawText(canvas, "f'': $f2", Offset(i * cellWidth + cellWidth / 2, cellHeight * 3.7), textStyle);
    }
  }

  void _drawText(Canvas canvas, String text, Offset center, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawArrow(Canvas canvas, Offset center, bool up) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;
    const  size = 12.0;
    if (up) {
      canvas.drawLine(center, center + const Offset(0, -size), paint);
      canvas.drawLine(center + const Offset(0, -size), center + const Offset(-4, -size + 6), paint);
      canvas.drawLine(center + const Offset(0, -size), center + const Offset(4, -size + 6), paint);
    } else {
      canvas.drawLine(center, center + const Offset(0, size), paint);
      canvas.drawLine(center + const Offset(0, size), center + const Offset(-4, size - 6), paint);
      canvas.drawLine(center + const Offset(0, size), center + const Offset(4, size - 6), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}