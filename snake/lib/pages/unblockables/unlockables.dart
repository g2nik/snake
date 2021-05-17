import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/pages/unblockables/bodies.dart';
import 'package:snake/pages/unblockables/heads.dart';
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
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                brightness: Brightness.dark,
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
                                UnlockableBodies(),
                                UnlockableHeads(),
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
