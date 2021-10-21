import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/future/domain/entities/phone_entity.dart';
import 'package:phone_book/future/presentation/bloc/phones/get_all_phones_cubit.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetAllPhonesCubit>(context, listen: false).getAllPhones();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Book'),
      ),
      body: BlocConsumer<GetAllPhonesCubit, GetAllPhonesState>(
        listener: (context, state) {
          debugPrint('listener: $state');
        },
        bloc: BlocProvider.of<GetAllPhonesCubit>(context),
        builder: (context, state) {
          if (state is GetAllPhonesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAllPhonesLoaded) {
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
          } else if (state is GetAllPhonesError) {
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
