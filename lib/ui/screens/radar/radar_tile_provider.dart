import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/datetime_extension.dart';
import 'package:mimemo/models/entities/zxy/zxy.dart';
import 'package:mimemo/repositories/radar_repository.dart';

class RadarTileProvider implements TileProvider {
  RadarTileProvider({required this.radarRepository});

  final RadarRepository radarRepository;

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    final data = await radarRepository.getZXYRadar(
      ZXY(z: zoom ?? 8, x: x, y: y),
      DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
    );
    print('Tile size: ${data.length} bytes');

    // Check if it's a 1x1 pixel (usually around 67-100 bytes for empty tiles)
    if (data.length < 200) {
      print('Warning: Received very small tile, likely empty/placeholder');
    }

    return Tile(1, 1, data);
  }
}
