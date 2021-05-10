import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/widgets.dart';
import 'package:video_player/video_player.dart';

class Unlockables extends StatefulWidget {
  Unlockables(this._controller);
  VideoPlayerController _controller;

  @override
  _UnlockablesState createState() => _UnlockablesState();
}

class _UnlockablesState extends State<Unlockables> {

  void reload() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Preferences.getUnlockables(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {

          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                brightness: Brightness.dark,
                leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 50),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: widget._controller.value.size?.width ?? 0,
                        height: widget._controller.value.size?.height ?? 0,
                        child: VideoPlayer(widget._controller),
                      ),
                    )
                  ),
                  DefaultTabController(
                    length: 2,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          TabBar(
                            indicatorColor: Colors.amber,
                            tabs: [
                              Tab(child: SnakeText(text: "BODY", color: Colors.amber, size: 25, offset: true)),
                              Tab(child: SnakeText(text: "HEAD", color: Colors.amber, size: 25, offset: true)),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                ListView(
                                  children: [
                                    UnlockableButton(
                                      title: "Default",
                                      unlockable: "none",
                                      unlockingScore: 0,
                                      head: false,
                                      child: Icon(Icons.brightness_high, color: Colors.green, size: 100),
                                      onPressed: reload
                                    ),
                                    SizedBox(height: 50),
                                    UnlockableButton(
                                      title: "Red",
                                      unlockable: "red",
                                      unlockingScore: 0,
                                      head: false,
                                      child: Icon(Icons.brightness_high, color: Colors.red, size: 100),
                                      onPressed: reload
                                    ),
                                    SizedBox(height: 50),
                                    UnlockableButton(
                                      title: "Blue",
                                      unlockable: "blue",
                                      unlockingScore: 0,
                                      head: false,
                                      child: Icon(Icons.brightness_high, color: Colors.blue, size: 100),
                                      onPressed: reload
                                    ),
                                    UnlockableButton(
                                      title: "Ghost",
                                      unlockable: "ghost",
                                      unlockingScore: 5,
                                      head: false,
                                      child: Icon(Icons.brightness_high, color: Colors.cyan[200], size: 100),
                                      onPressed: reload
                                    ),
                                  ]
                                ),

                                ListView(
                                  children: [
                                    UnlockableButton(
                                      title: "Default",
                                      unlockable: "none",
                                      unlockingScore: 0,
                                      head: true,
                                      child: Icon(Icons.brightness_high, size: 100),
                                      onPressed: reload
                                    ),
                                    SizedBox(height: 50),
                                    UnlockableButton(
                                      title: "Solid Snake",
                                      unlockable: "solidSnake",
                                      head: true,
                                      unlockingScore: 10,
                                      child: Image.asset("images/solid_snake.png"),
                                      onPressed: reload
                                    ),
                                    UnlockableButton(
                                      title: "Kyojuro Rengoku",
                                      unlockable: "rengoku",
                                      head: true,
                                      unlockingScore: 10,
                                      child: Image.asset("images/rengoku.png"),
                                      onPressed: reload
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              )
          );
        }
      }
    );
  }
}
