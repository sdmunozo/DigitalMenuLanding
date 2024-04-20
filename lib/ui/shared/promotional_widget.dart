import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PromotionalWidget extends StatefulWidget {
  final GlobalKey widgetKey = GlobalKey();

  PromotionalWidget({Key? key}) : super(key: key);

  @override
  _PromotionalWidgetState createState() => _PromotionalWidgetState();
}

class _PromotionalWidgetState extends State<PromotionalWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _scaleAnimation;
  Timer? _timer;
  Duration _duration = Duration(hours: 25);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(
      begin: Color.fromRGBO(164, 53, 240, 1),
      end: Color.fromRGBO(87, 35, 208, 1),
    ).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(_controller);

    _loadTimerState();
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final startTime = prefs.getInt('startTime');
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (startTime != null) {
      final passedTime = Duration(milliseconds: currentTime - startTime);
      final remainingTime = Duration(hours: 25) - passedTime;
      if (remainingTime.inSeconds > 0) {
        setState(() {
          _duration = remainingTime;
        });
      } else {
        await prefs.setInt('startTime', currentTime);
        setState(() {
          _duration = Duration(hours: 25);
        });
      }
    } else {
      await prefs.setInt('startTime', currentTime);
    }

    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      final prefs = await SharedPreferences.getInstance();
      if (_duration.inSeconds == 0) {
        timer.cancel();
        final currentTime = DateTime.now().millisecondsSinceEpoch;
        await prefs.setInt('startTime', currentTime);
        setState(() {
          _duration = Duration(hours: 25);
        });
        startTimer();
      } else {
        setState(() {
          _duration = _duration - Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _duration.inHours.toString().padLeft(2, '0');
    final minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                color: _colorAnimation.value,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20),
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _BuildPromotionText(
                              hours: hours, minutes: minutes, seconds: seconds),
                          _BuildCallToAction()
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _BuildCallToAction extends StatelessWidget {
  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      print('No se pudo lanzar $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          _launchUrl(Uri.parse('https://buy.stripe.com/4gwfZ0eztgk24JWcMM'));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text('Solicitar ahora'),
      ),
    );
  }
}

class _BuildPromotionText extends StatelessWidget {
  final String hours;
  final String minutes;
  final String seconds;

  const _BuildPromotionText({
    Key? key,
    required this.hours,
    required this.minutes,
    required this.seconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Oferta para nuevos restaurantes ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "| Menús Digitales desde solo 399 MX\$. Haz clic en el botón para pagar ahora. ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Finaliza en $hours:$minutes:$seconds.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}


/*import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PromotionalWidget extends StatefulWidget {
  final GlobalKey widgetKey = GlobalKey();
  PromotionalWidget({Key? key}) : super(key: key);

  @override
  _PromotionalWidgetState createState() => _PromotionalWidgetState();
}

class _PromotionalWidgetState extends State<PromotionalWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _scaleAnimation;
  Timer? _timer;
  Duration _duration = Duration(hours: 25);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat(reverse: true);
    _colorAnimation = ColorTween(
            begin: Color.fromRGBO(164, 53, 240, 1),
            end: Color.fromRGBO(87, 35, 208, 1))
        .animate(_controller);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(_controller);

    _loadTimerState();
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final startTime = prefs.getInt('startTime');
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (startTime != null) {
      final passedTime = Duration(milliseconds: currentTime - startTime);
      final remainingTime = Duration(hours: 25) - passedTime;
      if (remainingTime.inSeconds > 0) {
        setState(() {
          _duration = remainingTime;
        });
      } else {
        await prefs.setInt('startTime', currentTime);
        setState(() {
          _duration = Duration(hours: 25);
        });
      }
    } else {
      await prefs.setInt('startTime', currentTime);
    }

    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      final prefs = await SharedPreferences.getInstance();
      if (_duration.inSeconds == 0) {
        timer.cancel();
        // Reinicia el contador y el almacenamiento cuando llega a 0.
        final currentTime = DateTime.now().millisecondsSinceEpoch;
        await prefs.setInt('startTime', currentTime);
        setState(() {
          _duration = Duration(hours: 25);
        });
        startTimer();
      } else {
        setState(() {
          _duration = _duration - Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _duration.inHours.toString().padLeft(2, '0');
    final minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                color: _colorAnimation.value,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20),
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _BuildPromotionText(
                              hours: hours, minutes: minutes, seconds: seconds),
                          _BuildCallToAction()
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _BuildCallToAction extends StatelessWidget {
  const _BuildCallToAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text('Solicitar ahora'),
      ),
    );
  }
}

class _BuildPromotionText extends StatelessWidget {
  const _BuildPromotionText({
    super.key,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final String hours;
  final String minutes;
  final String seconds;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Oferta para nuevos restaurantes ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "| Menús Digitales desde solo 399 MX\$. Haz clic en el botón para pagar ahora. ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Finaliza en $hours:$minutes:$seconds.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

*/