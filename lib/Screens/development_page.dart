import 'package:flutter/material.dart';

class development_page extends StatefulWidget {
  const development_page({Key? key}) : super(key: key);

  @override
  State<development_page> createState() => _development_pageState();
}

class _development_pageState extends State<development_page> {
  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;

  List<String> texts = [
    "Road Maintenance ",
    "Sewerage Work",
    "Light Poles Work",
    "MainDrain Work",
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
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
                      'Development Work',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                    ),
                    subtitle: Text(
                      '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white54),
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return item(index);
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(int index) {
    return AnimatedContainer(
      height: 90,
      width: screenWidth,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 200)),
      transform: Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${index + 1}. ${texts[index]}",
            style: const TextStyle(
              fontSize: 28,  // Increased font size
              fontWeight: FontWeight.w500,
              color: Color(0xFFC69840),
            ),
          ),
          // Icon(
          //   icons[index],
          // ),
        ],
      ),
    );
  }
}
