import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text("Welcome"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 250, maxHeight: 600),
                child: Container(
                  color: Colors.red,
                  child: TabBarView(
                    children: [



                      Column(
                        children: [
                          Text("Welcome to SNAKE", style: TextStyle(color: Colors.amber, fontSize: 30)),
                          Text("Choose a play style", style: TextStyle(color: Colors.amber, fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Swipe column
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.swipe),
                                      onPressed: () async => await Preferences.setSwipe(true),
                                    ),
                                    SizedBox(height: 20),
                                    Text("Swipe in the direction you want the snake to move")
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              //Incline column
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.sync),
                                      onPressed: () async => await Preferences.setSwipe(false),
                                    ),
                                    SizedBox(height: 20),
                                    Text("Incline the phone in the direction you want the snake to move")
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),



                      Column(
                        children: [

                        ],
                      ),



                      Column(
                        children: [
                          
                        ],
                      ),



                    ],
                  ),
                ),
              ),
              TabBar(
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.circle, color: Colors.cyan),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.circle, color: Colors.cyan),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.circle, color: Colors.cyan),
                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}