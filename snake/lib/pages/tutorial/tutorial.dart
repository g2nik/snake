import 'package:flutter/material.dart';
import 'package:snake/models/preferences.dart';
import 'package:snake/models/tiles.dart';
import 'package:snake/pages/home.dart';
import 'package:snake/pages/tutorial/controls.dart';
import 'package:snake/pages/tutorial/customization.dart';
import 'package:snake/pages/tutorial/info.dart';

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
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[800],
          titleSpacing: 0,
          title: TabBar(
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
              TutorialControls(
                swipe: swipe,
                function1: () => setState(() {swipe = !swipe;} ),
                function2: () => setState(() => _tabController.animateTo(1))
              ),
              TutorialInfo(
                function1: () => setState(() => _tabController.animateTo(0)),
                function2: () => setState(() => _tabController.animateTo(2)),
              ),
              TutorialCustomization(
                function1: () => setState(() => _tabController.animateTo(1)),
                function2: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())),
              )
            ],
          ),
        ), 
    );
  }
}