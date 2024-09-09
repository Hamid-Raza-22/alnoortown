import 'package:al_noor_town/Screens/Building%20Work/building_work_navigation.dart';
import 'package:al_noor_town/Screens/Development%20Work/development_page.dart';
import 'package:al_noor_town/Screens/Material%20Shifting/material_shifting.dart';
import 'package:al_noor_town/Screens/New%20Material/new_material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:al_noor_town/Screens/home_page.dart';
import 'package:al_noor_town/Screens/login_page.dart';


class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock SharedPreferences initialization
    SharedPreferences.setMockInitialValues({});

    await EasyLocalization.ensureInitialized();
  });

  testWidgets('HomePage displays the correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: GetMaterialApp(home: HomePage()),
      ),
    );
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('LoginPage displays the correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: GetMaterialApp(home: LoginPage()),
      ),
    );
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('DevelopmentPage displays the correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: GetMaterialApp(home: DevelopmentPage()),
      ),
    );
    expect(find.text('Development Work'), findsOneWidget);
  });

  testWidgets('MaterialShiftingPage displays the correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: GetMaterialApp(home: MaterialShiftingPage()),
      ),
    );
    expect(find.text('Material Shifting'), findsOneWidget);
  });

  testWidgets('NewMaterial displays the correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: GetMaterialApp(home: NewMaterial()),
      ),
    );
    expect(find.text('New Material'), findsOneWidget);
  });

  testWidgets('BuildingNavigationPage displays the correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: GetMaterialApp(home: Building_Navigation_Page()),
      ),
    );
    expect(find.text('Building Work'), findsOneWidget);
  });
}
