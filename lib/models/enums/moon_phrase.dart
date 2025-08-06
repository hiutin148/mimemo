import 'package:collection/collection.dart';

enum MoonPhase {
  newMoon('New Moon'),
  waxingCrescent('Waxing Crescent'),
  firstQuarter('First Quarter'),
  waxingGibbous('Waxing Gibbous'),
  fullMoon('Full Moon'),
  waningGibbous('Waning Gibbous'),
  lastQuarter('Last Quarter'),
  waningCrescent('Waning Crescent');

  const MoonPhase(this.label);

  final String label;

  static MoonPhase? fromString(String value) {
    return MoonPhase.values.firstWhereOrNull(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
    );
  }
}
