import 'dart:typed_data';
// Import tflite_flutter
import 'package:tflite_flutter/tflite_flutter.dart';



class PredCrop {
  final String cropname;
  final String imageurl;
  final double asc;
  final double ppa;

  PredCrop(this.cropname, this.imageurl, this.asc, this.ppa);
}

class Classifier {
  // name of the model file

  Map<double, PredCrop> map = {
    0: PredCrop("rice", "assets/images/crop_images/rice.jpg", 190763, 29.5),
    1: PredCrop("maize", "assets/images/crop_images/maize.jpg", 3194, 15),
    2: PredCrop("chickpea", "assets/images/crop_images/chickpea.jpg", 5282, 9),
    3: PredCrop(
        "kidneybeans", "assets/images/crop_images/kidneybeans.jpg", 6954, 8),
    4: PredCrop(
        "pigeonpeas", "assets/images/crop_images/pigeonpeas.jpg", 3810, 10),
    5: PredCrop(
        "mothbeans", "assets/images/crop_images/mothbeans.jpg", 7549, 8),
    6: PredCrop("mungbean", "assets/images/crop_images/mungbean.jpg", 7489, 7),
    7: PredCrop(
        "blackgram", "assets/images/crop_images/blackgram.jpg", 7303.25, 7),
    8: PredCrop("lentil", "assets/images/crop_images/lentil.jpg", 7000, 4.8),
    9: PredCrop(
        "pomegranate", "assets/images/crop_images/pomegranate.jpg", 7483, 20.5),
    10: PredCrop("banana", "assets/images/crop_images/banana.jpg", 3600, 23),
    11: PredCrop("mango", "assets/images/crop_images/mango.jpg", 3500, 12.5),
    12: PredCrop("grapes", "assets/images/crop_images/grapes.jpg", 4000, 10),
    13: PredCrop(
        "watermelon", "assets/images/crop_images/watermelon.jpg", 850, 22.5),
    14: PredCrop(
        "muskmelon", "assets/images/crop_images/muskmelon.jpg", 1100, 17),
    15: PredCrop("apple", "assets/images/crop_images/apple.jpg", 2500, 3),
    16: PredCrop("orange", "assets/images/crop_images/orange.jpg", 1500, 12.5),
    17: PredCrop("papaya", "assets/images/crop_images/papaya.jpg", 1100, 55),
    18: PredCrop("coconut", "assets/images/crop_images/coconut.jpg", 3600, 55),
    19: PredCrop("cotton", "assets/images/crop_images/cotton.jpg", 7500, 17.5),
    20: PredCrop("jute", "assets/images/crop_images/jute.jpg", 5000, 13),
    21: PredCrop("coffee", "assets/images/crop_images/coffee.jpg", 7500, 4.17),
  };

  final _modelFile = 'crop_recommendation.tflite';
  late Interpreter _interpreter;

  Classifier() {
    _loadModel();
  }

  void _loadModel() async {
    _interpreter = await Interpreter.fromAsset(_modelFile);
    print('Interpreter loaded successfully');
  }

  PredCrop classify(List<double> input) {
   

    var input32 = Float32List.fromList(input);
    var output = Float32List(22).reshape([1, 22]);
   
    _interpreter.run(input32, output);
    Float32List output1 = Float32List.fromList(output[0]);
    var maxv =
        output1.reduce((current, next) => current > next ? current : next);
    int pos = output1.indexOf(maxv);
    return map[pos]!;
  }
}
