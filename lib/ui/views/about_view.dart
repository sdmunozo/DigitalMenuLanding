import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

const maxWidth = 1000;

double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > maxWidth ? baseSize + 10 : baseSize;
}

TextStyle subtitleStyle(BoxConstraints constraints) => TextStyle(
      fontFamily: 'Helvetica',
      fontSize: responsiveFontSize(24, constraints),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

TextStyle titleStyle(BoxConstraints constraints) => TextStyle(
      fontFamily: 'Helvetica',
      fontSize: responsiveFontSize(28, constraints),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > maxWidth;
              double topPadding = 10.0;
              if (constraints.maxWidth <= 462) {
                topPadding = 180.0;
              } else if (constraints.maxWidth <= 982) {
                topPadding = 140.0;
              } else if (constraints.maxWidth <= 1020) {
                topPadding = 100.0;
              }
              return Padding(
                padding: EdgeInsets.only(top: topPadding, bottom: 45.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    if (isWide) Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: AutoSizeText(
                        "¿Para quién es esto?",
                        style: titleStyle(constraints),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 10,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: _BuildContent(),
                    ),
                    if (isWide) Spacer(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BuildContent extends StatelessWidget {
  const _BuildContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > maxWidth;
        List<Widget> textContainers = [
          if (isWide) Spacer(),
          _buildTextContainer(
              '• Restaurantes con variaciones de menú frecuentes.',
              constraints),
          SizedBox(width: 10, height: 10),
          _buildTextContainer(
              '• Restaurantes que necesitan vender más.', constraints),
          SizedBox(width: 10, height: 10),
          _buildTextContainer('• Restaurantes con menús amplios.', constraints),
          if (isWide) Spacer(),
        ];

        return isWide
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: textContainers,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: textContainers,
              );
      },
    );
  }

  Widget _buildTextContainer(String text, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: constraints.maxWidth > maxWidth
            ? constraints.maxWidth / 3 - 20
            : null,
        alignment: Alignment.center,
        child: AutoSizeText(
          text,
          style: subtitleStyle(constraints),
          textAlign: TextAlign.center,
          minFontSize: 10,
          maxLines: 3,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
