import 'package:flutter/material.dart';

class JenisBilanganScreen extends StatefulWidget {
  const JenisBilanganScreen({Key? key}) : super(key: key);

  @override
  _JenisBilanganScreenState createState() => _JenisBilanganScreenState();
}

class _JenisBilanganScreenState extends State<JenisBilanganScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _checkJenisBilangan() {
    String input = _controller.text.trim();
    setState(() {
      _result = getJenisBilangan(input);
    });
  }

  String getJenisBilangan(String input) {
    BigInt? bigInt = BigInt.tryParse(input);
    double? angka = double.tryParse(input);

    if (angka == null && bigInt == null) return "Input tidak valid.";

    List<String> jenis = [];

    if (bigInt != null && bigInt.toDouble() == angka) {
      if (bigInt >= BigInt.zero) jenis.add("Cacah");
      if (bigInt > BigInt.zero) jenis.add("Bulat Positif");
      if (bigInt < BigInt.zero) jenis.add("Bulat Negatif");
      if (bigInt > BigInt.one && isPrimaBigInt(bigInt)) jenis.add("Prima");
    } else if (angka != null) {
      jenis.add("Desimal");
      if (angka > 0) {
        jenis.add("Positif");
      } else if (angka < 0) {
        jenis.add("Negatif");
      } else {
        jenis.add("Nol");
      }
    }

    return jenis.isEmpty ? "Tidak diketahui." : jenis.join(", ");
  }

  bool isPrimaBigInt(BigInt number) {
    if (number <= BigInt.one) return false;
    for (BigInt i = BigInt.two; i <= number.sqrt(); i += BigInt.one) {
      if (number % i == BigInt.zero) return false;
    }
    return true;
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
          'Jenis Bilangan',
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
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Masukkan angka',
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
              onPressed: _checkJenisBilangan,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cek', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 30),
            Text(
              "Hasil: $_result",
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

// Tambahan fungsi sqrt untuk BigInt
extension BigIntSqrtExtension on BigInt {
  BigInt sqrt() {
    if (this <= BigInt.one) return this;
    BigInt low = BigInt.zero;
    BigInt high = this;
    while (low <= high) {
      BigInt mid = (low + high) >> 1;
      BigInt square = mid * mid;
      if (square == this) return mid;
      if (square < this) {
        low = mid + BigInt.one;
      } else {
        high = mid - BigInt.one;
      }
    }
    return high;
  }
}
