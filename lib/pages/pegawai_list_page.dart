import 'package:crud_cubit_api/cubit/pegawai_cubit.dart';
import 'package:crud_cubit_api/pages/addEdit_pegawai_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPegawaiPage extends StatefulWidget {
  @override
  _ListPegawaiPageState createState() => _ListPegawaiPageState();
}

class _ListPegawaiPageState extends State<ListPegawaiPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  PegawaiCubit pegawaiCubit;

  @override
  void initState() {
    super.initState();
    pegawaiCubit = PegawaiCubit();
    pegawaiCubit.getDataPegawai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text("Pegawai"),
      ),
      body: BlocProvider<PegawaiCubit>(
        create: (_) => pegawaiCubit,
        child: BlocListener<PegawaiCubit, PegawaiState>(
          listener: (context, state) {
            if (state is FailedLoadingPegawaiState) {
              // ignore: deprecated_member_use
              scaffoldState.currentState.showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is FailedDeletePegawaiState) {
              // ignore: deprecated_member_use
              scaffoldState.currentState.showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<PegawaiCubit, PegawaiState>(
            builder: (context, state) {
              if (state is LoadingPegawaiState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FailedLoadingPegawaiState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is SuccessLoadingAllPegawaiState) {
                var listPegawai = state.listPegawai;
                return ListView.builder(
                  itemCount: listPegawai.length,
                  itemBuilder: (context, index) {
                    var pegawaiData = listPegawai[index];
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pegawaiData.nama,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              pegawaiData.posisi,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              pegawaiData.gaji.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // ignore: deprecated_member_use
                                FlatButton(
                                  child: Text('DELETE'),
                                  textColor: Colors.red,
                                  onPressed: () async {
                                    var dialogConfrim = await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("warning"),
                                          content: Text(
                                            "'Are you sure you want to delete ${pegawaiData.nama}\'s data?'",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              },
                                              child: Text("Delete"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: Text("Cancel"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    print(dialogConfrim.toString());
                                    if (dialogConfrim != null &&
                                        dialogConfrim) {
                                      await context
                                          .read<PegawaiCubit>()
                                          .deleteDataPegawai(pegawaiData.id);
                                    }
                                  },
                                ),
                                // ignore: deprecated_member_use
                                FlatButton(
                                  child: Text('EDIT'),
                                  textColor: Colors.blue,
                                  onPressed: () async {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddEditPegawai(
                                          pegawai: pegawaiData,
                                        ),
                                      ),
                                    );

                                    if (result != null) {
                                      pegawaiCubit.getDataPegawai();
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditPegawai(),
            ),
          );

          if (result != null) {
            pegawaiCubit.getDataPegawai();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
