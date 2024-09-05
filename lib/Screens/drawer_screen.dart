import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rowsData = [
      {'text': 'Setting', 'icon': Icons.settings},
      {'text': 'Select Language', 'icon': Icons.error_outline},
      {'text': 'Profile', 'icon': Icons.person_outline},
      {'text': 'Favorites', 'icon': Icons.favorite_border},
      {'text': 'About', 'icon': Icons.info_outline},
    ];

    return Container(
      color: Color(0xFFC69840),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/splashscreen.png'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Menu bar',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: rowsData.map((rowData) {
                return Column(
                  children: [
                    NewRow(
                      text: rowData['text'],
                      icon: rowData['icon'],
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.logout,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(width: 10),
                Text(
                  'Log out',
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
