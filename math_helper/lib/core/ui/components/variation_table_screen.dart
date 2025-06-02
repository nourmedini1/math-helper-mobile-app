import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_helper/features/function_plotting/data/models/plot_response.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class VariationTablePainter extends CustomPainter {
  final VariationTable table;
  final BuildContext context;

  VariationTablePainter(this.table, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final themeManager = Provider.of<ThemeManager>(context, listen: false);
    final isDark = themeManager.themeData.brightness == Brightness.dark;

    final columns = table.intervals!.length;
    const rows = 5; // x, f''(x), f'(x), f(x), arrows

    // Table size and margins
    final tableWidth = size.width * 0.92;
    final tableHeight = size.height * 0.82;
    final leftMargin = (size.width - tableWidth) / 2;
    final topMargin = (size.height - tableHeight) / 2;

    // Label column
    final labelColWidth = tableWidth * 0.18;
    final cellWidth = (tableWidth - labelColWidth) / columns;
    final cellHeight = tableHeight / rows;

    final gridColor = isDark ? Colors.white70 : Colors.black;
    final textColor = isDark ? Colors.white : Colors.black;
    final arrowColor = isDark ? Colors.lightBlueAccent : Colors.blue;

    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.2;

    // Draw vertical grid lines (including label column)
    for (int i = -1; i <= columns; i++) {
      final x = leftMargin + labelColWidth + i * cellWidth;
      canvas.drawLine(
        Offset(x, topMargin),
        Offset(x, topMargin + tableHeight),
        paint,
      );
    }
    // Draw the leftmost border
    canvas.drawLine(
      Offset(leftMargin, topMargin),
      Offset(leftMargin, topMargin + tableHeight),
      paint,
    );

    // Draw horizontal grid lines
    for (int i = 0; i <= rows; i++) {
      canvas.drawLine(
        Offset(leftMargin, topMargin + i * cellHeight),
        Offset(leftMargin + tableWidth, topMargin + i * cellHeight),
        paint,
      );
    }
    // Draw label column vertical line
    canvas.drawLine(
      Offset(leftMargin + labelColWidth, topMargin),
      Offset(leftMargin + labelColWidth, topMargin + tableHeight),
      paint,
    );

    final textStyle = TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w600);

    // Draw labels in the left column in the new order
    final labels = ['x', "f''(x)", "f'(x)", 'f(x)', "↗/↘"];
    for (int i = 0; i < labels.length; i++) {
      _drawText(
        canvas,
        labels[i],
        Offset(leftMargin + labelColWidth / 2, topMargin + i * cellHeight + cellHeight / 2),
        textStyle,
      );
    }

    // Draw x row (row 0): lower bound bottom left, upper bound top right
    for (int i = 0; i < columns; i++) {
      final interval = table.intervals![i];
      final lower = _formatNum(interval[0]);
      final upper = _formatNum(interval[1]);
      // Bottom left
      _drawTextAlign(
        canvas,
        lower,
        Offset(leftMargin + labelColWidth + i * cellWidth + 4, topMargin + cellHeight - 4),
        textStyle,
        align: Alignment.bottomLeft,
      );
      // Top right
      _drawTextAlign(
        canvas,
        upper,
        Offset(leftMargin + labelColWidth + (i + 1) * cellWidth - 4, topMargin + 4),
        textStyle,
        align: Alignment.topRight,
      );
    }

    // Draw f''(x) (row 1)
    for (int i = 0; i < columns; i++) {
      final f2 = table.secondDerivativeSign![i];
      _drawText(
        canvas,
        f2,
        Offset(leftMargin + labelColWidth + i * cellWidth + cellWidth / 2, topMargin + cellHeight * 1.5),
        textStyle,
      );
    }

    // Draw f'(x) (row 2)
    for (int i = 0; i < columns; i++) {
      final f1 = table.firstDerivativeSign![i];
      _drawText(
        canvas,
        f1,
        Offset(leftMargin + labelColWidth + i * cellWidth + cellWidth / 2, topMargin + cellHeight * 2.5),
        textStyle,
      );
    }

    // Draw f(x) (row 3): lower value bottom left, upper value top right
    for (int i = 0; i < columns; i++) {
      final vals = table.values![i];
      final lower = _formatNum(vals[0]);
      final upper = _formatNum(vals[1]);
      // Bottom left
      _drawTextAlign(
        canvas,
        lower,
        Offset(leftMargin + labelColWidth + i * cellWidth + 4, topMargin + cellHeight * 4 - cellHeight + cellHeight - 4),
        textStyle,
        align: Alignment.bottomLeft,
      );
      // Top right
      _drawTextAlign(
        canvas,
        upper,
        Offset(leftMargin + labelColWidth + (i + 1) * cellWidth - 4, topMargin + cellHeight * 3 + 4),
        textStyle,
        align: Alignment.topRight,
      );
    }

    // Draw arrows (row 4), perfectly centered
    for (int i = 0; i < columns; i++) {
      final dir = table.directions![i];
      final center = Offset(
        leftMargin + labelColWidth + i * cellWidth + cellWidth / 2,
        topMargin + cellHeight * 4.5,
      );
      if (dir == 'increasing') {
        _drawArrow(canvas, center, true, arrowColor);
      } else if (dir == 'decreasing') {
        _drawArrow(canvas, center, false, arrowColor);
      } else {
        _drawText(canvas, '?', center, textStyle);
      }
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

  void _drawTextAlign(Canvas canvas, String text, Offset pos, TextStyle style, {Alignment align = Alignment.center}) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    Offset offset = pos;
    if (align == Alignment.bottomLeft) {
      offset = pos - Offset(0, tp.height);
    } else if (align == Alignment.topRight) {
      offset = pos - Offset(tp.width, 0);
    }
    tp.paint(canvas, offset);
  }

  // Draws a longer, 45-degree arrow (↗ or ↘), perfectly centered in cell, with correct head
  void _drawArrow(Canvas canvas, Offset center, bool up, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    const length = 32.0;
    const headSize = 10.0;
    final angle = up ? -pi / 4 : pi / 4; // -45° or +45° in radians

    // Arrow shaft: center the arrow in the cell
    final start = center - Offset(length / 2 * cos(angle), length / 2 * sin(angle));
    final end = center + Offset(length / 2 * cos(angle), length / 2 * sin(angle));
    canvas.drawLine(start, end, paint);

    // Arrow head at the end (always at 'end', pointing in the correct direction)
    final headAngle1 = angle + pi / 1.5;
    final headAngle2 = angle - pi / 1.5;
    final head1 = end + Offset(headSize * cos(headAngle1), headSize * sin(headAngle1));
    final head2 = end + Offset(headSize * cos(headAngle2), headSize * sin(headAngle2));
    canvas.drawLine(end, head1, paint);
    canvas.drawLine(end, head2, paint);
  }

  String _formatNum(dynamic n) {
    if (n is num) {
      if (n == n.roundToDouble()) {
        return n.toStringAsFixed(0);
      } else {
        return n.toStringAsFixed(2);
      }
    }
    return n.toString();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

