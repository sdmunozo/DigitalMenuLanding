import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

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

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  VideoPlayerController? _controller;
  bool isMuted = false;
  SharedPreferences? prefs;
  bool hasError = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(246, 246, 246, 1),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double topPadding = 10.0;
              if (constraints.maxWidth <= 442) {
                topPadding = 170.0;
              } else if (constraints.maxWidth <= 1000) {
                topPadding = 130.0;
              }
              return Padding(
                padding: EdgeInsets.only(
                    top: topPadding, bottom: 70, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Innova, ahorra y vende más!",
                        style: titleStyle(constraints),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Tu menú digital espera para cambiar el juego",
                        style: titleStyle(constraints),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      constraints.maxWidth > maxWidth
                          ? Row(children: _buildVideoAndText(constraints))
                          : Column(children: _buildVideoAndText(constraints)),
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

  List<Widget> _buildVideoAndText(BoxConstraints constraints) {
    if (isLoading) {
      return [
        Container(
            width: constraints.maxWidth > maxWidth
                ? constraints.maxWidth * 0.6
                : null,
            color: Colors.amber,
            child: Image.asset('assets/tools/Menu.png', fit: BoxFit.cover)),
        PointsWidget(constraints: constraints), //[CircularProgressIndicator()];
      ];
    }
    return [
      Container(
        width:
            constraints.maxWidth > maxWidth ? constraints.maxWidth * 0.6 : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_controller != null && _controller!.value.isInitialized) ...[
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
              VideoProgressIndicator(_controller!, allowScrubbing: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(_controller!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                    onPressed: toggleMute,
                  ),
                ],
              )
            ] else
              Image.asset('assets/tools/Menu.png'),
          ],
        ),
      ),
      PointsWidget(constraints: constraints),
    ];
  }

  @override
  void dispose() {
    _controller?.removeListener(videoListener);
    saveVideoPosition();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> saveVideoPosition() async {
    if (prefs != null && mounted && _controller != null) {
      await prefs!.setDouble(
          'lastPosition', _controller!.value.position.inSeconds.toDouble());
    }
  }

  Future<void> initializeVideoPlayer() async {
    prefs = await SharedPreferences.getInstance();
    double lastPosition = prefs?.getDouble('lastPosition') ?? 0;

    _controller = VideoPlayerController.network(
        'https://api4urest.blob.core.windows.net/landing/MenuDigital.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            isLoading = false;
            _controller!.seekTo(Duration(seconds: lastPosition.toInt()));
            _controller!.addListener(videoListener);
            toggleMute();
            _controller!.play();
          });
        }
      }).catchError((error) {
        print('Error initializing video player: $error');
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
  }

  void videoListener() {
    if (_controller != null &&
        _controller!.value.position >= _controller!.value.duration) {
      _controller!.seekTo(Duration.zero);
      _controller!.play();
    }
    saveVideoPosition();
  }

  void toggleMute() {
    setState(() {
      if (isMuted) {
        _controller?.setVolume(1.0);
        isMuted = false;
      } else {
        _controller?.setVolume(0.0);
        isMuted = true;
      }
    });
  }
}

class PointsWidget extends StatelessWidget {
  final BoxConstraints constraints;

  PointsWidget({required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          constraints.maxWidth > maxWidth ? constraints.maxWidth * 0.3 : null,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('• Vende más mostrando mejor tus platillos',
                style: subtitleStyle(constraints)),
            SizedBox(height: 10),
            Text('• Ahorra dinero en impresiones',
                style: subtitleStyle(constraints)),
            SizedBox(height: 10),
            Text('• Libera carga de trabajo a tus meseros',
                style: subtitleStyle(constraints)),
            SizedBox(height: 10),
            Text('• Marketing y promoción', style: subtitleStyle(constraints)),
          ],
        ),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

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

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late VideoPlayerController _controller;
  bool isMuted = false;
  SharedPreferences? prefs;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(246, 246, 246, 1),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double topPadding = 10.0;
              if (constraints.maxWidth <= 442) {
                topPadding = 170.0;
              } else if (constraints.maxWidth <= 1000) {
                topPadding = 130.0;
              }
              return Padding(
                padding: EdgeInsets.only(
                    top: topPadding, bottom: 70, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Innova, ahorra y vende más!",
                        style: titleStyle(constraints),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Tu menú digital espera para cambiar el juego",
                        style: titleStyle(constraints),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      constraints.maxWidth > maxWidth
                          ? Row(children: _buildVideoAndText(constraints))
                          : Column(children: _buildVideoAndText(constraints)),
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

  List<Widget> _buildVideoAndText(BoxConstraints constraints) {
    return [
      Container(
        width:
            constraints.maxWidth > maxWidth ? constraints.maxWidth * 0.6 : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_controller != null && _controller!.value.isInitialized) ...[
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
              VideoProgressIndicator(_controller!, allowScrubbing: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(_controller!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                    onPressed: toggleMute,
                  ),
                ],
              )
            ] else
              Image.asset(
                  'assets/tools/Menu.png'), // Mostrar la imagen mientras el video no esté listo
          ],
        ),
      ),
      Container(
        width:
            constraints.maxWidth > maxWidth ? constraints.maxWidth * 0.3 : null,
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('• Vende más mostrando mejor tus platillos',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Ahorra dinero en impresiones',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Libera carga de trabajo a tus meseros',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Marketing y promoción',
                  style: subtitleStyle(constraints)),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.removeListener(videoListener);
    saveVideoPosition();
    _controller.dispose();
    super.dispose();
  }

  Future<void> saveVideoPosition() async {
    if (prefs != null && mounted) {
      await prefs!.setDouble(
          'lastPosition', _controller.value.position.inSeconds.toDouble());
    }
  }

  Future<void> initializeVideoPlayer() async {
    prefs = await SharedPreferences.getInstance();
    double lastPosition = prefs?.getDouble('lastPosition') ?? 0;

    _controller = VideoPlayerController.network(
        'https://api4urest.blob.core.windows.net/landing/MenuDigital.mp4?sv=2023-01-03&spr=https%2Chttp&st=2024-04-16T23%3A37%3A52Z&se=2024-04-17T23%3A37%3A52Z&sr=b&sp=r&sig=gVl7T58EulZoqibnURRPFw87dN%2Bs9p1vPzmdx7TmAu4%3D')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _controller.seekTo(Duration(seconds: lastPosition.toInt()));
            _controller.addListener(videoListener);
            toggleMute();
            _controller.play();
          });
        }
      }).catchError((error) {
        print('Error initializing video player: $error');
        if (mounted) {
          setState(() {
            hasError = true;
          });
        }
      });
  }

  void videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _controller.seekTo(Duration.zero);
      _controller.play();
    }
    saveVideoPosition();
  }

  void toggleMute() {
    setState(() {
      if (isMuted) {
        _controller.setVolume(1.0);
        isMuted = false;
      } else {
        _controller.setVolume(0.0);
        isMuted = true;
      }
    });
  }
}

*/
/*
  List<Widget> _buildVideoAndText(BoxConstraints constraints) {
    return [
      Container(
        width:
            constraints.maxWidth > maxWidth ? constraints.maxWidth * 0.6 : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_controller.value.isInitialized) ...[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              VideoProgressIndicator(_controller, allowScrubbing: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(_controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                    onPressed: toggleMute,
                  ),
                ],
              )
            ] else
              CircularProgressIndicator(),
          ],
        ),
      ),
      Container(
        width:
            constraints.maxWidth > maxWidth ? constraints.maxWidth * 0.3 : null,
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('• Vende más mostrando mejor tus platillos',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Ahorra dinero en impresiones',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Libera carga de trabajo a tus meseros',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Marketing y promoción',
                  style: subtitleStyle(constraints)),
            ],
          ),
        ),
      ),
    ];
  }
*/


/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

final maxWidth = 700;

double responsiveFontSize(double baseSize, BoxConstraints constraints) {
  return constraints.maxWidth > maxWidth ? baseSize + 10 : baseSize;
}

TextStyle subtitleStyle(BoxConstraints constraints) =>
    GoogleFonts.montserratAlternates(
        fontSize: responsiveFontSize(20, constraints),
        fontWeight: FontWeight.bold);

TextStyle titleStyle(BoxConstraints constraints) =>
    GoogleFonts.montserratAlternates(
        fontSize: responsiveFontSize(24, constraints),
        fontWeight: FontWeight.bold);

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late VideoPlayerController _controller;
  bool isMuted = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(246, 246, 246, 1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWide = constraints.maxWidth > maxWidth;
                return Column(
                  children: [
                    PromotionalWidget(),
                    SizedBox(height: 20),
                    Text(
                      "Inova, ahorra y vende más!",
                      style: titleStyle(constraints),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Tu menú digital espera para cambiar el juego",
                      style: titleStyle(constraints),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: isWide
                          ? Row(
                              children: _buildVideoAndText(constraints),
                            )
                          : Column(
                              children: _buildVideoAndText(constraints),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildVideoAndText(BoxConstraints constraints) {
    return [
      Container(
        width:
            constraints.maxWidth > maxWidth ? constraints.maxWidth * 0.6 : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_controller.value.isInitialized) ...[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              VideoProgressIndicator(_controller, allowScrubbing: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(_controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                    onPressed: toggleMute,
                  ),
                ],
              )
            ] else
              CircularProgressIndicator(),
          ],
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Text('• Vende más mostrando mejor tus platillos',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Ahorra dinero en impresiones',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Libera carga de trabajo a tus meseros',
                  style: subtitleStyle(constraints)),
              SizedBox(height: 10),
              Text('• Marketing y promoción',
                  style: subtitleStyle(constraints)),
              Spacer()
            ],
          ),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.removeListener(videoListener);
    saveVideoPosition();
    _controller.dispose();
    super.dispose();
  }

  Future<void> saveVideoPosition() async {
    if (prefs != null && mounted) {
      await prefs!.setDouble(
          'lastPosition', _controller.value.position.inSeconds.toDouble());
    }
  }

  Future<void> initializeVideoPlayer() async {
    prefs = await SharedPreferences.getInstance();
    double lastPosition = prefs?.getDouble('lastPosition') ?? 0;

    _controller = VideoPlayerController.network(
        'https://api4urest.blob.core.windows.net/landing/29d2afb4-021b-4781-a6f6-52b819ccecd4.MP4?sv=2023-01-03&st=2024-04-15T03%3A40%3A07Z&se=2024-04-16T03%3A55%3A07Z&sr=c&sp=r&sig=lP4EtXyeaHTPpc9Hxnujzs5BZ7vr7%2BnEWRCRV49DF%2FI%3D')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _controller.seekTo(Duration(seconds: lastPosition.toInt()));
            _controller.addListener(videoListener);
            toggleMute();
            _controller.play();
          });
        }
      }).catchError((error) {
        print('Error initializing video player: $error');
      });
  }

  void videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _controller.seekTo(Duration.zero);
      _controller.play();
    }
    saveVideoPosition();
  }

  void toggleMute() {
    setState(() {
      if (isMuted) {
        _controller.setVolume(1.0);
        isMuted = false;
      } else {
        _controller.setVolume(0.0);
        isMuted = true;
      }
    });
  }
}

*/

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

final subtitle =
    GoogleFonts.montserratAlternates(fontSize: 34, fontWeight: FontWeight.bold);
final title =
    GoogleFonts.montserratAlternates(fontSize: 44, fontWeight: FontWeight.bold);

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late VideoPlayerController _controller;
  bool isMuted = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
                Center(
                  child: Text(
                    "Inova, ahorra y vende más!",
                    style: title,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "Tu menú digital espera para cambiar el juego",
                    style: title,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_controller.value.isInitialized) ...[
                              AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                              VideoProgressIndicator(_controller,
                                  allowScrubbing: true),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(_controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    onPressed: () {
                                      setState(() {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(isMuted
                                        ? Icons.volume_off
                                        : Icons.volume_up),
                                    onPressed: toggleMute,
                                  ),
                                ],
                              )
                            ] else
                              CircularProgressIndicator(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Text('• Vende más mostrando mejor tus platillos',
                                  style: subtitle),
                              SizedBox(height: 10),
                              Text('• Ahorra dinero en impresiones',
                                  style: subtitle),
                              SizedBox(height: 10),
                              Text('• Libera carga de trabajo a tus meseros',
                                  style: subtitle),
                              SizedBox(height: 10),
                              Text('• Marketing y promoción', style: subtitle),
                              Spacer()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildVideoAndText() {
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_controller.value.isInitialized) ...[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              VideoProgressIndicator(_controller, allowScrubbing: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(_controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                    onPressed: toggleMute,
                  ),
                ],
              )
            ] else
              CircularProgressIndicator(),
          ],
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Text('• Vende más mostrando mejor tus platillos',
                  style: subtitle),
              SizedBox(height: 10),
              Text('• Ahorra dinero en impresiones', style: subtitle),
              SizedBox(height: 10),
              Text('• Libera carga de trabajo a tus meseros', style: subtitle),
              SizedBox(height: 10),
              Text('• Marketing y promoción', style: subtitle),
              Spacer()
            ],
          ),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.removeListener(videoListener);
    saveVideoPosition();
    _controller.dispose();
    super.dispose();
  }

  Future<void> saveVideoPosition() async {
    if (prefs != null && mounted) {
      await prefs!.setDouble(
          'lastPosition', _controller.value.position.inSeconds.toDouble());
    }
  }

  Future<void> initializeVideoPlayer() async {
    prefs = await SharedPreferences.getInstance();
    double lastPosition = prefs?.getDouble('lastPosition') ?? 0;

    _controller = VideoPlayerController.network(
        'https://api4urest.blob.core.windows.net/landing/29d2afb4-021b-4781-a6f6-52b819ccecd4.MP4?sv=2023-01-03&st=2024-04-15T03%3A40%3A07Z&se=2024-04-16T03%3A55%3A07Z&sr=c&sp=r&sig=lP4EtXyeaHTPpc9Hxnujzs5BZ7vr7%2BnEWRCRV49DF%2FI%3D')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _controller.seekTo(Duration(seconds: lastPosition.toInt()));
            _controller.addListener(videoListener);
            toggleMute();
            _controller.play();
          });
        }
      }).catchError((error) {
        print('Error initializing video player: $error');
      });
  }

  void videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _controller.seekTo(Duration.zero);
      _controller.play();
    }
    saveVideoPosition();
  }

  void toggleMute() {
    setState(() {
      if (isMuted) {
        _controller.setVolume(1.0);
        isMuted = false;
      } else {
        _controller.setVolume(0.0);
        isMuted = true;
      }
    });
  }
}

*/