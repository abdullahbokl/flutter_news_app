import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../errors/server_failure.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<Either<String, T>> call(Parameters parameters);
}

class NoParameters extends Equatable {
  const NoParameters();

  @override
  List<Object> get props => [];
}
