// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:garden_guard/constants.dart';

class AlertDetailPage extends StatefulWidget {
  const AlertDetailPage({Key? key}) : super(key: key);
  @override
  State<AlertDetailPage> createState() => _AlertDetailPage();
}

class _AlertDetailPage extends State<AlertDetailPage> {
  String _displayDistance = '-';
  String _displayDeterrents = '-';
  String _displaySystem = '-';
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _distanceStream;
  late StreamSubscription _systemStream;
  late StreamSubscription _deterrentStream;

  @override
  void initState() {
    super.initState();
    _activateDistanceListeners();
    _activateSystemListeners();
    _activateDetterentListeners();
  }

  void _activateDistanceListeners() {
    _distanceStream = _database.child('UltraSonicSensor_Distance_cm').onValue.listen((event) {
      final Object? distance = event.snapshot.value;
      setState(() {
        _displayDistance = '$distance';
      });
    });
  }

  void _activateSystemListeners() {
    _systemStream = _database.child('SYSTEM_STATUS').onValue.listen((event) {
      final Object? system = event.snapshot.value;
      setState(() {
        _displaySystem = '$system';
      });
    });
  }

  void _activateDetterentListeners() {
    _deterrentStream = _database.child('ALARM_STATUS').onValue.listen((event) {
      final Object? deterrent = event.snapshot.value;
      setState(() {
        _displayDeterrents = '$deterrent';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Alert Detail"),
          backgroundColor: APP_GREEN,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                "You can see the details of the last intrusion on this page.",
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
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text("Date & Time", style: heading1),
                      //SizedBox(height: 12),
                      //Text("23.01.2022 - 23:25", style: body1),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text("Intruder Distance", style: heading1),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(_displayDistance + " cm", style: body1),
                      SizedBox(height: 30),
                      Text("System: " + _displaySystem, style: body0),
                      SizedBox(height: 30),
                      Text("Deterrents", style: heading1),
                      SizedBox(height: 12),
                      Text('Alarm: ' + _displayDeterrents, style: body1),
                      SizedBox(height: 12),
                      Text('Buzzer: ' + _displayDeterrents, style: body1),
                      SizedBox(height: 12),
                      Text('LED: ' + _displayDeterrents, style: body1),
                      SizedBox(height: 12),
                      Text('Water Valve: ' + _displayDeterrents, style: body1),
                    ],
                  ),
                ),
              )),
        ));
  }

  @override
  void deactivate() {
    _distanceStream.cancel();
    _systemStream.cancel();
    _deterrentStream.cancel();
    super.deactivate();
  }
}
