import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFC69840),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Clockin Timer',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    '00:00:00',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white54),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: const Color(0xFFC69840),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(200)),
              ),
              child: Column(
                children: [

                  const SizedBox(height: 100),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 26,
                    mainAxisSpacing: 26,
                    shrinkWrap: true,
                    children: <Widget>[
                      buildCard(context, 'Development Work', Icons.developer_mode, DevelopmentWorkPage()),
                      buildCard(context, 'Material Shifting', Icons.swap_horiz, MaterialShiftingPage()),
                      buildCard(context, 'New Material', Icons.new_releases, NewMaterialPage()),
                      buildCard(context, 'Building Work', Icons.build, BuildingWorkPage()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, String title, IconData icon, Widget page) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        bool _isTapped = false;

        return GestureDetector(
          onTapDown: (_) {
            setState(() {
              _isTapped = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              _isTapped = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _isTapped ? const Color(0xA6C69840) : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 40, color: Colors.black54),
                        const SizedBox(height: 10),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DevelopmentWorkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Development Work'),
        backgroundColor: const Color(0xFFC69840),
      ),
      body: const Center(
        child: Text('Details about Development Work'),
      ),
    );
  }
}

class MaterialShiftingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Shifting'),
        backgroundColor: const Color(0xFF0D0700),
      ),
      body: const Center(
        child: Text('Details about Material Shifting'),
      ),
    );
  }
}

class NewMaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Material'),
        backgroundColor: const Color(0xFFC69840),
      ),
      body: const Center(
        child: Text('Details about New Material'),
      ),
    );
  }
}

class BuildingWorkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Building Work'),
        backgroundColor: const Color(0xFF0D0700),
      ),
      body: const Center(
        child: Text('Details about Building Work'),
      ),
    );
  }
}
