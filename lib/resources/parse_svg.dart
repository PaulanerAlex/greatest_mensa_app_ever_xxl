import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

Future<MensaSvgModel> loadSvgImage(
    {required bool back, required String svgPathKey}) async {
  String generalString = await rootBundle.loadString(svgPathKey);

  XmlDocument document = XmlDocument.parse(generalString);

  final paths = document.findAllElements('path');
  List<MensaSvgMember> mensaParts = [];

  Color? partColorObject;

  paths.forEach(
    (element) {
      String partName = element.getAttribute('id').toString();
      String partPath = element.getAttribute('d').toString();
      String partColor = element.getAttribute('fill').toString();

      if (partColor == 'black') {
        Color partColorObject = Colors.black;
      } else if (partColor == 'white') {
        Color partColorObject = Colors.white;
      } else {
        partColor = partColor.replaceAll('#', '');
        Color partColorObject = Color(int.parse('0x${'FF' + partColor}'));
      }

      if (!partName.contains('path')) {
        MensaSvgMember part = MensaSvgMember(id: partName, path: partPath);
        if (back) {
          mensaParts.add(part);
        } else {
          mensaParts.add(part);
        }
      }
    },
  );
  MensaSvgModel model = MensaSvgModel(
    mensaParts: mensaParts,
    selectedTable: null,
    size: const Size.fromHeight(904),
    color: partColorObject!,
  );
  return model;
}

class MensaSvgModel {
  List<MensaSvgMember> mensaParts;
  String? selectedTable;
  Size size;
  Color color;

  MensaSvgModel({
    required this.mensaParts,
    required this.selectedTable,
    required this.size,
    required this.color,
  });
}

class MensaSvgMember {
  String id;
  String path;

  MensaSvgMember({
    required this.id,
    required this.path,
  });
}
