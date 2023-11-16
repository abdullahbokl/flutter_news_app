part of 'theme_bloc.dart';

@immutable
class ThemeState extends Equatable {
  final bool isDarkModeEnabled;
  final RequestState requestState;
  final String errorMessage;

  const ThemeState({
    this.isDarkModeEnabled = false,
    this.requestState = RequestState.loading,
    this.errorMessage = '',
  });

  ThemeState copyWith({
    bool? isDarkModeEnabled,
    RequestState? requestState,
    String? errorMessage,
  }) {
    return ThemeState(
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isDarkModeEnabled,
        requestState,
        errorMessage,
      ];
}
