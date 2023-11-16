part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ChangeTheme extends ThemeEvent {}

class GetTheme extends ThemeEvent {}
