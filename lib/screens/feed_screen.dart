import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Feed Detail'),
                  ),
                  body: Center(
                    child: TextButton(
                      child: Text(
                        'More Feed Detail',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: Text('More Feed Detail'),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          child: Text(
            'Feed',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
