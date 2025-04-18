import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'stopwatch_page.dart';
import 'konversi_waktu_page.dart';
import 'jenis_bilangan_page.dart';
import 'tracking_lbs_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color primaryBlue = const Color(0xFF095793);
  final Color darkBackground = const Color(0xFF1E1E1E);
  int _selectedIndex = 0;
  String _username = "User";

  final List<Widget> _pages = [
    const MainPage(),
    const MemberPage(),
    const HelpPage(),
  ];

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'User';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all session
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: Text(
          "Selamat datang, $_username!",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Halaman Utama',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Daftar Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF095793);
    final Color darkBackground = const Color(0xFF1E1E1E);
    final Color tileColor = const Color(0xFFF5F5F5);

    final List<_MenuItem> menuItems = [
      _MenuItem('Stopwatch', Icons.timer),
      _MenuItem('Jenis Bilangan', Icons.calculate),
      _MenuItem('Tracking LBS', Icons.location_on),
      _MenuItem('Konversi Waktu', Icons.access_time),
      _MenuItem('Rekomendasi Situs', Icons.recommend),
    ];

    return Container(
      color: darkBackground,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    if (item.title == 'Stopwatch') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StopwatchPage(),
                        ),
                      );
                    } else if (item.title == 'Jenis Bilangan') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const JenisBilanganScreen()),
                      );
                    } else if (item.title == 'Tracking LBS') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TrackingLBSScreen()),
                      );
                    } else if (item.title == 'Konversi Waktu') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const KonversiWaktuScreen()),
                      );
                    } else if (item.title == 'Rekomendasi Situs') {
                      // Navigate to Rekomendasi Situs page
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: tileColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item.icon,
                          size: 36,
                          color: primaryBlue,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: primaryBlue,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  const _MenuItem(this.title, this.icon);
}

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  final List<Map<String, String>> members = const [
    {'name': 'Ajeng Anugrah', 'id': '123220060'},
    {'name': 'Agreswara Putri', 'id': '123220182'},
    {'name': 'Arya Bhagaskara', 'id': '123220188'},
    {'name': 'Novan Joko Trihananto', 'id': '123220202'},
  ];

  String _imagePath(String name) {
    return 'assets/images/${name.toLowerCase().replaceAll(' ', '_')}.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final Color darkBackground = const Color(0xFF1E1E1E);

    return Scaffold(
      backgroundColor: darkBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daftar Anggota",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(_imagePath(member['name']!)),
                        radius: 24,
                      ),
                      title: Text(
                        member['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      subtitle: Text(
                        member['id']!,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Pusat Bantuan dan Kontak",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
