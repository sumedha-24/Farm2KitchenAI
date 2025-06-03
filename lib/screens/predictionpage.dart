import 'package:flutter/material.dart';
import 'package:farm2kitchen/screens/form/form.dart';

import 'package:farm2kitchen/classifier.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:text_to_speech/text_to_speech.dart';

PredCrop prediction = PredCrop("", "", 0, 0);
var cname = prediction.cropname;
double tppl = prediction.ppa * lands;
double revenue = tppl * prediction.asc;
TextToSpeech tts = TextToSpeech();

class PredictionPageApp extends StatelessWidget {
  const PredictionPageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm2Kitchen',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('ml'),
        Locale('ta'),
        Locale('te')
      ],
      home: FormPage(title: 'Farm2Kitchen'),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Predicted Crop'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(prediction.imageurl),
                Text(
                  AppLocalizations.of(context)!.cropname(prediction.cropname),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ElevatedButton(
                    onPressed: () {
                      tts.speak(AppLocalizations.of(context)!
                          .cropname(prediction.cropname));
                    },
                    child: Text(AppLocalizations.of(context)!.speak)),
                const SizedBox(height: 16.0),
                Text(
                  AppLocalizations.of(context)!.cropdesc(prediction.cropname),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ElevatedButton(
                    onPressed: () {
                      tts.speak(AppLocalizations.of(context)!
                          .cropdesc(prediction.cropname));
                    },
                    child: Text(AppLocalizations.of(context)!.speak)),
                const SizedBox(height: 16.0),
                Text(
                  "${AppLocalizations.of(context)!.tppl} $tppl ${AppLocalizations.of(context)!.quintails}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16.0),
                Text(
                  "${AppLocalizations.of(context)!.tr} $revenue INR",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16.0),
                if (ph > 5.5 && ph < 7.5 && fert == false) ...[
                  Text(AppLocalizations.of(context)!.fto,
                      style: Theme.of(context).textTheme.bodySmall),
                ] else ...[
                  Text(AppLocalizations.of(context)!.ftin,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.goback),
                ),
              ],
            ),
          ),
        ));
  }
}
