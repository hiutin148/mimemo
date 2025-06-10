part of 'daily_cubit.dart';

class DailyState extends Equatable {
  const DailyState({this.loadStatus = LoadStatus.initial, this.dailyForecast});

  final LoadStatus loadStatus;
  final DailyForecast? dailyForecast;

  @override
  List<Object?> get props => [loadStatus, dailyForecast];

  DailyState copyWith({LoadStatus? loadStatus, DailyForecast? dailyForecast}) {
    return DailyState(
      loadStatus: loadStatus ?? this.loadStatus,
      dailyForecast: dailyForecast ?? this.dailyForecast,
    );
  }
}
