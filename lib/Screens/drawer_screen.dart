import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'select_language'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildLanguageTile('Urdu', 'اردو', Locale('ur')),
                _buildLanguageTile('French', 'Français', Locale('fr')),
                _buildLanguageTile('Russian', 'Русский', Locale('ru')),
                _buildLanguageTile('Chinese', '中文', Locale('zh')),
                _buildLanguageTile('Arabic', 'العربية', Locale('ar')),
                _buildLanguageTile('English', 'English', Locale('en')),
                _buildLanguageTile('German', 'Deutsch', Locale('de')),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile _buildLanguageTile(String languageName, String nativeName, Locale locale) {
    return ListTile(
      title: Row(
        children: [
          Text(
            languageName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Text(
            "($nativeName)",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
        onTap: () async {
          await context.setLocale(locale);
          print('Locale set to: ${context.locale}');
          print('Translation for "menu": ${'menu'.tr()}');// Debug print
          Phoenix.rebirth(context);
        }

    );
  }


  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rowsData = [
      {'text': 'setting'.tr(), 'icon': Icons.settings},
      {
        'text': 'select_language'.tr(),
        'icon': Icons.language,
        'onTap': _showLanguageDialog,
      },
      {'text': 'profile'.tr(), 'icon': Icons.person_outline},
      {'text': 'favorites'.tr(), 'icon': Icons.favorite_border},
      {'text': 'about'.tr(), 'icon': Icons.info_outline},
    ];

    return Container(
      color: Color(0xFFC69840),
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
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
                SizedBox(height: 120, width: 10),
                Text(
                  'menu'.tr(),
                  style: TextStyle(
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
                      onTap: rowData['onTap'],
                    ),
                    SizedBox(height: 20),
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
                SizedBox(width: 10),
                Text(
                  'log_out'.tr(),
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
  final VoidCallback? onTap;

  NewRow({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
