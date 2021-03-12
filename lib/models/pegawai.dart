class Pegawai {
  Pegawai({
    this.id,
    this.nama,
    this.posisi,
    this.gaji,
  });

  final int id;
  final String nama;
  final String posisi;
  final String gaji;

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        id: int.tryParse(json["id"]),
        nama: json["nama"],
        posisi: json["posisi"],
        gaji: json["gaji"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "posisi": posisi,
        "gaji": gaji,
      };

  @override
  String toString() {
    return 'Pegawai(id: $id, nama: $nama, posisi: $posisi, gaji: $gaji)';
  }
}
