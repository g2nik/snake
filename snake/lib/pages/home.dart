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
  //This controller will play music in the background
  AudioPlayer _audioPlayer = AudioPlayer();

  Future loadMusicPLayer() async {
    //We initialize the music player
    await _audioPlayer.setAsset("music/Bustre - Combine.mp3");
    await _audioPlayer.setLoopMode(LoopMode.all);
    _audioPlayer.play();
  }

  @override
  void initState() {
    super.initState();
    loadMusicPLayer();
  }

  @override
  void dispose() {
    //When the widget is destroyed, it also destroys the audio player
    _audioPlayer.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _audioPlayer.play();
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
          //Here in the background we display the video
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/blue.jpg"),
                fit: BoxFit.cover
              )
            )
          ),
          //This is the content of the foreground, which includes the title and the buttons
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //We use custom widgets like SnakeText and SnakeButton,
              //which have their own style and open a new page
              SnakeText(text: "SNAKE", color: Colors.green[300], size: 75, offset: true),
              SizedBox(height: 100),
              SnakeButton(
                text: "PLAY",
                color: Colors.green[300],
                onPressed: () async {
                  bool swipe = await Preferences.getSwipe();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SnakePage(swipe)));
                }
              ),
              SizedBox(height: 50),
              SnakeButton(
                text: "SETTINGSSS",
                color: Colors.green[300],
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                  setState(() {});
                }
              ),
              SizedBox(height: 50),
              SnakeButton(
                text: "UNLOCKABLES",
                color: Colors.green[300],
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => Unlockables()));
                  setState(() {});
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
