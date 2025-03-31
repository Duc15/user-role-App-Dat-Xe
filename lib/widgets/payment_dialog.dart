import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Thư viện định dạng số
import 'package:users_app/widgets/ratings_dialog.dart';
import '../methods/common_methods.dart';

class PaymentDialog extends StatefulWidget {
  final String fareAmount;
  final String driverID;

  PaymentDialog({
    super.key,
    required this.fareAmount,
    required this.driverID,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  CommonMethods cMethods = CommonMethods();

  // Tỷ giá USD sang VND (giả sử)
  final double exchangeRate = 24000.0;

  @override
  Widget build(BuildContext context) {
    // Chuyển đổi số tiền từ USD sang VND
    double fareUSD = double.tryParse(widget.fareAmount) ?? 0.0;
    double fareVND = fareUSD * exchangeRate;

    // Định dạng số tiền VND với dấu phẩy
    String formattedFareVND = NumberFormat("#,##0", "en_US").format(fareVND);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Viền bo tròn cho Dialog
      ),
      backgroundColor: Colors.white, // Nền sáng trắng
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white, // Nền sáng
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4), // Vị trí đổ bóng
              blurRadius: 8, // Độ mờ của bóng
            ),
          ], // Thêm bóng đổ cho Dialog
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Text(
              "Trả tiền",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 1.5,
              color: Colors.black12,
              thickness: 1.0,
            ),
            const SizedBox(height: 16),
            Text(
              "$formattedFareVND VND",
              style: const TextStyle(
                color: Colors.green, // Màu tiền sáng và dễ nhìn
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Bạn sẽ trả số tiền là $formattedFareVND VND cho tài xế?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "paid");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RateDriverScreen(
                      assignedDriverId: widget.driverID,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Màu nút sáng
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Viền bo tròn
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                elevation: 5, // Hiệu ứng đổ bóng nhẹ cho nút
              ),
              child: const Text(
                "Đã trả",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
