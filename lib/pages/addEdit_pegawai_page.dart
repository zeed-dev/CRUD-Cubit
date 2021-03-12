import 'package:crud_cubit_api/cubit/pegawai_cubit.dart';
import 'package:flutter/material.dart';
import 'package:crud_cubit_api/models/pegawai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditPegawai extends StatefulWidget {
  final Pegawai pegawai;
  const AddEditPegawai({
    Key key,
    this.pegawai,
  }) : super(key: key);
  @override
  _AddEditPegawaiState createState() => _AddEditPegawaiState();
}

class _AddEditPegawaiState extends State<AddEditPegawai> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final formState = GlobalKey<FormState>();
  final focusNodeButtonSubmit = FocusNode();
  final pegawaiCubit = PegawaiCubit();

  TextEditingController nameController = TextEditingController();
  TextEditingController posisiController = TextEditingController();
  TextEditingController gajiController = TextEditingController();

  bool isEdit = false;
  bool isSuccess = false;

  @override
  void initState() {
    isEdit = widget.pegawai != null;
    if (isEdit) {
      nameController.text = widget.pegawai.nama;
      posisiController.text = widget.pegawai.posisi;
      gajiController.text = widget.pegawai.gaji;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSuccess) {
          setState(() {
            Navigator.pop(context, true);
          });
        }
        return true;
      },
      child: Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          title: Text(widget.pegawai == null ? "Add Pegawai" : "Edit Pegawai"),
        ),
        body: BlocListener<PegawaiCubit, PegawaiState>(
          listener: (_, state) {
            if (state is SuccessSubmitPegawaiState) {
              isSuccess = true;
              if (isEdit) {
                Navigator.pop(context, true);
              } else {
                scaffoldState.currentState
                    // ignore: deprecated_member_use
                    .showSnackBar(
                  SnackBar(
                    content: Text("Pegawai added"),
                  ),
                );
                setState(() {
                  nameController.clear();
                  posisiController.clear();
                  gajiController.clear();
                });
              }
            } else if (state is FailedSubmitPegawaiState) {
              scaffoldState.currentState
                  // ignore: deprecated_member_use
                  .showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Stack(
            children: [
              _buildWidgetForm(),
              _buildWidgetLoading(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetForm() {
    return Form(
      key: formState,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) {
                return value == null || value.isEmpty ? "Enter a name" : null;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            TextFormField(
              controller: posisiController,
              validator: (value) {
                return value == null || value.isEmpty ? "Enter a posisi" : null;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Posisi",
              ),
            ),
            TextFormField(
              controller: gajiController,
              validator: (value) {
                return value == null || value.isEmpty ? "Enter a gaji" : null;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Gaji",
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                color: Colors.blueAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                focusNode: focusNodeButtonSubmit,
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  focusNodeButtonSubmit.requestFocus();
                  if (formState.currentState.validate()) {
                    if (isEdit) {
                      print("edited");
                      context.read<PegawaiCubit>().editDataPegawai(
                          widget.pegawai.id,
                          nameController.text,
                          posisiController.text,
                          int.tryParse(gajiController.text));
                    } else {
                      setState(() {
                        Pegawai(
                          nama: nameController.text,
                          posisi: posisiController.text,
                          gaji: gajiController.text,
                        );
                        context.read<PegawaiCubit>().addDataPegawai(
                              nameController.text,
                              posisiController.text,
                              int.tryParse(gajiController.text),
                            );
                      });
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetLoading() {
    return BlocBuilder<PegawaiCubit, PegawaiState>(
      builder: (context, state) {
        if (state is LoadingPegawaiState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
