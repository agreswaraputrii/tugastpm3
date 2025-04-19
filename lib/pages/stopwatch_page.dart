import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int _hours = 0;
  int _seconds = 0;
  int _milliseconds = 0;
  Timer? _timer;

  void _start() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliseconds++;
        if (_milliseconds == 100) {
          _milliseconds = 0;
          _seconds++;
        }
        if (_seconds == 3600) {
          _seconds = 0;
          _hours++;
        }
      });
    });
  }

  void _stop() {
    _timer?.cancel();
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _hours = 0;
      _seconds = 0;
      _milliseconds = 0;
    });
  }

  String _formatTime(int hours, int seconds, int milliseconds) {
    final hrs = hours.toString().padLeft(2, '0');
    final mins = ((seconds ~/ 60) % 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    final ms = milliseconds.toString().padLeft(2, '0');
    return "$hrs:$mins:$secs:$ms";
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF095793);
    final Color background = Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF095793),
        title: const Text(
          'Stopwatch',
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
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Stopwatch',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF095793),
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _formatTime(_hours, _seconds, _milliseconds),
              style: const TextStyle(
                fontSize: 64,
                color: Colors.white,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _start,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Start'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _stop,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
