import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/widgets.dart';
import 'package:snake/pages/settings.dart';
import 'package:snake/pages/snake_page.dart';
import 'package:snake/pages/unlockables.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  VideoPlayerController _controller;

  Future loadDefaultPreferences() async {

  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("videos/space.mp4")
    ..initialize().then((_) {
      setState(() {
        _controller.play();
        _controller.setLooping(true);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            )
          ),
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SnakeText(text: "SNAKE", color: Colors.amber, size: 55, offset: true),

              SizedBox(height: 50),

              SnakeButton(
                text: "PLAY",
                onPressed: () async {
                  bool swipe = await Preferences.getControls();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SnakePage(_controller, swipe)));
                }
              ),

              SizedBox(height: 50),

              SnakeButton(
                text: "SETTTINGS",
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(_controller)));
                  setState(() {});
                }
              ),

              SizedBox(height: 50),

              SnakeButton(
                text: "UNLOCKABLES",
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => Unlockables(_controller)));
                  setState(() {});
                }
              ),

              SizedBox(height: 50),

              SnakeButton(
                text: "RESET",
                onPressed: () async {
                  await Preferences.setDefaultPreferences();
                }
              ),

              
            ],
          ),
        ),
        ]
      ),
    );
  }
}
