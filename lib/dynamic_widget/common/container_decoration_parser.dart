import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

class ContainerDecorationParser {
  static Map<String, dynamic>? export(BoxDecoration boxDecoration) {
    if (boxDecoration.borderRadius == BorderRadius.zero) {
      return null;
    }
    final BorderRadius borderRadius = boxDecoration.borderRadius as BorderRadius;
    final Color color = boxDecoration.color as Color;
    final Map<String, dynamic> map = {
      "borderRadius": "${exportBorderRadius(borderRadius)}",
      "color":color.value.toRadixString(16),
    };
    return map;
  }

  static BoxDecoration? parse(Map<String, dynamic>? map) {
    if (map == null) return null;
    return BoxDecoration(
      borderRadius: parseBorderRadius(
        map['borderRadius'],
      ),
      color: parseHexColor(map['color'])
    );
  }
}
