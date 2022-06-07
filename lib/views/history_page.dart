// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:garden_guard/constants.dart';
import 'package:garden_guard/views/intrusion_detail.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);
  @override
  State<HistoryPage> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Intrusion History"),
        backgroundColor: APP_GREEN,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("You can see the previous intrusions on this page.",
                              style: info),
                          actions: [
                            Center(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.done)))
                          ],
                        ));
              },
              icon: const Icon(Icons.info_outline_rounded),
              iconSize: 30)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => IntrusionDetailPage()));
            },
            child: Card(
              color: Colors.white,
              elevation: 2,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: const [
                    Expanded(child: Text("example", style: heading2)),
                    Icon(Icons.arrow_right)
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
