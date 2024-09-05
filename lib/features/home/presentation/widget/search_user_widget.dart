import 'package:chatapp/core/widget/custom_text_form_field.dart';
import 'package:chatapp/features/home/presentation/bloc/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Searchuserwidget extends StatelessWidget {
  const Searchuserwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return customTextFormField(
      controller: context.read<UsersCubit>().searchcontroller,
      onChanged: (p0) {
        context.read<UsersCubit>().filteruser(value: p0);
      },
      hintText: 'Search',
      contentPadding: const EdgeInsets.all(12),
      fillColor: const Color.fromARGB(54, 252, 251, 251),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    );
  }
}
