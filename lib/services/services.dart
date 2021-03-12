import 'dart:convert';

import 'package:crud_cubit_api/models/api_return_value.dart';
import 'package:crud_cubit_api/models/pegawai.dart';
import 'package:http/http.dart' as http;

class PegawaiServices {
  static Future<ApiReturnValue<List<Pegawai>>> getData(
      {http.Client client}) async {
    client ??= http.Client();

    var url = Uri.http(uri, "/service_pegawai/get_data_pegawai.php");

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Errors Get Data");
    }
    // print(response.body);

    List data = json.decode(response.body);

    List<Pegawai> pegawai = data.map((e) => Pegawai.fromJson(e)).toList();

    return ApiReturnValue(value: pegawai);
  }

  static Future<ApiReturnValue<String>> addPegawai(
    String name,
    String posisi,
    int gaji, {
    http.Client client,
  }) async {
    client ??= http.Client();

    var url = Uri.http(uri, "/service_pegawai/add_pegawai.php");

    var response = await client.post(
      url,
      body: {
        "namaPegawai": name,
        "posisiPegawai": posisi,
        "gajiPegawai": gaji.toString(),
      },
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Error ada data");
    }

    print("Response: " + response.body);

    var data = json.decode(response.body);

    return ApiReturnValue(value: data["message"]);
  }

  static Future<ApiReturnValue<String>> editPegawai(
    int id,
    String name,
    String posisi,
    int gaji, {
    http.Client client,
  }) async {
    client ??= http.Client();

    var url = Uri.http(uri, "/service_pegawai/edit_pegawai.php");

    var response = await client.post(
      url,
      body: {
        "id": id.toString(),
        "namaPegawai": name,
        "posisiPegawai": posisi,
        "gajiPegawai": gaji.toString(),
      },
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Error ada data");
    }

    print("Response: " + response.body);

    var data = json.decode(response.body);

    return ApiReturnValue(value: data["message"]);
  }

  static Future<ApiReturnValue<String>> deletePegawai(
    int id, {
    http.Client client,
  }) async {
    client ??= http.Client();

    var url = Uri.http(uri, "/service_pegawai/delete_pegawai.php");

    var response = await client.post(
      url,
      body: {
        "id": id.toString(),
      },
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Error ada data");
    }

    print("Response: " + response.body);

    var data = json.decode(response.body);

    return ApiReturnValue(value: data["message"]);
  }
}
