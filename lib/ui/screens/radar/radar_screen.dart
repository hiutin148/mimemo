import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/enums/app_map_type.dart';
import 'package:mimemo/ui/screens/radar/radar_cubit.dart';
import 'package:mimemo/ui/screens/radar/widgets/map_type_list.dart';
import 'package:mimemo/ui/screens/radar/widgets/radar_header.dart';
import 'package:mimemo/ui/screens/radar/widgets/radar_timeline.dart';
import 'package:mimemo/ui/widgets/app_button.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RadarCubit(
        mainCubit: context.read<MainCubit>(),
      ),
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
  late final RadarCubit _radarCubit;
  MapController? _mapController;
  StyleController? _mapStyle;
  bool _hasOverlay = false;

  static const _overlaySourceId = 'weather-overlay-source';
  static const _overlayLayerId = 'weather-overlay-layer';

  @override
  void initState() {
    super.initState();
    _radarCubit = context.read<RadarCubit>();
    _radarCubit.init();
  }

  Future<void> _applyTileUrl(String? tileUrl) async {
    final style = _mapStyle;

    if (style == null || tileUrl == null) {
      return;
    }

    try {
      if (_hasOverlay) {
        await style.removeLayer(_overlayLayerId);
        await style.removeSource(_overlaySourceId);
      }

      final overlaySource = RasterSource(
        id: _overlaySourceId,
        tiles: [tileUrl],
        attribution: '© Your Provider',
      );
      await style.addSource(overlaySource);

      const overlayLayer = RasterStyleLayer(
        id: _overlayLayerId,
        sourceId: _overlaySourceId,
      );
      await style.addLayer(overlayLayer, belowLayerId: 'waterway');
      _hasOverlay = true;
    } catch (e, st) {
      debugPrint('addSource/addLayer FAILED: $e\n$st');
    }
  }

  void _showAllMapTypesBottomSheet() {
    unawaited(
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        useSafeArea: true,
        builder: (context) {
          return BlocProvider.value(
            value: _radarCubit,
            child: const MapTypeList(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RadarCubit, RadarState>(
      listenWhen: (prev, curr) => prev.tileUrl != curr.tileUrl,
      listener: (context, state) => _applyTileUrl(state.tileUrl),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: DefaultTabController(
          length: 3,
          child: Stack(
            children: [
              _buildMaps(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildMapTypesButton(),
              ),
              const Positioned(
                left: 12,
                right: 12,
                bottom: 24,
                child: RadarTimeline(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapTypesButton() {
    return BlocSelector<RadarCubit, RadarState, AppMapType>(
      selector: (state) => state.currentMapType,
      builder: (context, type) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black54, Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAllMapsButton(context),
                ..._buildMapTypeButtons(context, type),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAllMapsButton(BuildContext context) {
    return AppButton(
      radius: 100,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      onPressed: _showAllMapTypesBottomSheet,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.layers_outlined, color: Colors.black),
          const SizedBox(width: 4),
          Text(
            'All maps',
            style: context.textTheme.labelMedium?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMapTypeButtons(
    BuildContext context,
    AppMapType currentType,
  ) {
    final mapTypes = [
      (AppMapType.radar, 'Radar'),
      (AppMapType.clouds, 'Cloud'),
      (AppMapType.temperature, 'Temperature'),
    ];

    return mapTypes.map((mapTypeData) {
      final (mapType, label) = mapTypeData;
      final isSelected = currentType == mapType;

      return AppButton(
        radius: 100,
        backgroundColor: isSelected ? Colors.black : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        onPressed: () => _radarCubit.changeMapType(mapType),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      );
    }).toList();
  }

  Widget _buildMaps() {
    return MapLibreMap(
      options: MapOptions(
        initStyle: 'https://tiles.openfreemap.org/styles/positron',
        gestures: const MapGestures(
          rotate: false,
          pan: true,
          zoom: true,
          pitch: false,
        ),
        initZoom: 8,
        initBearing: 0,
        initCenter: Geographic(
          lat:
              _radarCubit.mainCubit.state.positionInfo?.geoPosition?.latitude ??
              0,
          lon:
              _radarCubit
                  .mainCubit
                  .state
                  .positionInfo
                  ?.geoPosition
                  ?.longitude ??
              0,
        ),
      ),
      onMapCreated: (controller) => _mapController = controller,
      onStyleLoaded: (style) async {
        _mapStyle = style;
        try {
          await _mapController?.enableLocation();
          await _mapController?.trackLocation();
        } catch (e, st) {
          debugPrint('Location init failed: $e\n$st');
        }
        await _applyTileUrl(_radarCubit.state.tileUrl);
      },
    );
  }

  AppBar? _buildAppBar() {
    final currentMapType = context.watch<RadarCubit>().state.currentMapType;
    return switch (currentMapType) {
      AppMapType.radar => AppBar(
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const RadarHeader(),
      ),
      _ => null,
    };
  }
}
