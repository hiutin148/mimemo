import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/models/enums/app_map_type.dart';
import 'package:mimemo/repositories/radar_repository.dart';
import 'package:mimemo/ui/screens/radar/radar_cubit.dart';
import 'package:mimemo/ui/screens/radar/widgets/map_type_list.dart';
import 'package:mimemo/ui/screens/radar/widgets/radar_header.dart';
import 'package:mimemo/ui/widgets/app_button.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RadarCubit(
        radarRepository: locator<RadarRepository>(),
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
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late final RadarCubit _radarCubit;
  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _radarCubit = context.read<RadarCubit>();
    _radarCubit.init();
    _initialCameraPosition = CameraPosition(
      target: LatLng(
        _radarCubit.mainCubit.state.positionInfo?.geoPosition?.latitude ?? 0,
        _radarCubit.mainCubit.state.positionInfo?.geoPosition?.longitude ?? 0,
      ),
      zoom: 8,
    );
  }

  void _showAllMapTypesBottomSheet() {
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
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
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAllMapsButton(context),
              ..._buildMapTypeButtons(context, type),
            ],
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
    return BlocSelector<RadarCubit, RadarState, Set<TileOverlay>>(
      builder: (context, tileOverlays) {
        return GoogleMap(
          myLocationButtonEnabled: false,
          tileOverlays: tileOverlays,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: _controller.complete,
          buildingsEnabled: false,
          myLocationEnabled: true,
          style: _radarCubit.mapType,
          markers: {
            Marker(
              markerId: const MarkerId('current_position'),
              position: LatLng(
                _initialCameraPosition.target.latitude,
                _initialCameraPosition.target.longitude,
              ),
            ),
          },
        );
      },
      selector: (state) => state.tileOverlays,
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
