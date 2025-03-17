import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _currentIndex = 0;

  // final List<Widget> _pages = [
  //   const Center(child: Text("Home Page")),
  //   const Center(child: Text("Tanaman Page")),
  //   const Center(child: Text("Artikel Page")),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78D14D),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Selamat Pagi"),
                    Icon(
                      PhosphorIcons.arrowLeft(),
                      size: 30.0,
                    )
                  ],
                ),
                Text("Pilemon B."),
                Row(
                  children: [
                    Text("Sabtu, 11 Januari 2025"),
                    Icon(
                      PhosphorIcons.addressBook(),
                    )
                  ],
                ),

                // Expanded(
                //   child: Container(
                //     padding: const EdgeInsets.all(30),
                //     decoration: const BoxDecoration(
                //       color: Colors.white,
                //     ),
                //   )
                // )
              ],
            ),
          )
        ],
      ),
      // backgroundColor: Colors.white,
      // body: SafeArea(
      //   child: _currentIndex == 0 ? _buildHomePage() : _pages[_currentIndex],
      // ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Widget _buildHomePage() {
  //   return ListView(
  //     padding: EdgeInsets.zero,
  //     children: [
  //       _buildHeader(),
  //       const SizedBox(height: 20),
  //       _buildWeatherSection(),
  //       const SizedBox(height: 20),
  //       _buildPlantSection(),
  //     ],
  //   );
  // }

  // Widget _buildHeader() {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: const BoxDecoration(
  //       color: Colors.green,
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(30),
  //         bottomRight: Radius.circular(30),
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: const [
  //         Text("Selamat Pagi", style: TextStyle(color: Colors.white70)),
  //         Text(
  //           "Pilemon B. 👋",
  //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
  //         ),
  //         Text("Sabtu, 11 Januari 2025", style: TextStyle(color: Colors.white70)),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildWeatherSection() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     child: Row(
  //       children: [
  //         _buildWeatherCard("Kelembapan", "36%", "assets/humidity.png"),
  //         const SizedBox(width: 10),
  //         _buildWeatherCard("Suhu", "36°C", "assets/temperature.png"),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildWeatherCard(String title, String value, String imagePath) {
  //   return Expanded(
  //     child: Card(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //       child: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: Column(
  //           children: [
  //             Image.asset(imagePath, height: 60),
  //             const SizedBox(height: 5),
  //             Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
  //             Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildPlantSection() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     child: Card(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //       child: Column(
  //         children: [
  //           const ListTile(
  //             title: Text("Lemon Malang", style: TextStyle(fontWeight: FontWeight.bold)),
  //             subtitle: Text("36 hari menuju panen"),
  //             trailing: Icon(Icons.agriculture),
  //           ),
  //           _buildWaterButton(true),
  //           _buildWaterButton(false),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildWaterButton(bool enabled) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: ElevatedButton.icon(
  //       onPressed: enabled ? () {} : null,
  //       icon: const Icon(Icons.water_drop),
  //       label: const Text("Siram tanaman"),
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: enabled ? Colors.green : Colors.grey.shade300,
  //         foregroundColor: enabled ? Colors.white : Colors.grey,
  //         minimumSize: const Size(double.infinity, 50),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildBottomNavigationBar() {
  //   return BottomNavigationBar(
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     },
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  //       BottomNavigationBarItem(icon: Icon(Icons.nature), label: "Tanaman"),
  //       BottomNavigationBarItem(icon: Icon(Icons.article), label: "Artikel"),
  //     ],
  //   );
}
