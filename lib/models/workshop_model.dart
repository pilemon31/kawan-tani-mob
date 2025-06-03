class Workshop {
  final String idWorkshop;
  final String judulWorkshop;
  final String tanggalWorkshop;
  final bool statusVerifikasi;
  final bool statusAktif;
  final String gambarWorkshop;
  final String alamatLengkapWorkshop;
  final String? deskripsiWorkshop;
  final String? hargaWorkshop;
  final String waktuMulai;
  final String waktuBerakhir;
  final int? kapasitas;
  final double? latLokasi;
  final double? longLokasi;
  final int? idKabupaten;
  final String? idFacilitator;
  final Facilitator? facilitator;

  Workshop({
    required this.idWorkshop,
    required this.judulWorkshop,
    required this.tanggalWorkshop,
    required this.statusVerifikasi,
    required this.statusAktif,
    required this.gambarWorkshop,
    required this.alamatLengkapWorkshop,
    required this.waktuMulai,
    required this.waktuBerakhir,
    this.deskripsiWorkshop,
    this.hargaWorkshop,
    this.kapasitas,
    this.latLokasi,
    this.longLokasi,
    this.idKabupaten,
    this.idFacilitator,
    this.facilitator,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      idWorkshop: json['id_workshop'],
      judulWorkshop: json['judul_workshop'],
      tanggalWorkshop: json['tanggal_workshop'],
      statusVerifikasi: json['status_verifikasi'],
      statusAktif: json['status_aktif'],
      gambarWorkshop: json['gambar_workshop'],
      alamatLengkapWorkshop: json['alaamt_lengkap_workshop'],
      deskripsiWorkshop: json['deskripsi_workshop'],
      hargaWorkshop: json['harga_workshop'],
      waktuMulai: json['waktu_mulai'],
      waktuBerakhir: json['waktu_berakhir'],
      kapasitas: json['kapasitas'],
      latLokasi: json['lat_lokasi']?.toDouble(),
      longLokasi: json['long_lokasi']?.toDouble(),
      idKabupaten: json['id_kabupaten'],
      idFacilitator: json['id_facilitator'],
      facilitator: json['facilitator'] != null
          ? Facilitator.fromJson(json['facilitator'])
          : null,
    );
  }
}

class Facilitator {
  final String namaFacilitator;

  Facilitator({
    required this.namaFacilitator,
  });

  factory Facilitator.fromJson(Map<String, dynamic> json) {
    return Facilitator(
      namaFacilitator: json['nama_facilitator'],
    );
  }
}

class WorkshopRegistration {
  final String nomorTiket;
  final String namaDepanPeserta;
  final String namaBelakangPeserta;
  final String emailPeserta;
  final String nomorTeleponPeserta;
  final int jenisKelaminPeserta;
  final DateTime tanggalPendaftaran;
  final bool statusPembayaran;
  final String idWorkshop;
  final int idMetodePembayaran;

  WorkshopRegistration({
    required this.nomorTiket,
    required this.namaDepanPeserta,
    required this.namaBelakangPeserta,
    required this.emailPeserta,
    required this.nomorTeleponPeserta,
    required this.jenisKelaminPeserta,
    required this.tanggalPendaftaran,
    required this.statusPembayaran,
    required this.idWorkshop,
    required this.idMetodePembayaran,
  });

  factory WorkshopRegistration.fromJson(Map<String, dynamic> json) {
    return WorkshopRegistration(
      nomorTiket: json['nomor_tiket'],
      namaDepanPeserta: json['nama_depan_peserta'],
      namaBelakangPeserta: json['nama_belakang_peserta'],
      emailPeserta: json['email_peserta'],
      nomorTeleponPeserta: json['nomor_telepon_peserta'],
      jenisKelaminPeserta: json['jenis_kelamin_peserta'],
      tanggalPendaftaran: DateTime.parse(json['tanggal_pendaftaran']),
      statusPembayaran: json['status_pembayaran'],
      idWorkshop: json['id_workshop'],
      idMetodePembayaran: json['id_metode_pembayaran'],
    );
  }
}

class CreateWorkshopRequest {
  final String title;
  final String date;
  final String address;
  final String description;
  final String price;
  final String capacity;
  final String lat;
  final String long;
  final String regency;
  final String image;

  CreateWorkshopRequest({
    required this.title,
    required this.date,
    required this.address,
    required this.description,
    required this.price,
    required this.capacity,
    required this.lat,
    required this.long,
    required this.regency,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'address': address,
      'description': description,
      'price': price,
      'capacity': capacity,
      'lat': lat,
      'long': long,
      'regency': regency,
      'image': image,
    };
  }
}

class RegisterWorkshopRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final int gender;
  final int paymentMethod;

  RegisterWorkshopRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'paymentMethod': paymentMethod,
    };
  }
}
