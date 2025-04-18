import 'package:flutter/material.dart';

class KonversiWaktuScreen extends StatefulWidget {
  const KonversiWaktuScreen({super.key});

  @override
  _KonversiWaktuScreenState createState() => _KonversiWaktuScreenState();
}

class _KonversiWaktuScreenState extends State<KonversiWaktuScreen> {
  final TextEditingController controller = TextEditingController();
  String hasil = '';

  void konversi() {
    final tahun = int.tryParse(controller.text);
    if (tahun == null) {
      hasil = 'Input tidak valid';
    } else {
      int jam = tahun * 365 * 24;
      int menit = jam * 60;
      int detik = menit * 60;
      hasil = '$jam jam / $menit menit / $detik detik';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF095793);
    final Color background = const Color(0xFF1E1E1E);
    final Color textColor = Colors.white;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: const Text(
          'Konversi Waktu',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Masukkan tahun',
                labelStyle: TextStyle(color: primaryBlue),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryBlue),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryBlue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: konversi,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Konversi', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 30),
            Text(
              hasil,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Raleway',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
