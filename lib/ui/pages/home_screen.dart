import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track the selected index

  // // List of widgets to show for each section
  // final List<Widget> _pages = [
  //   const Center(child: Text("Home Page")),
  //   const Center(child: Text("Tanaman Page")),
  //   const Center(child: Text("Artikel Page")),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildWeatherSection(),
            _buildPlantSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Selamat Pagi",
            style: TextStyle(color: Colors.white70),
          ),
          const Text(
            "Pilemon B. 👋",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            "Sabtu, 11 Januari 2025",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildWeatherCard("Kelembapan", "36°C", "assets/humidity.png"),
          const SizedBox(width: 10),
          _buildWeatherCard("Suhu", "36°C", "assets/temperature.png"),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(String title, String value, String imagePath) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Image.asset(imagePath, height: 80),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            const ListTile(
              title: Text("Lemon Malang", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("36 hari menuju panen"),
              trailing: Icon(Icons.agriculture),
            ),
            _buildWaterButton(true),
            _buildWaterButton(false),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterButton(bool enabled) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton.icon(
        onPressed: enabled ? () {} : null,
        icon: const Icon(Icons.water_drop),
        label: const Text("Siram tanaman"),
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? Colors.green : Colors.grey.shade300,
          foregroundColor: enabled ? Colors.white : Colors.grey,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex, // Set the current index
      onTap: (index) {
        setState(() {
          _currentIndex = index; // Update the selected index
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.nature), label: "Tanaman"),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: "Artikel"),
      ],
    );
  }
}
