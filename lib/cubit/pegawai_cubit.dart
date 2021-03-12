import 'package:bloc/bloc.dart';
import 'package:crud_cubit_api/models/api_return_value.dart';
import 'package:crud_cubit_api/models/pegawai.dart';
import 'package:crud_cubit_api/services/services.dart';
import 'package:meta/meta.dart';

part 'pegawai_state.dart';

class PegawaiCubit extends Cubit<PegawaiState> {
  PegawaiCubit() : super(PegawaiInitial());

  Future<void> getDataPegawai() async {
    emit(LoadingPegawaiState());
    ApiReturnValue<List<Pegawai>> result = await PegawaiServices.getData();

    if (result.value != null) {
      emit(SuccessLoadingAllPegawaiState(listPegawai: result.value));
    } else {
      emit(FailedLoadingPegawaiState(message: result.message));
    }
  }

  Future<void> addDataPegawai(String name, String posisi, int gaji) async {
    emit(LoadingPegawaiState());
    ApiReturnValue result =
        await PegawaiServices.addPegawai(name, posisi, gaji);
    if (result.value != null) {
      emit(SuccessSubmitPegawaiState());
    } else {
      emit(FailedSubmitPegawaiState(message: result.message));
    }
  }

  Future<void> editDataPegawai(
    int id,
    String name,
    String posisi,
    int gaji,
  ) async {
    emit(LoadingPegawaiState());
    ApiReturnValue result =
        await PegawaiServices.editPegawai(id, name, posisi, gaji);
    if (result.value != null) {
      emit(SuccessSubmitPegawaiState());
    } else {
      emit(FailedSubmitPegawaiState(message: result.message));
    }
  }

  Future<void> deleteDataPegawai(
    int id,
  ) async {
    emit(LoadingPegawaiState());
    ApiReturnValue resultDelete = await PegawaiServices.deletePegawai(id);

    if (resultDelete.message != null) {
      emit(FailedDeletePegawaiState(message: resultDelete.message));
    }

    ApiReturnValue resultGetPegawai = await PegawaiServices.getData();
    if (resultGetPegawai.value != null) {
      print("get data pegawai baru");
      emit(SuccessLoadingAllPegawaiState(listPegawai: resultGetPegawai.value));
    } else {
      emit(FailedLoadingPegawaiState(message: resultGetPegawai.message));
    }
  }
}
