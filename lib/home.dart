import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final picker = ImagePicker();
  late File _image;
  bool _loading = false;
  late List _output;

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);

    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite',
        labels: 'assets/labels.txt');
}

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _output = output!;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value){
      // setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

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
              child: _loading? Container(
                width: 300,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Image.asset("assets/cat.png"),
                    const SizedBox(height: 50.0,),
                  ],
                ),
              ): Container(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      child: Image.file(_image),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _output != null ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('${_output[0]['label']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),),
                    ) : Container()
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
                    onTap: pickImage,
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
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: pickGalleryImage,
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
