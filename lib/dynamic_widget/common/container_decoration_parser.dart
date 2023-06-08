import 'dart:convert';

import 'package:dynamic_widget/dynamic_widget/common/rounded_rectangle_border_parser.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

class ContainerDecorationParser {
  static Map<String, dynamic>? export(BoxDecoration boxDecoration) {
    if (boxDecoration.borderRadius == BorderRadius.zero &&
        boxDecoration.color == null &&
        boxDecoration.border == null &&
        boxDecoration.gradient == null &&
        boxDecoration.backgroundBlendMode == null &&
        boxDecoration.shape == BoxShape.rectangle &&
        boxDecoration.image == null &&
        boxDecoration.boxShadow == null) {
      return null;
    }
    BorderRadius borderRadius = (boxDecoration.borderRadius != null) ? boxDecoration.borderRadius as BorderRadius : BorderRadius.zero;
    final Color color = boxDecoration.color as Color;
    final Map<String, dynamic> map = {
      "borderRadius": "${exportBorderRadius(borderRadius)}",
      "color":color.value.toRadixString(16),
      "gradient" : exportLinearGradient(boxDecoration.gradient as LinearGradient) ,
      "shape": exportShapeInDecoration(boxDecoration.shape),
      "border": exportBoxBorder(boxDecoration.border) ,
    };
    return map;
  }

  static BoxDecoration? parse(Map<String, dynamic>? map) {
    if (map == null) return null;
    return BoxDecoration(
      borderRadius: map['shape'] != "circle" ? parseBorderRadius(
        map['borderRadius'],
      ): null,
      color: parseHexColor(map['color']) ,
      gradient: parseLinearGradient(map['gradient']) ?? null ,
      shape: parseShapeInDecoration(map['shape']),
      border: parseBoxBorder(map['border'])
    );
  }
}
