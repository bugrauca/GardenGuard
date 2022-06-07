// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:garden_guard/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  final database = FirebaseDatabase.instance.ref();

  bool isSystemSwitched = false;
  bool isLedSwitched = false;
  late bool newSystemValue;
  late bool newLedValue;

  void systemOn() async {
    await database.child("SYSTEM_STATUS").update({'STATUS': 'ON'});
  }

  void systemOff() async {
    await database.child("SYSTEM_STATUS").update({'STATUS': 'OFF'});
  }

  void ledOn() async {
    await database.child("LED_STATUS").update({'LED_STATUS': 'ON'});
  }

  void ledOff() async {
    await database.child("LED_STATUS").update({"LED_STATUS": 'OFF'});
  }

  void getSystemStatus() async {
    String newSystemValue =
        (await FirebaseDatabase.instance.ref().child("SYSTEM_STATUS").once()).toString();
    setState(() {
      if (newSystemValue == 'ON') {
        isSystemSwitched = true;
      } else {
        isSystemSwitched = false;
      }
    });
  }

  void getLedStatus() async {
    String newLedValue =
        (await FirebaseDatabase.instance.ref().child("LED_STATUS").once()).toString();
    setState(() {
      if (newLedValue == 'ON') {
        isLedSwitched = true;
      } else {
        isLedSwitched = false;
      }
    });
  }

  void _handleSystemSwitch(bool value) async {
    if (value) {
      systemOn();
    } else {
      systemOff();
    }
    setState(() {
      isSystemSwitched = value;
    });
  }

  void _handleLedSwitch(bool value) async {
    if (value) {
      ledOn();
    } else {
      ledOff();
    }
    setState(() {
      isLedSwitched = value;
    });
  }

  @override
  void initState() {
    getSystemStatus();
    getLedStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: APP_GREEN,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                "You can manage the control settings of the device on this page.",
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
                      Row(
                        children: [
                          Text('System', style: body0),
                          Expanded(child: SizedBox(width: 10)),
                          Switch(
                            value: isSystemSwitched,
                            onChanged: (value) async {
                              _handleSystemSwitch(value);
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                              "You can turn on/off entire system of the device.",
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
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text("Led", style: body1),
                          Expanded(child: SizedBox(width: 10)),
                          Switch(
                            value: isLedSwitched,
                            onChanged: (value) async {
                              _handleLedSwitch(value);
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                              "You can turn on/off the lights of the device.",
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
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text("Sound", style: body1),
                          Expanded(child: SizedBox(width: 10)),
                          /*Switch(
                            value: isSwitched,
                            onChanged: (value) async {
                              _handleSwitch(value);
                            },
                          ),*/
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                              "You can turn on/off the sound of the device.",
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
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text("Valve", style: body1),
                          Expanded(child: SizedBox(width: 10)),
                          /*Switch(
                            value: isSwitched,
                            onChanged: (value) async {
                              _handleSwitch(value);
                            },
                          ),*/
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                              "You can turn on/off the valve of the device.",
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
                    ],
                  ),
                ),
              )),
        ));
  }
}
