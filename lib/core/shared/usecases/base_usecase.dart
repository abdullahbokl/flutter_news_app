import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../errors/server_failure.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<Either<String, T>> call(Parameters parameters);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
