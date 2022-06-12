// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garden_guard/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class IntrusionDetailPage extends StatefulWidget {
  const IntrusionDetailPage({Key? key}) : super(key: key);
  @override
  State<IntrusionDetailPage> createState() => _IntrusionDetailPage();
}

class _IntrusionDetailPage extends State<IntrusionDetailPage> {
  String _displayDistance = '-';
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _dailySpecialStream;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _dailySpecialStream = _database.child('UltraSonicSensor_Distance_cm').onValue.listen((event) {
      final Object? distance = event.snapshot.value;
      setState(() {
        _displayDistance = '$distance';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Intrusion Detail"),
          backgroundColor: APP_GREEN,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                "You can see the details of the selected intrusion on this page.",
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
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Date & Time", style: heading1),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text("23.01.2022 - 23:25", style: body1),
                      SizedBox(height: 30),
                      Text("Intruder Distance", style: heading1),
                      SizedBox(height: 12),
                      Text(_displayDistance + " cm", style: body1),
                      // SizedBox(height: 30),
                      // Row(
                      //   children: [
                      //     Text("Deterrents Used", style: heading1),
                      //   ],
                      // ),
                      // SizedBox(height: 12),
                      // Text("Water deterrent", style: body1),
                    ],
                  ),
                ),
              )),
        ));
  }

  @override
  void deactivate() {
    _dailySpecialStream.cancel();
    super.deactivate();
  }
}
