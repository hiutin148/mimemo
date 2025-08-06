enum MapTypeGroup {
  radar(''),
  tropical('Tropical storms maps'),
  satellite('Satellite View'),
  currentCondition('Current conditions'),
  forecast('Forecast maps');

  const MapTypeGroup(this.title);
  final String title;

}
