import 'package:doggy_sense/common/constants/sizes.dart';
import 'package:doggy_sense/router.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 프레임워크 초기화
  await initializeDateFormatting();
  // final preferences = await SharedPreferences.getInstance();

  runApp(
    const ProviderScope(
      overrides: [],
      child: DogBark(),
    ),
  );
}

class DogBark extends ConsumerWidget {
  const DogBark({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    FlexScheme deepBlue = FlexScheme.deepBlue;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Dog Face',
      theme: FlexThemeData.light(
        scheme: deepBlue,
        appBarElevation: 0.5,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(0xFF223A5E),
            fontFamily: 'NotosansKR-Bold',
            fontSize: Sizes.size40,
          ),
          titleMedium: TextStyle(
            color: Color(0xFF223A5E),
            fontFamily: 'NotosansKR-Medium',
            fontSize: Sizes.size28,
          ),
          titleSmall: TextStyle(
            color: Color(0xFF223A5E),
            fontFamily: 'NotosansKR-Regular',
          ),
          labelLarge: TextStyle(
            color: Color(0xFFF8F9FA),
            fontFamily: 'NotosansKR-Bold',
          ),
          labelMedium: TextStyle(
            color: Color(0xFFF8F9FA),
            fontFamily: 'NotosansKR-Medium',
            fontSize: Sizes.size24,
          ),
          labelSmall: TextStyle(
            color: Colors.black,
            fontFamily: 'NotosansKR-Regular',
            fontSize: Sizes.size20,
          ),
          displaySmall: TextStyle(
            color: Color(0xFFF8F9FA),
            fontFamily: 'NotosansKR-Regular',
            fontSize: Sizes.size20,
          ),
        ),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: deepBlue,
        appBarElevation: 2,
      ),
      themeMode: ThemeMode.light,
    );
  }
}
