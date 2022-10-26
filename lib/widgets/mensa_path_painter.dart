import 'package:flutter/material.dart';
import 'package:greatest_mensa_app_ever_xxl/resources/parse_svg.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:touchable/touchable.dart';
import 'package:xml/xml.dart';

class BodyPainter extends CustomPainter {
  final BuildContext context;
  final dynamic model;

  BodyPainter({
    required this.context,
    required this.model,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    // Scale each path to match canvas size
    var xScale = size.width / 222;
    var yScale = size.height / 400;
    final Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(xScale, yScale);

    Path? bodyPath;

    List<MensaSvgMember> generalParts =
        model.front ? model.generalFrontBodyParts : model.generalBackBodyParts;

    generalParts.forEach((muscle) {
      Path path = parseSvgPath(muscle.path);

      paint.color = Colors.white10;

      if (model.selectedGeneralBodyPart != null &&
          model.selectedGeneralBodyPart == muscle.name) {
        paint.color = Colors.white30;
      }

      myCanvas.drawPath(
        path.transform(matrix4.storage),
        paint,
        onTapDown: (details) {
          model.selectGeneralBodyPart(muscle.name);
        },
      );
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
