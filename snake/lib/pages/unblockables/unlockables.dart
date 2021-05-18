import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/pages/unblockables/bodies.dart';
import 'package:snake/pages/unblockables/heads.dart';
import 'package:snake/widgets.dart';

class Unlockables extends StatefulWidget {
  @override
  _UnlockablesState createState() => _UnlockablesState();
}

//In this page you can select "skins" and "masks" for the snake
//They can be unlocked depending on your highest score
class _UnlockablesState extends State<Unlockables> {
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
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/blue.jpg"),
                        fit: BoxFit.cover
                      )
                    )
                  ),
                  DefaultTabController(
                    length: 2,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          TabBar(
                            indicatorColor: Colors.green[300],
                            tabs: [
                              //We use tabs to show 2 different pages
                              Tab(child: SnakeText(text: "BODY", color: Colors.green[300], size: 25, offset: true)),
                              Tab(child: SnakeText(text: "HEAD", color: Colors.green[300], size: 25, offset: true)),
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
