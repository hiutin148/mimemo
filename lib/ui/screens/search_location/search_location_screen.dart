import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/dialog_util.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/entities/search_location_response/search_location_response.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/current_condition_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/repositories/search_location_repository.dart';
import 'package:mimemo/services/geolocation_service.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/search_location/search_location_cubit.dart';
import 'package:mimemo/ui/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class SearchLocationScreen extends StatelessWidget {
  const SearchLocationScreen({required this.homeCubit, super.key});

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchLocationCubit(
            searchLocationRepository: locator<SearchLocationRepository>(),
            positionRepository: locator<PositionRepository>(),
            geoLocationService: locator<GeoLocationService>(),
            currentConditionRepository: locator<CurrentConditionRepository>(),
          ),
        ),
        BlocProvider.value(value: homeCubit),
      ],
      child: const SearchLocationView(),
    );
  }
}

class SearchLocationView extends StatefulWidget {
  const SearchLocationView({super.key});

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {
  late final SearchLocationCubit _cubit;
  late final MainCubit _mainCubit;
  static const _searchToggleDuration = Duration(milliseconds: 200);
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SearchLocationCubit>()..init();
    _mainCubit = context.read<MainCubit>();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextFieldTap() {
    _cubit.toggleIsSearching(true);
  }

  void _onCancelTap() {
    FocusManager.instance.primaryFocus?.unfocus();
    _controller.clear();
    _cubit.toggleIsSearching(false);
  }

  Future<void> _onAddressItemTap(double? lat, double? long) async {
    if (lat != null && long != null) {
      await _mainCubit.changeLocation(lat, long);
      if (mounted) {
        context.pop();
      }
    } else {
      logger.d('No current position');
      // TODO: Show error message to user.
    }
  }

  void _onClearAllRecentPosition() {
    DialogUtil.showConfirmDialog(
      context,
      title: 'Clear all',
      message: 'Are you sure clear all recent position?',
      onAgree: () => _cubit.clearRecentPositions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              _buildTopSection(),
              _buildListSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListSection() {
    return Expanded(
      child: BlocSelector<SearchLocationCubit, SearchLocationState, bool>(
        selector: (state) => state.isSearching,
        builder: (context, isSearching) {
          return isSearching ? _buildAddressList() : _buildRecentPositions();
        },
      ),
    );
  }

  Widget _buildRecentPositions() {
    return BlocSelector<SearchLocationCubit, SearchLocationState, List<PositionInfo>>(
      selector: (state) => state.recentPositions,
      builder: (context, recentPositions) {
        return Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white54)),
              ),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RECENT',
                    style: context.textTheme.bodyMedium,
                  ),
                  AppInkWell(
                    onTap: _onClearAllRecentPosition,
                    child: Text(
                      'Clear All',
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: recentPositions.length,
                itemBuilder: (context, index) {
                  final position = recentPositions[index];
                  final parentCity = position.parentCity?.localizedName;
                  final displayParentCity = parentCity != null ? ', $parentCity' : '';
                  return AppInkWell(
                    onTap: () => _onAddressItemTap(
                      position.geoPosition?.latitude,
                      position.geoPosition?.longitude,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white54)),
                    ),
                    child: Text('${position.localizedName}$displayParentCity'),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddressList() {
    return BlocSelector<SearchLocationCubit, SearchLocationState, SearchLocationResponse?>(
      builder: (context, searchResponse) {
        if (searchResponse == null) {
          return const SizedBox();
        }
        final addresses = searchResponse.addresses;
        if (addresses?.isEmpty ?? true) {
          return _buildEmptyAddresses();
        }
        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: addresses!.length,
          itemBuilder: (context, index) {
            return AppInkWell(
              onTap: () => _onAddressItemTap(addresses[index].latitude, addresses[index].longitude),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white54)),
              ),
              child: Text(addresses[index].formattedAddress ?? ''),
            );
          },
        );
      },
      selector: (state) => state.searchLocationResponse,
    );
  }

  Widget _buildEmptyAddresses() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        spacing: 24,
        children: [
          Text('No result found.', style: context.textTheme.titleMedium?.w600),
          Text(
            'Try searching for a different city, zip code or point of interest.',
            style: context.textTheme.bodySmall?.copyWith(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return BlocSelector<SearchLocationCubit, SearchLocationState, bool>(
      builder: (context, isSearching) {
        return ColoredBox(
          color: AppColors.primary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                height: isSearching ? 0 : kToolbarHeight,
                duration: _searchToggleDuration,
                child: AppBar(
                  title: const Text('Location'),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                ),
              ),
              AnimatedContainer(
                height: isSearching ? kToolbarHeight + 4 : 0,
                duration: _searchToggleDuration,
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: AppTextField(
                            controller: _controller,
                            hintText: 'Search location',
                            onTap: _onTextFieldTap,
                            onChanged: _cubit.searchLocation,
                          ),
                        ),
                        if (isSearching) const Gap(12),
                        AnimatedContainer(
                          width: isSearching ? 50 : 0,
                          duration: _searchToggleDuration,
                          child: AppButton(
                            onPressed: _onCancelTap,
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Cancel',
                              style: context.textTheme.labelMedium,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(24),
                    _buildCurrentLocation(isSearching),
                  ],
                ),
              ),
              const Gap(12),
            ],
          ),
        );
      },
      selector: (state) => state.isSearching,
    );
  }

  Widget _buildCurrentLocation(bool isSearching) {
    return BlocBuilder<SearchLocationCubit, SearchLocationState>(
      builder: (context, state) {
        final currentPositionStatus = state.currentPositionStatus;

        if (currentPositionStatus == LoadStatus.loading ||
            currentPositionStatus == LoadStatus.initial) {
          return Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 28,
                  ),
                  Text('Current'),
                ],
              ),
              Shimmer.fromColors(
                baseColor: AppColors.primary,
                highlightColor: AppColors.secondary,
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );
        } else if (currentPositionStatus == LoadStatus.failure) {
          return const SizedBox();
        } else {
          final currentLocation = state.currentPosition;
          final currentCondition = state.currentPositionConditions;
          final currentLocationName = currentLocation?.localizedName ?? '';
          final currentLocationParentCity = currentLocation?.parentCity?.localizedName ?? '';
          final currentTemp =
              currentCondition?.temperature?.metric?.value?.toStringAsFixed(0) ?? '';
          final currentTempUnit = currentCondition?.temperature?.metric?.unit ?? '';
          final currentWeatherIcon = currentCondition?.weatherIcon ?? 0;
          const Widget searchOnWidget = Row(
            spacing: 4,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
                size: 28,
              ),
              Text('Use current location'),
            ],
          );
          final searchOffWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 28,
                  ),
                  Text('Current'),
                ],
              ),
              const Gap(8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentLocationName,
                          style: context.textTheme.bodyLarge,
                        ),
                        if (currentLocationParentCity.isNotEmpty)
                          Text(
                            currentLocationParentCity,
                            style: context.textTheme.labelMedium,
                          ),
                      ],
                    ),
                  ),
                  AppIcon(
                    icon: Utils.getIconAsset(currentWeatherIcon),
                    size: 28,
                  ),
                  const Gap(24),
                  Text(
                    currentTemp + CommonCharacters.degreeChar + currentTempUnit,
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          );
          return AppInkWell(
            onTap: () => _onAddressItemTap(
              currentLocation?.geoPosition?.latitude,
              currentLocation?.geoPosition?.longitude,
            ),
            child: AnimatedSwitcher(
              duration: _searchToggleDuration,
              child: isSearching ? searchOnWidget : searchOffWidget,
            ),
          );
        }
      },
    );
  }
}
