import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/widgets.dart';
import 'package:snake/pages/settings.dart';
import 'package:snake/pages/snake_page.dart';
import 'package:snake/pages/unblockables/unlockables.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //This controller will play a video in the background
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //We initialize the video controller, set it on repeat and play it
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
    //When the widget is destroyed, it also destroys the controller
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
      //We use a stack to have 2 layers, the background and the foreground
      body: Stack(
        children: [
          //Here in the bcakground we display the video
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
          //This is the content of the foreground, which includes the title and the buttons
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //We use custom widgets like SnakeText and SnakeButton, which have their own style
              SnakeText(text: "SNAKE", color: Colors.amber, size: 55, offset: true),
              SizedBox(height: 50),
              SnakeButton(
                text: "PLAY",
                onPressed: () async {
                  bool swipe = await Preferences.getSwipe();
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
