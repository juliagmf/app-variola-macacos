import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import '../../constant.dart';

import 'detail_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List? _outputs;
  XFile? _image;
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }
// carregando o modelo e as labels
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }
// classificando as imagens
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 4,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
// utilizando a câmera
  Future getImageCamera() async {
    var image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
  }
// pegando imagem da galeria
  Future getImageGallery() async {
    var image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: kwhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(children: [
                      // animação ou imagem
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/card1.png'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // texto + button info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VARÍOLA DOS MACACOS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF32313A),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Entenda sintomas e tratamento da doença.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF86b386),
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xFF86b386),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  //botao
                                  child: Text(
                                    'Info',
                                    style: TextStyle(color: kyshade),
                                  ),
                                  onTap: () {
                                    // Write Tap Code Here.
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                // box da imagem
                Expanded(
                  flex: 9,
                  child: _image == null
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFFD4DCFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Color(0xFF86b386),
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.all(20),
                              child: const Text(
                                "Selecione uma imagem",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(_image!.path)),
                                fit: BoxFit.cover),
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25.0)),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                _outputs?[0]["label"] ?? "",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                ),
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // câmera
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFF86b386),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: () {
                                getImageCamera();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )),
                        ),
                        // galeria
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFF86b386),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: () {
                                getImageGallery();
                              },
                              icon: const Icon(
                                Icons.image,
                                color: Colors.white,
                              )),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
