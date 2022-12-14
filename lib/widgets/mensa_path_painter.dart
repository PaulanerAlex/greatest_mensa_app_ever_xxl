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
    int count = 0;
    for (MensaSvgMember part in generalParts) {
      Path path = parseSvgPath(part.path);
      if (part.id != 'background') {
        print(model.selectedTable.toString());
        paint.color = part.color;
        if (model.selectedTable != '' && part.id == model.selectedTable) {
          print('WAAAAS');
          paint.color = Colors.green;
        }
        print(paint.color);
        myCanvas.drawPath(
          path.transform(matrix4.storage),
          paint,
          onTapDown: (details) {
            print('Touch');
            print(part.id);
            model.selectedTable = part.id;
            paint.color = Colors.red;
          },
        );
      }
      count++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
