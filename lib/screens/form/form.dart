import 'package:farm2kitchen/settings/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:farm2kitchen/settings/router/utils/router_utils.dart';

import 'package:farm2kitchen/widgets/user_drawer/user_drawer.dart';
import 'package:farm2kitchen/widgets/app_bar/custom_app_bar.dart';
import 'package:farm2kitchen/widgets/bottom_nav_bar/bottom_nav_bar.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:farm2kitchen/classifier.dart';

import 'package:farm2kitchen/screens/predictionpage.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:text_to_speech/text_to_speech.dart';
import 'dart:async';

double n = 0;
double p = 0;
double k = 0;
double temp = 0;
double hum = 0;
double ph = 0;
double rainfall = 0;
int lands = 0;
bool fert = false;

class FormApp extends StatelessWidget {
  const FormApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm2Kitchen',
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('ml'),
        Locale('ta'),
        Locale('te')
      ],
      theme: f2kTheme,
      home: const FormPage(title: 'Farm2Kitchen'),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserDrawer(),
      appBar: CustomAppBar(
          title: APP_PAGE.home.routePageTitle, scaffoldKey: _scaffoldKey),
      bottomNavigationBar: BottomNavBar(
        navItemIndex: 0,
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(child: SignUpForm())),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nController = new TextEditingController();
  TextEditingController pController = new TextEditingController();
  TextEditingController kController = new TextEditingController();
  TextEditingController tempController = new TextEditingController();
  TextEditingController humController = new TextEditingController();
  TextEditingController phController = new TextEditingController();
  TextEditingController rainfallController = new TextEditingController();
  TextEditingController landsController = new TextEditingController();
  bool _termsChecked = true;
  bool fert = true;
  late Classifier _classifier;
  TextToSpeech tts = TextToSpeech();

  @override
  void initState() {
    super.initState();
    _classifier = Classifier();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(Text(AppLocalizations.of(context)!.nitrogen,
        style: Theme.of(context).textTheme.bodyMedium));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.nitrogen);
          tts.getLanguages();
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(hintText: 'Nitrogen'),
      keyboardType: TextInputType.number,
      controller: nController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter nitrogen';
        } else {
          return null;
        }
      },
    ));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(Text(AppLocalizations.of(context)!.phosphorus,
        style: Theme.of(context).textTheme.bodyMedium));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.phosphorus);
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(hintText: 'Phosphorous'),
      keyboardType: TextInputType.number,
      controller: pController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter phopshorus';
        } else {
          return null;
        }
      },
    ));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(Text(AppLocalizations.of(context)!.potassium,
        style: Theme.of(context).textTheme.bodyMedium));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.potassium);
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(hintText: 'Potassium'),
      keyboardType: TextInputType.number,
      controller: kController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter potassium';
        } else {
          return null;
        }
      },
    ));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(Text(AppLocalizations.of(context)!.temp,
        style: Theme.of(context).textTheme.bodyMedium));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.temp);
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(hintText: 'Temperature'),
      keyboardType: TextInputType.number,
      controller: tempController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter temperature';
        } else {
          return null;
        }
      },
    ));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(Text(AppLocalizations.of(context)!.humidity,
        style: Theme.of(context).textTheme.bodyMedium));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.humidity);
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(hintText: 'Humidity'),
      keyboardType: TextInputType.number,
      controller: humController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter humidity';
        } else {
          return null;
        }
      },
    ));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(Text(AppLocalizations.of(context)!.ph,
        style: Theme.of(context).textTheme.bodyMedium));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.ph);
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(hintText: 'Ph'),
      keyboardType: TextInputType.number,
      controller: phController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter ph';
        } else if (double.parse(value) > 14) {
          return 'Enter pH value is less than 14';
        } else {
          return null;
        }
      },
    ));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(Text(AppLocalizations.of(context)!.rainfall,
        style: Theme.of(context).textTheme.bodyMedium));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.rainfall);
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(hintText: 'Rainfall'),
      keyboardType: TextInputType.number,
      controller: rainfallController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter rainfall';
        } else {
          return null;
        }
      },
    ));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(Text(AppLocalizations.of(context)!.landsize,
        style: Theme.of(context).textTheme.bodyMedium));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.landsize);
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(hintText: 'Land Size'),
      controller: landsController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the landsize';
        } else {
          return null;
        }
      },
    ));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(CheckboxListTile(
      value: fert,
      onChanged: (value) {
        setState(() {
          fert = value.toString().toLowerCase() == 'true';
        });
      },
      title: Text(AppLocalizations.of(context)!.fert,
          style: Theme.of(context).textTheme.bodyMedium),
    ));

    formWidget.add(ElevatedButton(
        onPressed: () {
          tts.speak(AppLocalizations.of(context)!.fert);
        },
        child: Text(AppLocalizations.of(context)!.speak)));

    formWidget.add(const SizedBox(
      height: 25.0,
    ));

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value.toString().toLowerCase() == 'true';
        });
      },
      subtitle: !_termsChecked
          ? const Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: const Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    void onPressedSubmit() {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser!;
      final name = user.displayName!;
      final email = user.email;
      CollectionReference farmers =
          FirebaseFirestore.instance.collection('farmers');

      int v = 0;

      if (_formKey.currentState!.validate() && _termsChecked) {
        v = 1;
        _formKey.currentState?.save();
      } else {
        v = 0;
      }
      if (v == 1) {
        n = double.parse(nController.text);
        p = double.parse(pController.text);
        k = double.parse(kController.text);
        temp = double.parse(tempController.text);
        hum = double.parse(humController.text);
        ph = double.parse(phController.text);
        rainfall = double.parse(rainfallController.text);
        lands = int.parse(landsController.text);
        List<double> input = [n, p, k, temp, hum, ph, rainfall];
        prediction = _classifier.classify(input);

        Future<void> addUser() {
        
          return farmers
              .doc(name)
              .set({
                'name': name,
                'email': email,
                'nitrogen': n,
                'phosphorus': p,
                'potassium': k,
                'pH': ph,
                'temperature': temp,
                'humidity': hum,
                'rainfall': rainfall,
                'land size': lands,
              })
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
        }

        addUser();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PredictionPage()));

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(ElevatedButton(
      onPressed: onPressedSubmit,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromARGB(255, 24, 137, 1), // Background color
      ),
      child: Text(AppLocalizations.of(context)!.submit),
    ));

    return formWidget;
  }
}
