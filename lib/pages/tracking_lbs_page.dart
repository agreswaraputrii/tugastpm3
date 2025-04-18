import 'package:flutter/material.dart';
import 'package:location/location.dart';

class TrackingLBSScreen extends StatefulWidget {
  const TrackingLBSScreen({Key? key}) : super(key: key);

  @override
  State<TrackingLBSScreen> createState() => _TrackingLBSScreenState();
}

class _TrackingLBSScreenState extends State<TrackingLBSScreen> {
  LocationData? _locationData;
  final Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  bool _loading = false;

  Future<void> _getLocation() async {
    setState(() {
      _loading = true;
    });

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() => _loading = false);
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() => _loading = false);
        return;
      }
    }

    final loc = await location.getLocation();
    setState(() {
      _locationData = loc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF095793);
    final Color background = const Color(0xFF1E1E1E);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: const Text(
          'Tracking LBS',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _getLocation,
              icon: const Icon(Icons.my_location, color: Colors.white),
              label: const Text("Lacak Lokasi Sekarang"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _loading
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Koordinat Saat Ini:",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _locationData == null
                              ? "Tekan tombol di atas untuk mulai melacak"
                              : "Latitude: ${_locationData!.latitude}\nLongitude: ${_locationData!.longitude}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
