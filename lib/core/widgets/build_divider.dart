import 'package:flutter/material.dart';

import '../Responsive/UiComponents/InfoWidget.dart';


class BuildDivider extends StatelessWidget {
  final String text;

  const BuildDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo) {
        final double totalWidth = deviceInfo.localWidth;
        final double textWidth = totalWidth * 0.25; // 25% for text
        final double lineWidth = (totalWidth - textWidth) / 2;
        return Center(
          child: SizedBox(
            width: totalWidth,
            height: 18,
            child: Stack(
              children: [
                Positioned(
                  left: lineWidth,
                  top: 0,
                  child: SizedBox(
                    width: textWidth,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF9E9E9E),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 8,
                  child: Container(
                    width: lineWidth - 4, // small gap before text
                    height: 1,
                    decoration: BoxDecoration(color: const Color(0xFFE0E0E0)),
                  ),
                ),
                Positioned(
                  left: lineWidth + textWidth + 4, // small gap after text
                  top: 8,
                  child: Container(
                    width: lineWidth - 4,
                    height: 1,
                    decoration: BoxDecoration(color: const Color(0xFFE0E0E0)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
