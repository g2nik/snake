import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
  VideoPlayerController _videoController;
  AudioPlayer _audioPlayer = AudioPlayer();

  Future loadMusicPLayer() async {
    //We initialize the music player
    await _audioPlayer.setAsset("music/Bustre - Combine.mp3");
    await _audioPlayer.setLoopMode(LoopMode.all);
    _audioPlayer.play();
  }

  Future loadVideoPlayer() async {
    //We initialize the video controller, set it on repeat and play it
    _videoController = VideoPlayerController.asset("videos/space.mp4");
    await _videoController.initialize();
    await _videoController.setLooping(true);
    _videoController.play().then((value) => reload());
    //reload();
  }

  void reload() => setState(() {});

  @override
  void initState() {
    super.initState();
    loadMusicPLayer();
    loadVideoPlayer();
  }

  @override
  void dispose() {
    //When the widget is destroyed, it also destroys the controller and the audio player
    _audioPlayer.dispose();
    _videoController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _videoController.play();
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
                width: _videoController.value.size?.width ?? 0,
                height: _videoController.value.size?.height ?? 0,
                child: VideoPlayer(_videoController),
              ),
            )
          ),
          //This is the content of the foreground, which includes the title and the buttons
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //We use custom widgets like SnakeText and SnakeButton, which have their own style
              SnakeText(text: "SNAKE", color: Colors.green[300], size: 75, offset: true),
              SizedBox(height: 100),
              SnakeButton(
                text: "PLAY",
                color: Colors.green[300],
                onPressed: () async {
                  bool swipe = await Preferences.getSwipe();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SnakePage(_videoController, swipe)));
                }
              ),
              SizedBox(height: 50),
              SnakeButton(
                text: "SETTTINGS",
                color: Colors.green[300],
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(_videoController)));
                  setState(() {});
                }
              ),
              SizedBox(height: 50),
              SnakeButton(
                text: "UNLOCKABLES",
                color: Colors.green[300],
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => Unlockables(_videoController)));
                  setState(() {});
                }
              ),
              // SizedBox(height: 50),
              // SnakeButton(
              //   text: "RESET",
              //   color: Colors.green[300],
              //   onPressed: () async {
              //     await Preferences.setDefaultPreferences();
              //   }
              // ),
            ],
          ),
        ),
        ]
      ),
    );
  }
}
