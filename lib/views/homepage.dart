import 'package:flutter/material.dart';
import 'package:garden_guard/views/alert_detail.dart';
import 'package:garden_guard/constants.dart';
import 'package:garden_guard/views/history_page.dart';
import 'package:garden_guard/views/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("GG")),
        backgroundColor: APP_GREEN,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  padding: const EdgeInsets.only(top: 50),
                  child: const Text("The Garden Guard",
                      style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 90,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const AlertDetailPage()));
                          },
                          child: const Center(
                            child: Text(
                              "Alert Detail",
                              style: TextStyle(fontSize: 27),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: APP_GREEN,
                              onPrimary: Colors.black,
                              elevation: 5,
                              shadowColor: Colors.black,
                              side: const BorderSide(color: Colors.black, width: 2),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      Image.asset(
                        'assets/iconhome.png',
                        width: 200,
                        height: 200,
                      )
                      /*
                      SizedBox(
                        height: 90,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const HistoryPage()));
                          },
                          child: const Center(
                            child: Text(
                              "Intrusion History",
                              style: TextStyle(fontSize: 27),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: APP_GREEN,
                              onPrimary: Colors.black,
                              elevation: 5,
                              shadowColor: Colors.black,
                              side: const BorderSide(color: Colors.black, width: 2),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                      ), 
                      SizedBox(
                        height: 90,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const SettingsPage()));
                          },
                          child: const Center(
                            child: Text(
                              "Control Settings",
                              style: TextStyle(fontSize: 27),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: APP_GREEN,
                              onPrimary: Colors.black,
                              elevation: 5,
                              shadowColor: Colors.black,
                              side: const BorderSide(color: Colors.black, width: 2),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
