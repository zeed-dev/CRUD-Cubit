part of 'pegawai_cubit.dart';

@immutable
abstract class PegawaiState {}

class PegawaiInitial extends PegawaiState {}

class LoadingPegawaiState extends PegawaiState {}

class FailedLoadingPegawaiState extends PegawaiState {
  final String message;

  FailedLoadingPegawaiState({
    this.message,
  });
}

class SuccessLoadingAllPegawaiState extends PegawaiState {
  final List<Pegawai> listPegawai;

  SuccessLoadingAllPegawaiState({
    this.listPegawai,
  });
}

class FailedSubmitPegawaiState extends PegawaiState {
  final String message;

  FailedSubmitPegawaiState({
    this.message,
  });
}

class SuccessSubmitPegawaiState extends PegawaiState {}

class FailedDeletePegawaiState extends PegawaiState {
  final String message;

  FailedDeletePegawaiState({
    this.message,
  });
}
