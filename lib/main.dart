import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_all_phones_cubit.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_phones_by_department_cubit.dart';
import 'package:phone_book/future/presentation/screens/phone_screen.dart';
import 'package:phone_book/service_locator.dart' as di;
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  initLogger();
  runApp(const MyApp());
}

void initLogger() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    String line = '${record.level.name}: ${record.time}: ${record.message}';
    // Print to console
    debugPrint(line);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllPhonesCubit>(create: (_) => di.sl<GetAllPhonesCubit>()),
        BlocProvider<GetPhonesByDepartmentCubit>(create: (_) => di.sl<GetPhonesByDepartmentCubit>()),
      ],
      child: MaterialApp(
        title: 'PhoneBook',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: const PhoneScreen(),
      ),
    );
  }
}
