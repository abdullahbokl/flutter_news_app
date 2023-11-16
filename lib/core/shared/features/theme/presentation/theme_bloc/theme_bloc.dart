import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/enums.dart';
import '../../domain/usecases/change_theme_mode_usecase.dart';
import '../../domain/usecases/get_theme_mode_usecase.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeModeUseCase getThemeModeUseCase;
  final ChangeThemeModeUseCase changeThemeModeUseCase;

  ThemeBloc(
    this.getThemeModeUseCase,
    this.changeThemeModeUseCase,
  ) : super(const ThemeState()) {
    on<ChangeTheme>(_changeTheme);
    on<GetTheme>(_getTheme);
  }

  Future<void> _changeTheme(ChangeTheme event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await changeThemeModeUseCase();

    result.fold(
      (l) => emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: l.toString(),
      )),
      (r) => emit(state.copyWith(
        requestState: RequestState.loaded,
        isDarkModeEnabled: r,
      )),
    );
  }

  Future<void> _getTheme(GetTheme event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await getThemeModeUseCase();

    result.fold(
      (l) => emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: l.toString(),
      )),
      (r) => emit(state.copyWith(
        requestState: RequestState.loaded,
        isDarkModeEnabled: r,
      )),
    );
  }
}
