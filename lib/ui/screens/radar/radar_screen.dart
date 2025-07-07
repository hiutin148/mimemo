import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/repositories/radar_repository.dart';
import 'package:mimemo/ui/screens/radar/radar_cubit.dart';
import 'package:mimemo/ui/screens/radar/radar_tile_provider.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RadarCubit(radarRepository: locator<RadarRepository>()),
      child: const RadarView(),
    );
  }
}

class RadarView extends StatefulWidget {
  const RadarView({super.key});

  @override
  State<RadarView> createState() => _RadarViewState();
}

class _RadarViewState extends State<RadarView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late final MainCubit _mainCubit;
  late final RadarCubit _radarCubit;
  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _mainCubit = context.read<MainCubit>();
    _radarCubit = context.read<RadarCubit>();
    _initialCameraPosition = CameraPosition(
      target: LatLng(
        _mainCubit.state.positionInfo?.geoPosition?.latitude ?? 0,
        _mainCubit.state.positionInfo?.geoPosition?.longitude ?? 0,
      ),
      zoom: 8,
    );
  }

  int long2tileX(double lon, int zoom) {
    return ((lon + 180.0) / 360.0 * (1 << zoom)).floor();
  }

  int lat2tileY(double lat, int zoom) {
    final rad = lat * pi / 180.0;
    return ((1.0 - log(tan(rad) + 1 / cos(rad)) / pi) / 2.0 * (1 << zoom))
        .floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        tileOverlays: {
          TileOverlay(
            tileOverlayId: const TileOverlayId(
              'radar_overlay',
            ),
            tileProvider: RadarTileProvider(
              radarRepository: _radarCubit.radarRepository,
            ),
          ),
        },
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _controller.complete,
        buildingsEnabled: false,
        compassEnabled: false,
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('current_position'),
            position: LatLng(
              _initialCameraPosition.target.latitude,
              _initialCameraPosition.target.longitude,
            ),
          ),
        },
      ),
    );
  }
}
