import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_three/screens/screens.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> bottomTabs = [
    {
      'index': 0,
      'label': 'Feed',
      'icon': Icons.home,
      'key': GlobalKey<NavigatorState>(),
    },
    {
      'index': 1,
      'label': 'Search',
      'icon': Icons.search,
      'key': GlobalKey<NavigatorState>(),
    },
    {
      'index': 2,
      'label': 'Create',
      'icon': Icons.add,
      'key': GlobalKey<NavigatorState>(),
    },
    {
      'index': 3,
      'label': 'Notis',
      'icon': Icons.notifications,
      'key': GlobalKey<NavigatorState>(),
    },
    {
      'index': 4,
      'label': 'Profile',
      'icon': Icons.account_circle_outlined,
      'key': GlobalKey<NavigatorState>(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Colors.grey,
          onTap: (int index) {
            if (selectedIndex == index) {
              final navigatorKey =
                  bottomTabs[selectedIndex]['key'] as GlobalKey<NavigatorState>;

              navigatorKey.currentState!.popUntil((route) => route.isFirst);
            } else {
              selectedIndex = index;
            }
          },
          items: bottomTabs
              .map(
                (e) => BottomNavigationBarItem(
                  label: e['label'],
                  icon: Icon(e['icon'], size: 30.0),
                ),
              )
              .toList(),
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: bottomTabs[index]['key'],
            onGenerateRoute: (settings) => CupertinoPageRoute(
              settings: settings,
              builder: (context) =>
                  _showNestedScreen(bottomTabs[index]['label']),
            ),
          );
        },
      );
    } else {
      return Scaffold(
        body: Stack(
          children: bottomTabs
              .map(
                (e) => Offstage(
                  offstage: e['index'] != selectedIndex,
                  child: Navigator(
                    key: e['key'],
                    initialRoute: '/',
                    onGenerateInitialRoutes: (_, initialRoute) {
                      return [
                        MaterialPageRoute(
                          settings: RouteSettings(name: '/'),
                          builder: (context) => _showNestedScreen(
                            e['label'],
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              if (selectedIndex == index) {
                final navigatorKey = bottomTabs[selectedIndex]['key']
                    as GlobalKey<NavigatorState>;

                navigatorKey.currentState!.popUntil((route) => route.isFirst);
              } else {
                selectedIndex = index;
              }
            });
          },
          items: bottomTabs
              .map(
                (e) => BottomNavigationBarItem(
                  label: e['label'],
                  icon: Icon(e['icon'], size: 30.0),
                ),
              )
              .toList(),
        ),
      );
    }
  }

  Widget _showNestedScreen(String label) {
    switch (label) {
      case 'Feed':
        return FeedScreen();
      case 'Search':
        return SearchScreen();
      case 'Create':
        return CreatePostScreen();
      case 'Notis':
        return NotificationsScreen();
      case 'Profile':
        return ProfileScreen();
      default:
        return Scaffold();
    }
  }
}
