import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get name => 'Enter your name';

  @override
  String get email => 'Enter your email';

  @override
  String get nitrogen => 'Enter nitrogen levels';

  @override
  String get potassium => 'Enter potassium levels';

  @override
  String get phosphorus => 'Enter phosphurs levels';

  @override
  String get temp => 'Enter the temperature ';

  @override
  String get humidity => 'Enter the humidity';

  @override
  String get ph => 'Enter the ph';

  @override
  String get rainfall => 'Enter rainfall';

  @override
  String get landsize => 'Enter cultivation landsize';

  @override
  String get prevcrop => 'Enter the previous crops';

  @override
  String get fert => 'Enter fertilizers and pesticides used';

  @override
  String get irrig => 'Enter irrigation type';
}
