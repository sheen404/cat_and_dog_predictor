import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const SizedBox(
              height: 100.0,
            ),
            const Text("Teachablemachine CNN",
            style: TextStyle(
              color: Color(0xFFEEDA28),
              fontSize: 15,
            ),),
            const SizedBox(
              height: 6,
            ),
            const Text("Detect Dogs and Cats",
            style: TextStyle(
              color: Color(0xFFE99600),
              fontWeight: FontWeight.w500,
              fontSize: 28
            ),),
            const SizedBox(
              height: 50),
            Center(
              // ignore: sized_box_for_whitespace
              child: Container(
                width: 300,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Image.asset("assets/cat.png"),
                    const SizedBox(height: 50.0,),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: Color(0xFFE99600),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text("Take a Photo",
                      style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: Color(0xFFE99600),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text("Camera Roll",
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
