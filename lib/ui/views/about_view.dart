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



/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';

final maxWidth = 700;

double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > maxWidth ? baseSize + 10 : baseSize;
}

TextStyle titleStyle(BoxConstraints constraints) =>
    GoogleFonts.montserratAlternates(
        fontSize: responsiveFontSize(24, constraints),
        fontWeight: FontWeight.bold,
        color: Colors.black);

TextStyle subtitleStyle(BoxConstraints constraints) =>
    GoogleFonts.montserratAlternates(
        fontSize: responsiveFontSize(24, constraints),
        fontWeight: FontWeight.bold,
        color: Colors.black);

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
              return Column(
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 45.0),
                      child: _BuildContent(),
                    ),
                  ),
                  if (isWide) Spacer(),
                ],
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

*/
/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';

// Ajusta el tamaño de la fuente según el ancho de la pantalla
double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > 700 ? baseSize + 10 : baseSize;
}

// Estilos con tamaño de fuente responsivo
TextStyle titleStyle(BoxConstraints constraints) =>
    GoogleFonts.montserratAlternates(
        fontSize: responsiveFontSize(34, constraints),
        fontWeight: FontWeight.bold,
        color: Colors.black);

TextStyle subtitleStyle(BoxConstraints constraints) =>
    GoogleFonts.montserratAlternates(
        fontSize: responsiveFontSize(24, constraints),
        fontWeight: FontWeight.bold,
        color: Colors.black);

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PromotionalWidget(),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) => AutoSizeText(
                    "¿Para quién es esto?",
                    style: titleStyle(constraints),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 10,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 45.0),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 700;
        List<Widget> textContainers = [
          Spacer(),
          _buildTextContainer(
              '• Restaurantes con variaciones de menú frecuentes.',
              constraints),
          SizedBox(width: 10, height: 10),
          _buildTextContainer(
              '• Restaurantes que necesitan vender más.', constraints),
          SizedBox(width: 10, height: 10),
          _buildTextContainer('• Restaurantes con menús amplios.', constraints),
          Spacer(),
        ];

        if (isWide) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textContainers,
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: textContainers,
          );
        }
      },
    );
  }

  Widget _buildTextContainer(String text, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width:
            constraints.maxWidth > 700 ? constraints.maxWidth / 3 - 20 : null,
        alignment: Alignment.center,
        child: Text(
          text,
          style: subtitleStyle(constraints),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ),
    );
  }
}
*/


/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';

double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > 700 ? baseSize - 10 : baseSize;
}

final titleStyle = (BoxConstraints constraints) =>
    GoogleFonts.montserratAlternates(
        fontSize: responsiveFontSize(44, constraints),
        fontWeight: FontWeight.bold,
        color: Colors.black);

final subtitleStyle = (BoxConstraints constraints) =>
    GoogleFonts.montserratAlternates(
        fontSize: responsiveFontSize(34, constraints),
        fontWeight: FontWeight.bold,
        color: Colors.black);

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PromotionalWidget(),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) => AutoSizeText(
                    "¿Para quién es esto?",
                    style: titleStyle(constraints),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 10,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 45.0),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 700;

        List<Widget> textContainers = [
          Spacer(),
          _buildTextContainer(
              '• Restaurantes con variaciones de menú frecuentes.',
              constraints),
          SizedBox(width: 10, height: 10),
          _buildTextContainer(
              '• Restaurantes que necesitan vender más.', constraints),
          SizedBox(width: 10, height: 10),
          _buildTextContainer('• Restaurantes con menús amplios.', constraints),
          Spacer(),
        ];

        if (isWide) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textContainers,
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: textContainers,
          );
        }
      },
    );
  }

  Widget _buildTextContainer(String text, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width:
            constraints.maxWidth > 700 ? constraints.maxWidth / 3 - 20 : null,
        alignment: Alignment.center,
        child: Text(
          text,
          style: subtitleStyle(constraints),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ),
    );
  }
}

*/

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';

final subtitleStyle = GoogleFonts.montserratAlternates(
    fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black);

final titleStyle = GoogleFonts.montserratAlternates(
    fontSize: 44, fontWeight: FontWeight.bold, color: Colors.black);

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PromotionalWidget(),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AutoSizeText(
                  "¿Para quién es esto?",
                  style: titleStyle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 45.0),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 700;

        List<Widget> textContainers = [
          Spacer(),
          _buildTextContainer(
              '• Restaurantes con variaciones de menú frecuentes.',
              constraints),
          SizedBox(width: 10, height: 10),
          _buildTextContainer(
              '• Restaurantes que necesitan vender más.', constraints),
          SizedBox(width: 10, height: 10),
          _buildTextContainer('• Restaurantes con menús amplios.', constraints),
          Spacer(),
        ];

        if (isWide) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textContainers,
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: textContainers,
          );
        }
      },
    );
  }

  Widget _buildTextContainer(String text, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width:
            constraints.maxWidth > 700 ? constraints.maxWidth / 3 - 20 : null,
        alignment: Alignment.center,
        child: Text(
          text,
          style: subtitleStyle,
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ),
    );
  }
}

*/

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';

final subtitleStyle = GoogleFonts.montserratAlternates(
    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);

final titleStyle = GoogleFonts.montserratAlternates(
    fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black);

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PromotionalWidget(),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AutoSizeText(
                  "¿Para quién es esto?",
                  style: titleStyle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 45.0),
                  child: Container(
                    color: Colors.amber,
                    child: _buildContent(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 700;

        List<Widget> textContainers = [
          _buildTextContainer(
              '• Restaurantes con variaciones de menú frecuentes.'),
          SizedBox(width: 10, height: 10),
          _buildTextContainer('• Restaurantes que necesitan vender más.'),
          SizedBox(width: 10, height: 10),
          _buildTextContainer('• Restaurantes con menús amplios.'),
        ];

        if (isWide) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textContainers,
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: textContainers,
          );
        }
      },
    );
  }

  Widget _buildTextContainer(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        color: Colors.amberAccent,
        alignment: Alignment.center,
        child: Text(
          text,
          style: subtitleStyle,
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ),
    );
  }
}

*/

/* 
AutoSizeText(
          text,
          style: subtitleStyle,
          textAlign: TextAlign.center,
          maxLines: 3,
          minFontSize: 5,
        ),
*/



/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';

final subtitle =
    GoogleFonts.montserratAlternates(fontSize: 34, fontWeight: FontWeight.bold);
final title =
    GoogleFonts.montserratAlternates(fontSize: 44, fontWeight: FontWeight.bold);

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PromotionalWidget(),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "¿Para quién es esto?",
                  style: title,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  color: Colors.amber,
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = (constraints.maxWidth / 3) - 40;
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: containerWidth,
                child: Text(
                  '• Restaurantes con variaciones de menú frecuentes.',
                  style: subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: containerWidth,
                child: Text(
                  '• Restaurantes que necesitan vender más.',
                  style: subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: containerWidth,
                child: Text(
                  '• Restaurantes con menús amplios.',
                  style: subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
*/


/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';

final subtitle =
    GoogleFonts.montserratAlternates(fontSize: 34, fontWeight: FontWeight.bold);
final title =
    GoogleFonts.montserratAlternates(fontSize: 44, fontWeight: FontWeight.bold);

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PromotionalWidget(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "¿Para quién es esto?",
                  style: title,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  color: Colors.amber,
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            width: 293.3,
            child: Text(
              '• Restaurantes con variaciones de menú frecuentes.',
              style: subtitle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            width: 293.3,
            child: Text(
              '• Restaurantes que necesitan vender más.',
              style: subtitle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            width: 293.3,
            child: Text(
              '• Restaurantes con menús amplios.',
              style: subtitle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
*/