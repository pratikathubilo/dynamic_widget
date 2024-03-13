import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/common/container_decoration_parser.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class ContainerWidgetParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    Alignment? alignment = parseAlignment(map['alignment']);
    Color? color = parseHexColor(map['color']);
    BoxConstraints constraints = parseBoxConstraints(map['constraints']);
    //TODO: decoration, foregroundDecoration and transform properties to be implemented.
    EdgeInsetsGeometry? margin = parseEdgeInsetsGeometry(map['margin']);
    EdgeInsetsGeometry? padding = parseEdgeInsetsGeometry(map['padding']);
    Map<String, dynamic>? childMap = map['child'];
    Widget? child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);
    final BoxDecoration? decoration =
        ContainerDecorationParser.parse(map['decoration']);
    final BoxDecoration? foregroundDecoration =
        ContainerDecorationParser.parse(map['foregroundDecoration']);
    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : null;

    var containerWidget = Container(
      alignment: alignment,
      padding: padding,
      color: color,
      margin: margin,
      width: map['width']?.toDouble(),
      height: map['height']?.toDouble(),
      constraints: constraints,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      child: child,
      clipBehavior: parseClipBehavior(map['clipBehavior']),
    );

    if (listener != null && clickEvent != null) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }

  @override
  String get widgetName => "Container";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Container;
    var padding = realWidget.padding as EdgeInsets?;
    var margin = realWidget.margin as EdgeInsets?;
    var constraints = realWidget.constraints;
    var decoration = realWidget.decoration;
    var foregroundDecoration = realWidget.foregroundDecoration;
    return <String, dynamic>{
      "type": widgetName,
      "alignment": realWidget.alignment != null
          ? exportAlignment(realWidget.alignment as Alignment?)
          : null,
      "padding": padding != null
          ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
          : null,
      "color": realWidget.color != null && realWidget.decoration == null
          ? realWidget.color!.value.toRadixString(16)
          : null,
      "margin": margin != null
          ? "${margin.left},${margin.top},${margin.right},${margin.bottom}"
          : null,
      "constraints":
          constraints != null ? exportConstraints(constraints) : null,
      "decoration": decoration != null
          ? ContainerDecorationParser.export(
              realWidget.decoration as BoxDecoration)
          : null,
      "foregroundDecoration": foregroundDecoration != null
          ? ContainerDecorationParser.export(
              foregroundDecoration as BoxDecoration)
          : null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext),
      "clipBehavior": exportClip(realWidget.clipBehavior),
    };
  }

  @override
  Type get widgetType => Container;
}
