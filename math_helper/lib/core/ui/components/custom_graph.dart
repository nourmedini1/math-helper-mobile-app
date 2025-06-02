import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';

class CustomGraph extends StatefulWidget {
  final List<double> x1;
  final List<double> y1;
  final List<double> x2;
  final List<double> y2;
  final bool showFirst;
  final bool showSecond;
  final Color color1;
  final Color color2;
  final double strokeWidth1;
  final double strokeWidth2;
  final bool showDots1;
  final bool showDots2;
  final bool showArea1;
  final bool showArea2;
  final Color areaColor1;
  final Color areaColor2;
  final double xMin;
  final double xMax;
  final double yMin;
  final double yMax;
  final String functionName1;
  final String functionName2;

  const CustomGraph({
    super.key,
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    this.showFirst = true,
    this.showSecond = true,
    this.color1 = Colors.blue,
    this.color2 = Colors.red,
    this.strokeWidth1 = 2.0,
    this.strokeWidth2 = 2.0,
    this.showDots1 = false,
    this.showDots2 = false,
    this.showArea1 = false,
    this.showArea2 = false,
    this.areaColor1 = const Color(0x553197FA),
    this.areaColor2 = const Color(0x55FF5252),
    required this.xMin,
    required this.xMax,
    required this.yMin,
    required this.yMax,
    required this.functionName1,
    required this.functionName2,
  });

  @override
  State<CustomGraph> createState() => _CustomGraphState();
}

class _CustomGraphState extends State<CustomGraph> {
  Offset? _tooltipPosition;
  String? _tooltipText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _handleTooltip(details.localPosition, context),
      onLongPressStart: (details) => _handleTooltip(details.localPosition, context),
      onLongPressMoveUpdate: (details) => _handleTooltip(details.localPosition, context),
      onTapUp: (_) => setState(() {
        _tooltipPosition = null;
        _tooltipText = null;
      }),
      onLongPressEnd: (_) => setState(() {
        _tooltipPosition = null;
        _tooltipText = null;
      }),
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, 400),
            painter: GraphPainter(
              x1: widget.x1,
              y1: widget.y1,
              x2: widget.x2,
              y2: widget.y2,
              showFirst: widget.showFirst,
              showSecond: widget.showSecond,
              color1: widget.color1,
              color2: widget.color2,
              strokeWidth1: widget.strokeWidth1,
              strokeWidth2: widget.strokeWidth2,
              showDots1: widget.showDots1,
              showDots2: widget.showDots2,
              showArea1: widget.showArea1,
              showArea2: widget.showArea2,
              areaColor1: widget.areaColor1,
              areaColor2: widget.areaColor2,
              xMin: widget.xMin,
              xMax: widget.xMax,
              yMin: widget.yMin,
              yMax: widget.yMax,
              themeManager: Provider.of<ThemeManager>(context, listen: false),
              tooltipPosition: _tooltipPosition,
              tooltipText: _tooltipText,
              functionName1: widget.functionName1,
              functionName2: widget.functionName2,
            ),
            child: Container(height: 400),
          ),
          if (_tooltipPosition != null && _tooltipText != null)
            Positioned(
              left: _tooltipPosition!.dx,
              top: _tooltipPosition!.dy - 40,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _tooltipText!,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handleTooltip(Offset localPosition, BuildContext context) {
    // Find nearest point on either graph
    double minDist = double.infinity;
    String? tooltip;
    Offset? tooltipPos;

    RenderBox box = context.findRenderObject() as RenderBox;
    Size size = box.size;

    double pad = 40.0;
    double xRange = (widget.xMax - widget.xMin) == 0 ? 1 : (widget.xMax - widget.xMin);
    double yRange = (widget.yMax - widget.yMin) == 0 ? 1 : (widget.yMax - widget.yMin);
    double xScale = (size.width - 2 * pad) / xRange;
    double yScale = (size.height - 2 * pad) / yRange;

    double dataToScreenX(double x) => pad + (x - widget.xMin) * xScale;
    double dataToScreenY(double y) => size.height - pad - (y - widget.yMin) * yScale;

    void checkPoints(List<double> x, List<double> y, Color color) {
      for (int i = 0; i < x.length; i++) {
        final pt = Offset(dataToScreenX(x[i]), dataToScreenY(y[i]));
        final dist = (pt - localPosition).distance;
        if (dist < minDist && dist < 30) {
          minDist = dist;
          tooltip = 'x: ${_formatNumber(x[i])}\ny: ${_formatNumber(y[i])}';
          tooltipPos = pt;
        }
      }
    }

    if (widget.showFirst) checkPoints(widget.x1, widget.y1, widget.color1);
    if (widget.showSecond) checkPoints(widget.x2, widget.y2, widget.color2);

    setState(() {
      _tooltipText = tooltip;
      _tooltipPosition = tooltipPos;
    });
  }

  String _formatNumber(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(2);
    }
  }
}

class GraphPainter extends CustomPainter {
  final List<double> x1, y1, x2, y2;
  final bool showFirst, showSecond;
  final Color color1, color2;
  final double strokeWidth1, strokeWidth2;
  final bool showDots1, showDots2;
  final bool showArea1, showArea2;
  final Color areaColor1, areaColor2;
  final double xMin, xMax, yMin, yMax;
  final ThemeManager themeManager;
  final Offset? tooltipPosition;
  final String? tooltipText;
  final String functionName1;
  final String functionName2;

  GraphPainter({
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    required this.showFirst,
    required this.showSecond,
    required this.color1,
    required this.color2,
    required this.strokeWidth1,
    required this.strokeWidth2,
    required this.showDots1,
    required this.showDots2,
    required this.showArea1,
    required this.showArea2,
    required this.areaColor1,
    required this.areaColor2,
    required this.xMin,
    required this.xMax,
    required this.yMin,
    required this.yMax,
    required this.themeManager,
    required this.tooltipPosition,
    required this.tooltipText,
    required this.functionName1,
    required this.functionName2,
  });

   bool _isPeriodic(String function) {
    final f = function.toLowerCase();
    return f.contains('sin') || f.contains('cos') || f.contains('tan');
  }

  @override
  void paint(Canvas canvas, Size size) {
    const  pad = 10.0;
    final xRange = (xMax - xMin) == 0 ? 1 : (xMax - xMin);
    final yRange = (yMax - yMin) == 0 ? 1 : (yMax - yMin);
    final xScale = (size.width - 2 * pad) / xRange;
    final yScale = (size.height - 2 * pad) / yRange;

    // Y-axis at x = 0
    const  xAxisData = 0.0;
    // X-axis at y=0 if in range, else at yMin
    final yAxisData = (yMin <= 0 && yMax >= 0) ? 0.0 : yMin;

    double dataToScreenX(double x) => pad + (x - xMin) * xScale;
    double dataToScreenY(double y) => size.height - pad - (y - yMin) * yScale;

    // Theme-aware grid/axis color
    final isDark = themeManager.themeData == AppThemeData.darkTheme;
    final gridColor = isDark ? Colors.white24 : Colors.grey.withOpacity(0.3);
    final axisColor = isDark ? Colors.white : Colors.black;

    // Draw grid with fixed subdivisions
    _drawGrid(
      canvas,
      size,
      dataToScreenX,
      dataToScreenY,
      xMin,
      xMax,
      yMin,
      yMax,
      gridColor,
      axisColor,
      pad,
    );

    // Draw axes
    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 1.5;
    // X axis
    final yAxisScreen = dataToScreenY(yAxisData);
    canvas.drawLine(
      Offset(pad, yAxisScreen),
      Offset(size.width - pad, yAxisScreen),
      axisPaint,
    );
    // Y axis (middle)
    final xAxisScreen = dataToScreenX(xAxisData);
    canvas.drawLine(
      Offset(xAxisScreen, pad),
      Offset(xAxisScreen, size.height - pad),
      axisPaint,
    );

    // --- CLIP TO GRID AREA ---
    final gridRect = Rect.fromLTWH(pad, pad, size.width - 2 * pad, size.height - 2 * pad);
    canvas.save();
    canvas.clipRect(gridRect);

    // Draw plots and areas
    if (showFirst && x1.isNotEmpty && y1.isNotEmpty) {
      if (showArea1) {
        _drawArea(canvas, x1, y1, dataToScreenX, dataToScreenY, areaColor1, yAxisData);
      }
      _drawPlot(canvas, x1, y1, dataToScreenX, dataToScreenY, color1, strokeWidth1, showDots1, functionName: functionName1);
    }
    if (showSecond && x2.isNotEmpty && y2.isNotEmpty) {
      if (showArea2) {
        _drawArea(canvas, x2, y2, dataToScreenX, dataToScreenY, areaColor2, yAxisData);
      }
      _drawPlot(canvas, x2, y2, dataToScreenX, dataToScreenY, color2, strokeWidth2, showDots2, functionName: functionName2);
    }
    canvas.restore();

    // Draw border with background color to hide the grid border

    final borderPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(
      Rect.fromLTWH(pad, pad, size.width - 2 * pad, size.height - 2 * pad),
      borderPaint,
    );
  }

  void _drawPlot(
  Canvas canvas,
  List<double> x,
  List<double> y,
  double Function(double) dataToScreenX,
  double Function(double) dataToScreenY,
  Color color,
  double strokeWidth,
  bool showDots,
  {String? functionName}
) {
  if (x.length < 2) return;

  // Decide which interpolation to use
  if (functionName != null && _isPeriodic(functionName)) {
    _drawMonotonicCubicSpline(canvas, x, y, dataToScreenX, dataToScreenY, color, strokeWidth, showDots);
  } else {
    _drawCatmullRomSpline(canvas, x, y, dataToScreenX, dataToScreenY, color, strokeWidth, showDots);
  }
}

// Monotonic cubic interpolation (for periodic/oscillatory)
void _drawMonotonicCubicSpline(
  Canvas canvas,
  List<double> x,
  List<double> y,
  double Function(double) dataToScreenX,
  double Function(double) dataToScreenY,
  Color color,
  double strokeWidth,
  bool showDots,
) {
  final n = x.length;
  final m = List<double>.filled(n, 0);
  final d = List<double>.filled(n - 1, 0);

  for (int i = 0; i < n - 1; i++) {
    d[i] = (y[i + 1] - y[i]) / (x[i + 1] - x[i]);
  }

  m[0] = d[0];
  m[n - 1] = d[n - 2];
  for (int i = 1; i < n - 1; i++) {
    if (d[i - 1] * d[i] <= 0) {
      m[i] = 0;
    } else {
      m[i] = (d[i - 1] + d[i]) / 2;
    }
  }

  for (int i = 0; i < n - 1; i++) {
    if (d[i] == 0) {
      m[i] = 0;
      m[i + 1] = 0;
    } else {
      final a = m[i] / d[i];
      final b = m[i + 1] / d[i];
      final s = a * a + b * b;
      if (s > 9) {
        final t = 3 / sqrt(s);
        m[i] = t * a * d[i];
        m[i + 1] = t * b * d[i];
      }
    }
  }

  final plotPaint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke;

  final path = Path();
  path.moveTo(dataToScreenX(x[0]), dataToScreenY(y[0]));

  for (int i = 0; i < n - 1; i++) {
    final x0 = x[i];
    final x1 = x[i + 1];
    final y0 = y[i];
    final y1 = y[i + 1];
    final m0 = m[i];
    final m1 = m[i + 1];
    final dx = x1 - x0;

    for (int j = 1; j <= 16; j++) {
      final t = j / 16.0;
      final h00 = (2 * t * t * t) - (3 * t * t) + 1;
      final h10 = (t * t * t) - (2 * t * t) + t;
      final h01 = (-2 * t * t * t) + (3 * t * t);
      final h11 = (t * t * t) - (t * t);

      final xt = x0 + t * dx;
      final yt = h00 * y0 + h10 * dx * m0 + h01 * y1 + h11 * dx * m1;

      path.lineTo(dataToScreenX(xt), dataToScreenY(yt));
    }
  }

  canvas.drawPath(path, plotPaint);

  if (showDots) {
    for (int i = 0; i < x.length; i++) {
      final sx = dataToScreenX(x[i]);
      final sy = dataToScreenY(y[i]);
      canvas.drawCircle(Offset(sx, sy), 3, Paint()..color = color);
    }
  }
}

// Catmull-Rom spline (for other functions)
void _drawCatmullRomSpline(
  Canvas canvas,
  List<double> x,
  List<double> y,
  double Function(double) dataToScreenX,
  double Function(double) dataToScreenY,
  Color color,
  double strokeWidth,
  bool showDots,
) {
  if (x.length < 2) return;

  final plotPaint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke;

  final path = Path();

  // Move to first point
  path.moveTo(dataToScreenX(x[0]), dataToScreenY(y[0]));

  // Catmull-Rom spline for smooth curve
  for (int i = 0; i < x.length - 1; i++) {
    final p0x = i == 0 ? x[0] : x[i - 1];
    final p0y = i == 0 ? y[0] : y[i - 1];
    final p1x = x[i];
    final p1y = y[i];
    final p2x = x[i + 1];
    final p2y = y[i + 1];
    final p3x = (i + 2 < x.length) ? x[i + 2] : x[x.length - 1];
    final p3y = (i + 2 < y.length) ? y[i + 2] : y[y.length - 1];

    // Calculate control points for cubic Bezier
    final cp1x = dataToScreenX(p1x + (p2x - p0x) / 6);
    final cp1y = dataToScreenY(p1y + (p2y - p0y) / 6);
    final cp2x = dataToScreenX(p2x - (p3x - p1x) / 6);
    final cp2y = dataToScreenY(p2y - (p3y - p1y) / 6);

    final p2sx = dataToScreenX(p2x);
    final p2sy = dataToScreenY(p2y);

    path.cubicTo(cp1x, cp1y, cp2x, cp2y, p2sx, p2sy);
  }

  canvas.drawPath(path, plotPaint);

  // Draw dots if needed
  if (showDots) {
    for (int i = 0; i < x.length; i++) {
      final sx = dataToScreenX(x[i]);
      final sy = dataToScreenY(y[i]);
      canvas.drawCircle(Offset(sx, sy), 3, Paint()..color = color);
    }
  }
}

  void _drawArea(Canvas canvas, List<double> x, List<double> y,
      double Function(double) dataToScreenX,
      double Function(double) dataToScreenY,
      Color areaColor,
      double yAxisData) {
    if (x.length < 2) return;
    final path = Path();
    for (int i = 0; i < x.length; i++) {
      final sx = dataToScreenX(x[i]);
      final sy = dataToScreenY(y[i]);
      if (i == 0) {
        path.moveTo(sx, dataToScreenY(yAxisData));
        path.lineTo(sx, sy);
      } else {
        path.lineTo(sx, sy);
      }
    }
    // Close the area to the x-axis
    final lastSx = dataToScreenX(x.last);
    path.lineTo(lastSx, dataToScreenY(yAxisData));
    path.close();
    final areaPaint = Paint()
      ..color = areaColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, areaPaint);
  }

  // --- UPDATED GRID DRAWING ---
  void _drawGrid(
    Canvas canvas,
    Size size,
    double Function(double) dataToScreenX,
    double Function(double) dataToScreenY,
    double minX,
    double maxX,
    double minY,
    double maxY,
    Color gridColor,
    Color axisColor,
    double pad,
  ) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    final verticalGridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1; // Thinner vertical lines

    int xDiv = 8;
    int yDiv = 16;
    double xStep = (maxX - minX) / xDiv;
    double yStep = (maxY - minY) / yDiv;

    // Axis positions
    final yAxisScreen = dataToScreenX(0.0);

    // Vertical grid lines and labels (x)
    for (int i = 0; i <= xDiv; i++) {
      double x = minX + i * xStep;
      double px = dataToScreenX(x);
      canvas.drawLine(Offset(px, pad), Offset(px, size.height - pad), verticalGridPaint);
      // Place label just below the x-axis (y=0), centered horizontally
      final xAxisScreen = dataToScreenY(0.0);
      double labelY = (yMin <= 0 && yMax >= 0)
          ? xAxisScreen + 8 // 8px below the x-axis if y=0 is visible
          : size.height - pad + 8; // else below the bottom grid line
      _drawLabel(
        canvas,
        px,
        labelY,
        _formatNumber(x),
        align: Alignment.topCenter,
        color: axisColor,
      );
    }

    // Horizontal grid lines and labels (y)
    for (int i = 0; i <= yDiv; i++) {
      double y = minY + i * yStep;
      double py = dataToScreenY(y);
      canvas.drawLine(Offset(pad, py), Offset(size.width - pad, py), gridPaint);
      // Place label just left of the y-axis (x=0), centered vertically
      _drawLabel(
        canvas,
        yAxisScreen - 8, // 8px left of the y-axis line at x=0
        py,
        _formatNumber(y),
        align: Alignment.centerRight,
        color: axisColor,
      );
    }
    

   
  }

  // --- UPDATED LABEL DRAWING ---
  void _drawLabel(Canvas canvas, double x, double y, String text,
      {Alignment align = Alignment.center, Color color = Colors.black}) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
    );
    final tp = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    Offset offset = Offset(x, y);
    if (align == Alignment.topCenter) {
      offset = Offset(x - tp.width / 2, y);
    } else if (align == Alignment.centerRight) {
      offset = Offset(x - tp.width, y - tp.height / 2);
    }
    tp.paint(canvas, offset);
  }

  String _formatNumber(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(2);
    }
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.x1 != x1 ||
        oldDelegate.y1 != y1 ||
        oldDelegate.x2 != x2 ||
        oldDelegate.y2 != y2 ||
        oldDelegate.showFirst != showFirst ||
        oldDelegate.showSecond != showSecond ||
        oldDelegate.color1 != color1 ||
        oldDelegate.color2 != color2 ||
        oldDelegate.strokeWidth1 != strokeWidth1 ||
        oldDelegate.strokeWidth2 != strokeWidth2 ||
        oldDelegate.showDots1 != showDots1 ||
        oldDelegate.showDots2 != showDots2 ||
        oldDelegate.showArea1 != showArea1 ||
        oldDelegate.showArea2 != showArea2 ||
        oldDelegate.areaColor1 != areaColor1 ||
        oldDelegate.areaColor2 != areaColor2 ||
        oldDelegate.xMin != xMin ||
        oldDelegate.xMax != xMax ||
        oldDelegate.yMin != yMin ||
        oldDelegate.yMax != yMax ||
        oldDelegate.themeManager.themeData != themeManager.themeData ||
        oldDelegate.tooltipPosition != tooltipPosition ||
        oldDelegate.tooltipText != tooltipText;
  }
}