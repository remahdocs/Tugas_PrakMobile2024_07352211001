import 'dart:core';

// Enum fase proyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class ProdukDigital {
  String namaProduk;
  double harga;
  double hargaAwal;
  String kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori) : hargaAwal = harga;

  // Method diskonm
  void terapkanDiskon(int jumlahTerjual) {
    if (kategori == 'NetworkAutomation' && jumlahTerjual > 50) {
      double diskon = harga * 0.15;
      harga -= diskon;
      if (harga < 200000) {
        harga = 200000;
      }
    }
  }
}

// Penerappan mixin
mixin Kinerja {
  int _produktivitas = 0;
  DateTime _lastUpdate = DateTime.now();

  int get produktivitas => _produktivitas;

  // Method update produktivitas
  void updateProduktivitas(int nilai) {
    DateTime now = DateTime.now();
    if (now.difference(_lastUpdate).inDays >= 30) {
      _produktivitas = (nilai >= 0 && nilai <= 100) ? nilai : _produktivitas;
      _lastUpdate = now;
    } else {
      print('Produktivitas hanya bisa diperbarui setiap 30 hari.');
//pembaruannya terjadi jika sudha lewat 30 hari sejak lastUpdate
    }
  }
}

// Kelas abstrak Karyawan
abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja();
}

// Subkelas KaryawanTetap
class KaryawanTetap extends Karyawan with Kinerja {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print(
        '$nama (Karyawan Tetap) bekerja sebagai $peran pada hari kerja reguler.');
  }

  @override
  String toString() =>
      'Nama: $nama, Peran: $peran, Produktivitas: $produktivitas';
}

// Subkelas KaryawanKontrak
class KaryawanKontrak extends Karyawan with Kinerja {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print(
        '$nama (Karyawan Kontrak) bekerja sebagai $peran pada proyek tertentu.');
  }

  @override
  String toString() =>
      'Nama: $nama, Peran: $peran, Produktivitas: $produktivitas';
}

// Kelas untuk mengelola perusahaan
class Perusahaan {
  final int maxKaryawanAktif = 20;
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];

  // Karywan ditambahkan jika belum mencapai batas max.
  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < maxKaryawanAktif) {
      karyawanAktif.add(karyawan);
    } else {
      print('Jumlah karyawan aktif mencapai batas maksimal.');
    }
  }

  // ubah status ke non-aktif
  void karyawanResign(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
    }
  }

  // tampilkan daftar karyawan aktif
  void tampilkanKaryawanAktif() {
    print('Daftar Karyawan Aktif:');
    karyawanAktif.forEach((karyawan) {
      print(karyawan.toString());
    });
  }

  // tampilkan daftar karyawan non-aktif
  void tampilkanKaryawanNonAktif() {
    print('Daftar Karyawan Non-Aktif:');
    karyawanNonAktif.forEach((karyawan) {
      print(karyawan.toString());
    });
  }
}

// pengelolaan fase proyek
class Proyek {
  FaseProyek _faseSaatIni = FaseProyek.Perencanaan;
  List<Karyawan> timProyek = [];
  DateTime tanggalMulai;

  Proyek(this.tanggalMulai);

  FaseProyek get faseSaatIni => _faseSaatIni;

  // tambah karaywan ke tim proyek
  void tambahKaryawanKeTim(Karyawan karyawan) {
    timProyek.add(karyawan);
  }

  // transisi antar fase proyek
  void nextFase() {
    if (_faseSaatIni == FaseProyek.Perencanaan && timProyek.length >= 5) {
      _faseSaatIni = FaseProyek.Pengembangan;
    } else if (_faseSaatIni == FaseProyek.Pengembangan &&
        DateTime.now().difference(tanggalMulai).inDays > 45) {
      _faseSaatIni = FaseProyek.Evaluasi;
    } else {
      print('Syarat belum terpenuhi untuk beralih ke fase berikutnya.');
    }
  }

  // Menampilkan fase saat ini dari proyek
  void tampilkanFaseProyek() {
    print('Fase saat ini proyek: ${_faseSaatIni}');
  }
}

// Contoh penerapan
void main() {
  // Contoh manajemen produk digital
  ProdukDigital produk1 =
      ProdukDigital('Data Storage', 150000, 'DataManagement');
  ProdukDigital produk2 =
      ProdukDigital('Router Automation', 300000, 'NetworkAutomation');
  print("=====PRODUK 1=====");
  print('Harga sebelum diskon produk 1: ${produk1.hargaAwal}');
  print('Harga akhir produk 1 setelah diskon: ${produk1.harga}');
  produk1.terapkanDiskon(60);

  print("=====PRODUK 2=====");
  print('Harga sebelum diskon produk 2: ${produk2.hargaAwal}');
  produk2.terapkanDiskon(60);
  print('Harga akhir produk 2 setelah diskon: ${produk2.harga}');
  print("=====================================================");

  // Contoh penambahan karyawan
  Perusahaan tongIT = Perusahaan();

  KaryawanTetap karyawan1 = KaryawanTetap('Alice', umur: 30, peran: 'Manager');
  KaryawanKontrak karyawan2 =
      KaryawanKontrak('Bob', umur: 25, peran: 'Developer');
  KaryawanTetap karyawan3 =
      KaryawanTetap('Charlie', umur: 28, peran: 'NetworkEngineer');
  KaryawanTetap karyawan4 =
      KaryawanTetap('David', umur: 32, peran: 'Developer');
  KaryawanKontrak karyawan5 =
      KaryawanKontrak('Eve', umur: 27, peran: 'Developer');

  // Menambahkan karyawan ke perusahaan
  tongIT.tambahKaryawan(karyawan1);
  tongIT.tambahKaryawan(karyawan2);
  tongIT.tambahKaryawan(karyawan3);
  tongIT.tambahKaryawan(karyawan4);
  tongIT.tambahKaryawan(karyawan5);

  // update produktivitas setiap karyawan
  karyawan1.updateProduktivitas(100); // Alice - Manager
  karyawan2.updateProduktivitas(100); // Bob - Developer
  karyawan3.updateProduktivitas(98); // Charlie - NetworkEngineer
  karyawan4.updateProduktivitas(97); // David - Developer
  karyawan5.updateProduktivitas(70); // Eve - Developer

  // Daftar karyawan tetap dan kontrak
  print("\n===== Daftar Karyawan Tetap dan Kontrak =====");
  tongIT.tampilkanKaryawanAktif();

  // manajemen fase proyek
  Proyek proyek1 = Proyek(DateTime.now().subtract(Duration(days: 50)));
  proyek1.tambahKaryawanKeTim(karyawan1);
  proyek1.tambahKaryawanKeTim(karyawan2);
  proyek1.tambahKaryawanKeTim(karyawan3);
  proyek1.tambahKaryawanKeTim(karyawan4);
  proyek1.tambahKaryawanKeTim(karyawan5);

  // fase proyek sebelum dan sesudah transisi
  print("\n===== Fase Proyek =====");
  proyek1.tampilkanFaseProyek();
  proyek1.nextFase();
  proyek1.tampilkanFaseProyek();

  // Jika seorang karyawan resign
  tongIT.karyawanResign(karyawan2);
  print("\n===== Status Karyawan Setelah Resign =====");
  tongIT.tampilkanKaryawanAktif();
  tongIT.tampilkanKaryawanNonAktif();
}
