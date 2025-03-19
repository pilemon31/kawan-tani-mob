import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/ui/pages/auth/article_screen.dart';
import 'package:flutter_kawan_tani/ui/pages/auth/profile_screen.dart';
import 'package:flutter_kawan_tani/ui/pages/auth/start_planting_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 130, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWeatherSection(),
                  _buildPlantSection(),
                  _buildWorkshopSection(),
                  _buildNewsSection(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFF5CAD35),
        child: PhosphorIcon(
          PhosphorIcons.plus(),
          color: Colors.white,
          size: 32.0,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _buildFooter(),
    );
  }

  // Widget untuk Header
  Widget _buildHeader() {
    return Container(
      height: 130,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF78D14D),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selamat Pagi",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            "Pilemon B. 👋",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Sabtu, 11 Januari 2025",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Widget untuk Footer
  Widget _buildFooter() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF78D14D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                icon: PhosphorIcon(
                  PhosphorIcons.house(),
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
              SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StartPlantingScreen()));
                },
                icon: PhosphorIcon(
                  PhosphorIcons.tree(),
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
              SizedBox(width: 90),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArticleScreen()));
                },
                icon: PhosphorIcon(
                  PhosphorIcons.articleNyTimes(),
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
              SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                icon: PhosphorIcon(
                  PhosphorIcons.microphoneStage(),
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk bagian Cuaca
  Widget _buildWeatherSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Mojokerto, Jawa Timur",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            children: [
              _buildWeatherCard("Kelembapan", "36°C", "assets/suhu_image.jpg"),
              SizedBox(width: 8),
              _buildWeatherCard("Suhu", "36°C", "assets/suhu_image.jpg"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(String title, String value, String imagePath) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
            Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Widget untuk bagian Tanaman
  Widget _buildPlantSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tanamanmu",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lemon Malang",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("36 hari menuju panen",
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.water_drop, color: Colors.white),
                  label: Text("Siram tanaman"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF78D14D)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk bagian Workshop
  Widget _buildWorkshopSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Informasi Workshop",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Image.asset("assets/suhu_image.jpg", fit: BoxFit.cover),
        ],
      ),
    );
  }

  // Widget untuk bagian Berita
  Widget _buildNewsSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Berita Terkini",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Image.asset("assets/suhu_image.jpg", fit: BoxFit.cover),
        ],
      ),
    );
  }
}
