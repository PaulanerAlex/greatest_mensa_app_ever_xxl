import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

Future<MensaSvgModel> loadSvgImage(
    {required bool back,
    required String svgPathKey,
    required String user}) async {
  String generalString = await rootBundle.loadString(svgPathKey);

  XmlDocument document = XmlDocument.parse(generalString);
  String content = await rootBundle.loadString(svgPathKey);

  final paths = document.findAllElements('path');
  List<MensaSvgMember> mensaParts = [];

  Color? partColorObject;
  int width = 0;
  int height = 0;

  try {
    String imageWidth = paths.elementAt(0).toString();
    LineSplitter ls = LineSplitter();
    List<String> contentList = ls.convert(content);
    int widthPos = contentList[0].indexOf('width="');
    int heightPos = contentList[0].indexOf('" height="');
    int heightEndPos = contentList[0].indexOf('" view');
    width = int.parse(contentList[0].substring(widthPos + 7, heightPos));
    height = int.parse(contentList[0].substring(heightPos + 10, heightEndPos));

    print(width);
    print(height);
  } catch (e) {
    throw ('Something is wrong with the svg file');
  }

  for (XmlElement element in paths) {
    String partName = element.getAttribute('id').toString();
    String partPath = element.getAttribute('d').toString();
    String partColor = element.getAttribute('fill').toString();
    if (partName == 'null') {
      partName = 'background';
    }
    if (partColor == 'black') {
      partColorObject = Colors.black;
    } else if (partColor == 'white') {
      partColorObject = Colors.white;
    } else {
      partColor = partColor.replaceAll('#', '');
      partColorObject = Color(int.parse('0x${'ff' + partColor}'));
    }
    if (!partName.contains('path')) {
      MensaSvgMember part =
          MensaSvgMember(id: partName, path: partPath, color: partColorObject);
      if (back) {
        mensaParts.add(part);
      } else {
        mensaParts.add(part);
      }
    }
  }
  MensaSvgModel model = MensaSvgModel(
    mensaParts: mensaParts,
    selectedTable: mensaParts.first.id,
    sizew: width,
    sizeh: height,
    user: user,
  );
  return model;
}

class MensaSvgModel {
  List<MensaSvgMember> mensaParts;
  String? selectedTable;
  String? user;
  int sizew;
  int sizeh;

  MensaSvgModel({
    required this.mensaParts,
    required this.selectedTable,
    required this.sizew,
    required this.sizeh,
    required this.user,
  });
}

class MensaSvgMember {
  String id;
  String path;
  Color color;

  MensaSvgMember({
    required this.id,
    required this.path,
    required this.color,
  });
}
