import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlRenderWidget extends StatelessWidget {
  final String htmlCode;
  final TextStyle style;
  final TextOverflow? textOverflow;
  final double? height;
  final double? width;
  const HtmlRenderWidget({
    super.key,
    required this.htmlCode,
    required this.style,
    this.textOverflow,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: HtmlWidget(
        htmlCode,
        textStyle: style,
      ),
    );
  }
}
