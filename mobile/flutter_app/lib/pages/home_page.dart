import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tomatin/data/services/location_services.dart';

class HomePage extends StatefulWidget {
  final Function(int)
      onNavigate; // Callback function to navigate using MainScreen

  const HomePage({super.key, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationServices locationServices = LocationServices();
  String cityName = 'Mendapatkan lokasi...';

  @override
  void initState() {
    super.initState();
    _getCityName();
  }

  Future<void> _getCityName() async {
    try {
      final Position? position = await locationServices.getCurrentLocation();
      if (position != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          setState(() {
            cityName = placemarks.first.locality ?? "Unknown City";
          });
        } else {
          setState(() {
            cityName = "City not found";
          });
        }
      } else {
        setState(() {
          cityName = "Location not available";
        });
      }
    } catch (e) {
      setState(() {
        cityName = "Error fetching city: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed('/weather');
                },
                child: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '30°C',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8EB69B)),
                        ),
                        Text(
                          'min 18C;max 31C',
                          style:
                              TextStyle(fontSize: 11, color: Color(0xFF8EB69B)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const ImageIcon(
                      AssetImage('assets/loc_icon.png'),
                      size: 10,
                      color: Color(0xFF7AAB8D),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      cityName,
                      style: TextStyle(fontSize: 14, color: Color(0xFF7AAB8D)),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/sunny_cloud.png',
                      width: 70,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/person_circle.png'),
                    size: 50,
                    color: Color(0xFFC6D7D1),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Siang,',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD9DADA)),
                      ),
                      Text(
                        'tomato lover!',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFD9DADA)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search Your Plants',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Grid item
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildGridItem(
                      'pot',
                      'Koleksi',
                      'Ketuk untuk melihat koleksi',
                      const Color(0xFF8EB69B),
                      'plantcollection',
                    ),
                    _buildGridItem(
                      'camera_leaf',
                      'Identifikasi Penyakit',
                      'Ketuk untuk mengenali tanaman',
                      const Color(0xFF235347),
                      'scan',
                    ),
                    _buildGridItem(
                      'user',
                      'Profile',
                      'Mengatur Profil',
                      const Color(0xFF163832),
                      'profile',
                    ),
                    _buildGridItem(
                      'article',
                      'Artikel',
                      'Eksplorasi Artikel',
                      const Color(0xFF0B2B26),
                      'article',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
      String icon, String title, String subtitle, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/$route',
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageIcon(
              AssetImage('assets/$icon.png'),
              size: 35,
              color: Color(0xFFC6D7D1),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
