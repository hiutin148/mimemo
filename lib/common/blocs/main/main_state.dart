part of 'main_cubit.dart';

enum MainErrorType {
  none,
  locationPermissionDenied, // Người dùng từ chối quyền GPS
  locationServiceDisabled, // Máy chưa bật GPS
  networkError, // Mất mạng
  unknownError, // Lỗi server/chưa xác định
}

class MainState extends Equatable {
  const MainState({
    this.loadStatus = LoadStatus.initial,
    this.positionInfo,
    this.minuteColors = const [],
    this.errorType = MainErrorType.none,
    this.errorMessage,
  });

  final LoadStatus loadStatus;
  final PositionInfo? positionInfo;
  final List<MinuteColor> minuteColors;
  final MainErrorType errorType;
  final String? errorMessage;

  MainState copyWith({
    LoadStatus? loadStatus,
    PositionInfo? positionInfo,
    List<MinuteColor>? minuteColors,
    MainErrorType? errorType,
    String? errorMessage,
  }) {
    return MainState(
      loadStatus: loadStatus ?? this.loadStatus,
      positionInfo: positionInfo ?? this.positionInfo,
      minuteColors: minuteColors ?? this.minuteColors,
      errorType: errorType ?? this.errorType,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    positionInfo,
    minuteColors,
    errorType,
    errorMessage,
  ];
}
