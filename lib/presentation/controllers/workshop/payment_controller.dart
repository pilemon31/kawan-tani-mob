import 'package:get/get.dart';

class PaymentController extends GetxController {
   // Metode pembayaran (0: GoPay, 1: Dana, 2: OVO, 3: QRIS)
  final selectedMethod = RxInt(-1);
  
  // Informasi pembayaran
  final metode = "".obs;
  final jumlah = "Rp. 100.000,00".obs;
  final status = "Belum Dibayar".obs;

  // Daftar metode pembayaran
  final List<String> paymentMethods = [
    "GoPay",
    "Dana",
    "OVO",
    "QRIS",
  ];

  // Memilih metode pembayaran
  void selectMethod(int index) {
    selectedMethod.value = index;
    metode.value = paymentMethods[index];
  }

  // Submit pembayaran
  Future<bool> processPayment() async {
    if (selectedMethod.value == -1) return false;
    
    // Simulasi proses pembayaran
    await Future.delayed(Duration(seconds: 2));
    
    // Jika berhasil, update status
    status.value = "Terkonfirmasi";
    return true;
  }

  // Reset form pembayaran
  void resetPayment() {
    selectedMethod.value = -1;
    metode.value = "";
    status.value = "Belum Dibayar";
  }
}