import 'dart:convert';

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
        boxDecoration.borderRadius == null &&
        boxDecoration.boxShadow == null) {
      return null;
    }
    final BorderRadius borderRadius = boxDecoration.borderRadius as BorderRadius;
    final Color color = boxDecoration.color as Color;
    final Map<String, dynamic> map = {
      "borderRadius": "${exportBorderRadius(borderRadius)}",
      "color":color.value.toRadixString(16),
      "gradient" : exportLinearGradient(boxDecoration.gradient as LinearGradient)
    };
    return map;
  }

  static BoxDecoration? parse(Map<String, dynamic>? map) {
    if (map == null) return null;
    return BoxDecoration(
      borderRadius: parseBorderRadius(
        map['borderRadius'],
      ),
      color: parseHexColor(map['color']) ,
      gradient: parseLinearGradient(map['gradient']) ?? null
    );
  }
}
