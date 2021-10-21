import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_all_phones_cubit.dart';
import 'package:phone_book/service_locator.dart' as di;

import 'future/presentation/screens/phone_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllPhonesCubit>(create: (_) => di.sl<GetAllPhonesCubit>()),
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
