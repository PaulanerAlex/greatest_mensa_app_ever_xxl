import 'package:flutter/material.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/parse_svg.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:touchable/touchable.dart';
import 'package:xml/xml.dart';

class MensaPainter extends CustomPainter {
  final BuildContext context;
  final dynamic model;

  MensaPainter({
    required this.context,
    required this.model,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    // Scale each path to match canvas size FIXME: Potenital Bug here
    // print(size.height);
    // print(size.width);

    // var xScale = size.width / 222;
    var xScale = 200 / 222;
    // var xScale = 1280.0;
    // var yScale = size.height / 400;
    var yScale = 300 / 400;
    // var yScale = 904.0;

    final Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(xScale, yScale);

    List<MensaSvgMember> generalParts = model.mensaParts;
    print('test123');

    generalParts.forEach((part) {
      print('test1234');

      Path path = parseSvgPath(part.path);

      paint.color = model.color;

      myCanvas.drawPath(
        path.transform(matrix4.storage),
        paint,
        onTapDown: (details) {
          print('Touch down');
          model.selectedTable(part.id);
        },
      );
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
