part of 'search_location_cubit.dart';

class SearchLocationState extends Equatable {
  const SearchLocationState({
    this.loadStatus = LoadStatus.initial,
    this.currentPositionStatus = LoadStatus.initial,
    this.isSearching = false,
    this.searchLocationResponse,
    this.recentPositions = const [],
    this.currentPosition,
    this.currentPositionConditions,
  });

  final LoadStatus loadStatus;
  final bool isSearching;
  final SearchLocationResponse? searchLocationResponse;
  final List<PositionInfo> recentPositions;
  final PositionInfo? currentPosition;
  final CurrentConditions? currentPositionConditions;
  final LoadStatus currentPositionStatus;

  @override
  List<Object?> get props => [
    loadStatus,
    isSearching,
    searchLocationResponse,
    recentPositions,
    currentPosition,
    currentPositionStatus,
    currentPositionConditions,
  ];

  SearchLocationState copyWith({
    LoadStatus? loadStatus,
    bool? isSearching,
    SearchLocationResponse? searchLocationResponse,
    List<PositionInfo>? recentPositions,
    PositionInfo? currentPosition,
    CurrentConditions? currentPositionConditions,
    LoadStatus? currentPositionStatus,
  }) {
    return SearchLocationState(
      loadStatus: loadStatus ?? this.loadStatus,
      isSearching: isSearching ?? this.isSearching,
      searchLocationResponse: searchLocationResponse,
      recentPositions: recentPositions ?? this.recentPositions,
      currentPosition: currentPosition ?? this.currentPosition,
      currentPositionConditions: currentPositionConditions ?? this.currentPositionConditions,
      currentPositionStatus: currentPositionStatus ?? this.currentPositionStatus,
    );
  }
}
