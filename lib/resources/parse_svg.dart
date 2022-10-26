import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

Future<void> loadSvgImage(
    {required bool back, required String svgPathKey}) async {
  String generalString = await rootBundle.loadString(svgPathKey);

  XmlDocument document = XmlDocument.parse(generalString);

  final paths = document.findAllElements('path');

  paths.forEach((element) {
    String partName = element.getAttribute('id').toString();
    String partPath = element.getAttribute('d').toString();

    if (!partName.contains('path')) {
      MensaSvgMember part = MensaSvgMember(name: partName, path: partPath);

      if (back) {
        // generalBackBodyParts.add(part);
      } else {
        // generalFrontBodyParts.add(part);
      }
    }
  });
}

class MensaSvgMember {
  String name;

  String path;

  MensaSvgMember({
    required this.name,
    required this.path,
  });
}
