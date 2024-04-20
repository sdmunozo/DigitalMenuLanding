import 'package:flutter/material.dart';
import 'package:landing_v2/ui/shared/testimonial_card.dart';
import 'package:auto_size_text/auto_size_text.dart';

const maxWidth = 1000;

double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > maxWidth ? baseSize + 10 : baseSize;
}

TextStyle titleStyle(BoxConstraints constraints) => TextStyle(
      fontFamily: 'Helvetica',
      fontSize: responsiveFontSize(28, constraints),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

class PricingView extends StatelessWidget {
  final List<Map<String, dynamic>> testimonials = [
    {
      "text": "Muy sencillo y fácil de usar",
      "rating": 5,
      "name": "Rest El Ahumado",
      "authorDetails": "Gerente",
      "details": "assets/Testimonios/bg_Tes01.jpeg",
      "image": "assets/Testimonios/Tes01.png",
    },
    {
      "text": "Excelente!! Fácil y práctico",
      "rating": 5,
      "name": "Smoke House",
      "authorDetails": "Jefe de Meseros",
      "details": "assets/Testimonios/bg_Tes02.jpeg",
      "image": "assets/Testimonios/Tes02.png",
    },
    {
      "text": "Va excelente! Me gustaría que el color fuera personalizado",
      "rating": 5,
      "name": "Servicio De Catering",
      "authorDetails": "Gerente General",
      "details": "assets/Testimonios/bg_Tes03.jpeg",
      "image": "assets/Testimonios/Tes03.png",
    },
    {
      "text": "La verdad es que muy bien, ha tenido buena aceptación",
      "rating": 5,
      "name": "Rest Red Chicken",
      "authorDetails": "Dueño",
      "details": "assets/Testimonios/bg_Tes04.jpeg",
      "image": "assets/Testimonios/Tes04.png",
    },
  ];

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
              double topPadding = 140.0;
              if (constraints.maxWidth <= 442) {
                topPadding = 180.0;
              } else if (constraints.maxWidth <= 700) {
                topPadding = 140.0;
              }
              return Padding(
                padding: EdgeInsets.only(
                    top: topPadding, bottom: 45.0, left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: AutoSizeText(
                        "TESTIMONIOS",
                        style: titleStyle(constraints),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 10,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Expanded(
                        child: Container(
                          width: 500,
                          child: ListView.builder(
                            itemCount: testimonials.length,
                            itemBuilder: (context, index) {
                              var testimonial = testimonials[index];
                              return TestimonialCard(
                                testimonialText: testimonial['text'],
                                authorName: testimonial['name'],
                                authorDetails: testimonial['authorDetails'],
                                authorImage: AssetImage(testimonial['details']),
                                rating: testimonial['rating'],
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: Dialog(
                                        child: AspectRatio(
                                          aspectRatio: 9 / 16,
                                          child: Image.asset(
                                              testimonial['image'],
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
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



/*import 'package:flutter/material.dart';

import 'package:landing_v2/ui/shared/testimonial_card.dart';

class PricingView extends StatelessWidget {
  final List<String> testimonialImages = [
    'assets/Testimonios/Tes01.png',
    'assets/Testimonios/Tes02.png',
    'assets/Testimonios/Tes03.png',
    'assets/Testimonios/Tes04.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pricing')),
      body: ListView.builder(
        itemCount: testimonialImages.length,
        itemBuilder: (context, index) {
          return TestimonialCard(
            testimonialText:
                'Este producto ha cambiado mi vida. Lo recomiendo ampliamente.',
            authorName: 'Juan Pérez',
            authorDetails: 'CEO de Empresa X',
            authorImage: AssetImage('assets/images/author.jpg'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Dialog(
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Image.asset(testimonialImages[index],
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


*/

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const maxWidth = 1000;

double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > maxWidth ? baseSize + 10 : baseSize;
}

TextStyle titleStyle(BoxConstraints constraints) => TextStyle(
      fontFamily: 'Helvetica',
      fontSize: responsiveFontSize(24, constraints),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

class PricingView extends StatefulWidget {
  @override
  _PricingViewState createState() => _PricingViewState();
}

class _PricingViewState extends State<PricingView> {
  PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage == 4) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double topPadding = 130.0;
              if (constraints.maxWidth <= 442) {
                topPadding = 170.0;
              } else if (constraints.maxWidth <= maxWidth) {
                topPadding = 130.0;
              }
              return Padding(
                padding: EdgeInsets.only(top: topPadding, bottom: 45.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "TESTIMONIOS",
                        style: titleStyle(constraints),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      // Usar Expanded para que tome todo el espacio disponible
                      child: PageView(
                        controller: _pageController,
                        children: [
                          Image.asset('assets/Testimonios/Tes01.png',
                              fit: BoxFit.contain),
                          Image.asset('assets/Testimonios/Tes02.png',
                              fit: BoxFit.contain),
                          Image.asset('assets/Testimonios/Tes03.png',
                              fit: BoxFit.contain),
                          Image.asset('assets/Testimonios/Tes04.png',
                              fit: BoxFit.contain),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
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

*/


/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const maxWidth = 1000;

double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > maxWidth ? baseSize + 10 : baseSize;
}

TextStyle titleStyle(BoxConstraints constraints) => TextStyle(
      fontFamily: 'Helvetica',
      fontSize: responsiveFontSize(24, constraints),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

class PricingView extends StatefulWidget {
  @override
  _PricingViewState createState() => _PricingViewState();
}

class _PricingViewState extends State<PricingView> {
  PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage == 4) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double topPadding = 10.0;
              if (constraints.maxWidth <= 442) {
                topPadding = 170.0;
              } else if (constraints.maxWidth <= 700) {
                topPadding = 130.0;
              }
              return Padding(
                padding: EdgeInsets.only(top: topPadding, bottom: 45.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "TESTIMONIOS",
                          style: titleStyle(constraints),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 400,
                        child: PageView(
                          controller: _pageController,
                          children: [
                            Image.asset('assets/Testimonios/Tes01.png',
                                fit: BoxFit.cover),
                            Image.asset('assets/Testimonios/Tes02.png',
                                fit: BoxFit.cover),
                            Image.asset('assets/Testimonios/Tes03.png',
                                fit: BoxFit.cover),
                            Image.asset('assets/Testimonios/Tes04.png',
                                fit: BoxFit.cover),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

*/


/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:landing_v2/ui/shared/testimonial_card.dart';

const maxWidth = 1000;

double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > maxWidth ? baseSize + 10 : baseSize;
}

TextStyle subtitleStyle(BoxConstraints constraints) => TextStyle(
      fontFamily: 'Helvetica',
      fontSize: responsiveFontSize(20, constraints),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

TextStyle titleStyle(BoxConstraints constraints) => TextStyle(
      fontFamily: 'Helvetica',
      fontSize: responsiveFontSize(24, constraints),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

class PricingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(246, 246, 246, 1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double topPadding = 10.0;
              if (constraints.maxWidth <= 442) {
                topPadding = 170.0;
              } else if (constraints.maxWidth <= 700) {
                topPadding = 130.0;
              }
              return Padding(
                padding: EdgeInsets.only(top: topPadding, bottom: 45.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "TESTIMONIOS",
                          style: titleStyle(constraints),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          Container(
                            width: 293.3,
                            child: TestimonialCard(
                              testimonialText:
                                  'Este producto ha cambiado mi vida. Lo recomiendo ampliamente.',
                              authorName: 'Juan Pérez',
                              authorDetails: 'CEO de Empresa X',
                              authorImage:
                                  AssetImage('assets/images/author.jpg'),
                            ),
                          ),
                          Container(
                            width: 293.3,
                            child: TestimonialCard(
                              testimonialText:
                                  'Este producto ha cambiado mi vida. Lo recomiendo ampliamente.',
                              authorName: 'Juan Pérez',
                              authorDetails: 'CEO de Empresa X',
                              authorImage:
                                  AssetImage('assets/images/author.jpg'),
                            ),
                          ),
                          Container(
                            width: 293.3,
                            child: TestimonialCard(
                              testimonialText:
                                  'Este producto ha cambiado mi vida. Lo recomiendo ampliamente.',
                              authorName: 'Juan Pérez',
                              authorDetails: 'CEO de Empresa X',
                              authorImage:
                                  AssetImage('assets/images/author.jpg'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

*/

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PricingView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            'Pricing',
            style: GoogleFonts.montserratAlternates(
              fontSize: 80,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}


*/