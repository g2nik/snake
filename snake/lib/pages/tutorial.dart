import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/models/tiles.dart';
import 'package:snake/widgets.dart';

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool swipe;
  

  @override
  void initState() {
    super.initState();
    swipe = true;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[800],
          title: Text("Welcome !!!", style: TextStyle(color: Colors.green[300])),
          centerTitle: true,
          bottom: TabBar(
            onTap: (int index) => setState(() {}),
            controller: _tabController,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.gamepad, color: _tabController.index == 0 ? Colors.green[300] : Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.info, color: _tabController.index == 1 ? Colors.green[300] : Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.play_arrow, color: _tabController.index == 2 ? Colors.green[300] : Colors.grey),
              ),
            ]
          ),
        ),
        body: Center(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [



              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  SnakeText(text: "Choose a playstyle", color: Colors.green[300], size: 50, offset: true),
                  SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        iconSize: 100,
                        icon: Icon(Icons.swipe, color: swipe ? Colors.green[300] : Colors.grey),
                        onPressed: () async {
                          await Preferences.setSwipe(true);
                          setState(() => swipe = !swipe);
                        }
                      ),
                      IconButton(
                        iconSize: 100,
                        icon: Icon(Icons.sync, color: !swipe ? Colors.green[300] : Colors.grey),
                        onPressed: () async {
                          await Preferences.setSwipe(false);
                          setState(() => swipe = !swipe);
                        }
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Column(
                          children: [
                            
                            SizedBox(height: 20),
                            SnakeText(
                              text: "Swipe in the direction you want the snake to move",
                              color: Colors.green[300],
                              size: 20, 
                              offset: true
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            SnakeText(
                              text: "Incline the phone in the direction you want the snake to move",
                              color: Colors.green[300],
                              size: 20, 
                              offset: true
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  TextButton(
                    onPressed: () {
                      _tabController.animateTo(1);
                      setState(() {
                        
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SnakeText(
                          text: "Next",
                          color: Colors.green[300],
                          size: 40, 
                          offset: true
                        ),
                        SizedBox(width: 25),
                        SnakeText(
                          text: ">",
                          color: Colors.green[300],
                          size: 50, 
                          offset: true
                        ),
                      ],
                    ),
                  )
                ],
              ),



              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  SnakeText(text: "Red apples give you 1 point", color: Colors.green[300], size: 30, offset: true),
                  SizedBox(height: 25),
                  Image.asset("images/apple.png", scale: 7.5),
                  SizedBox(height: 50),
                  SnakeText(text: "Golden apples give you 5 points", color: Colors.green[300], size: 30, offset: true),
                  SizedBox(height: 25),
                  Image.asset("images/golden_apple.png", scale: 7.5),
                  SizedBox(height: 50),
                  SnakeText(text: "Rainbow apples\ngenerate more apples", color: Colors.green[300], size: 30, offset: true),
                  //SizedBox(height: 25),
                  // Transform.scale(
                  //   scale: .3,
                  //   child: RainbowApple(),
                  // )
                  RainbowApple()
                  //Image.asset("images/golden_apple.png", scale: 7.5),
                ],
              ),



              Column(
                children: [
                  
                ],
              ),
            ],
          ),
        ),   
      
    );
  }
}