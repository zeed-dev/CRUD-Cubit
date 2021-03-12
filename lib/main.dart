import 'package:crud_cubit_api/cubit/pegawai_cubit.dart';
import 'package:crud_cubit_api/pages/pegawai_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PegawaiCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ListPegawaiPage(),
      ),
    );
  }
}
