import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RekomendasiSitusPage extends StatefulWidget {
  const RekomendasiSitusPage({super.key});

  @override
  _RekomendasiSitusPageState createState() => _RekomendasiSitusPageState();
}

class _RekomendasiSitusPageState extends State<RekomendasiSitusPage> {
  final List<Map<String, String>> _sites = [
    {
      'title': 'Flutter',
      'url': 'https://flutter.dev/',
      'image': 'assets/images/flutter.png',
    },
    {
      'title': 'Google Maps',
      'url': 'https://maps.google.com/maps/?entry=wc',
      'image': 'assets/images/gmaps.jpg',
    },
    {
      'title': 'VSCode',
      'url': 'https://code.visualstudio.com/',
      'image': 'assets/images/vscode.jpeg',
    },
    {
      'title': 'GitHub',
      'url': 'https://github.com/',
      'image': 'assets/images/github.png',
    },
    {
      'title': 'Android Studio',
      'url': 'https://developer.android.com/studio',
      'image': 'assets/images/android.png',
    },
  ];

  final List<bool> _favorites = List.generate(5, (index) => false);

  void _toggleFavorite(int index) {
    setState(() {
      _favorites[index] = !_favorites[index];
    });
  }

  Future<void> _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    final success = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // Ini yang paling stabil
    );

    if (!success) {
      _showErrorSnackBar(url);
    }
  } else {
    _showErrorSnackBar(url);
  }
}

void _showErrorSnackBar(String url) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Gagal membuka URL: $url'),
      backgroundColor: Colors.red,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF095793);
    final Color background = const Color(0xFF1E1E1E);

    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: const Text(
            'Rekomendasi Situs',
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
        body: ListView.builder(
          itemCount: _sites.length,
          itemBuilder: (context, index) {
            final site = _sites[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.grey[850],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _launchURL(site['url']!),
                child: ListTile(
                  leading: Image.asset(site['image']!, width: 40, height: 40),
                  title: Text(
                    site['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  subtitle: Text(
                    site['url']!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _favorites[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () => _toggleFavorite(index),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
