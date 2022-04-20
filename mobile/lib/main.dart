import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.cyan,
        fontFamily: "poppins",
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Travelliu"),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black26,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_align_center_outlined),
                  label: "Timeline"),
              BottomNavigationBarItem(
                icon: Icon(Icons.border_color_outlined),
                label: "Review",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_outlined), label: "Tikum"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded), label: "Profil"),
            ]),
        body: ListView(
          children: const [
            TimelineCard(data: "Ini Dari Kaenova"),
            TimelineCard(
              data: "Facebook",
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class TimelineCard extends StatelessWidget {
  final String data;
  const TimelineCard({Key? key, this.data = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Card(
            child: InkWell(
                onTap: () {},
                child: Column(children: [
                  Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://picsum.photos/200",
                              width: 40,
                              height: 40,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(data)
                        ],
                      )),
                  const SizedBox(height: 10),
                  Image.network(
                      "https://asset.kompas.com/crops/WYcYPfavcrfsNzSm6bXugeuKloA=/0x0:740x493/750x500/data/photo/2021/03/27/605e9f16e805f.jpg"),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            children: const [
                              Icon(Icons.star_border_outlined),
                              Text("4.5"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Negeri Isekai"),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Negeri ini sangat indah dimana hati, otak dan pikiran akan selalu tenang karena tempat yang dapat membuat semua beban terlepas serta mendapatkan ketenangan jiwa hhe :).",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [Icon(Icons.comment), Text("30")],
                          )
                        ],
                      )),
                ]))));
  }
}
