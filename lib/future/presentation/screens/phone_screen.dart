import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_phones_by_department_cubit.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  bool firstInit = true;

  @override
  void didChangeDependencies() {
    if (firstInit) {
      BlocProvider.of<GetPhonesByDepartmentCubit>(context, listen: false).getPhonesByDepartment(depId: '1000');
      firstInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('PhoneScreen build() method');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Book'),
      ),
      body: BlocConsumer<GetPhonesByDepartmentCubit, GetPhonesByDepartmentState>(
        listener: (context, state) {
          debugPrint('listener: $state');
        },
        bloc: BlocProvider.of<GetPhonesByDepartmentCubit>(context),
        builder: (context, state) {
          if (state is GetPhonesByDepartmentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetPhonesByDepartmentLoaded) {
            final List<PhoneEntity> phones = state.phones;
            return ListView.builder(
                itemCount: phones.length,
                itemBuilder: (context, index) {
                  debugPrint('Phone: ${phones[index]}');
                  return ListTile(
                    title: Text(phones[index].name),
                    subtitle: Text(phones[index].number),
                  );
                });
          } else if (state is GetPhonesByDepartmentError) {
            return Center(child: Text(state.message));
          }
          return const Center(
            child: Text(
              'Phone Book',
              style: TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
    );
  }
}
