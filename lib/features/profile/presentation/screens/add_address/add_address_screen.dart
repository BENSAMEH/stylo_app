import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylo_app/core/di/injection_container.dart';
import 'package:stylo_app/features/profile/presentation/cubit/address/address_cubit.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final apartmentController = TextEditingController();
  final phoneController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddressCubit>(),

      child: Scaffold(
        appBar: AppBar(title: const Text('Add Address')),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: stateController,
                  decoration: const InputDecoration(labelText: 'State'),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: streetController,
                  decoration: const InputDecoration(labelText: 'Street'),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: apartmentController,
                  decoration: const InputDecoration(labelText: 'Apartment'),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () async {
                      await context.read<AddressCubit>().addAddress({
                        "state": stateController.text,
                        "city": cityController.text,
                        "street": streetController.text,
                        "apartment": apartmentController.text,
                        "phoneNumber": phoneController.text,
                        "notes": notesController.text,
                      });

                      Navigator.pop(context, true);
                    },

                    child: const Text('Save Address'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
