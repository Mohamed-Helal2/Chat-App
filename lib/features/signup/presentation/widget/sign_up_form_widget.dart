import 'package:chatapp/core/widget/custom_text_form_field.dart';
import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().signupformkey,
      child: Column(
        children: [
          customTextFormField(
            controller: context.read<SignupCubit>().namecontroller,
            validator: (p0) {
              if (p0 == null || p0 == "") {
                return "Enter Name";
              }
            },
            prefixIcon: const Icon(
              Icons.person,
              size: 25,
            ),
            hintText: "Enter Name ..",
          ),
          SizedBox(
            height: 10.h,
          ),
          customTextFormField(
            controller: context.read<SignupCubit>().emailcontroller,
            validator: (p0) {
              if (p0 == null || p0 == "") {
                return "Enter valid Email";
              }
            },
            prefixIcon: const Icon(
              Icons.email,
              size: 25,
            ),
            hintText: "Enter Email..",
          ),
          SizedBox(
            height: 10.h,
          ),
          // Enter Password
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return customTextFormField(
                controller: context.read<SignupCubit>().passwordcontroller,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<SignupCubit>().isobsecurepassword();
                  },
                  icon: Icon(
                    context.read<SignupCubit>().isobescurepassword
                        ? FontAwesomeIcons.eyeSlash
                        : Icons.remove_red_eye_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                isobscureText: context.read<SignupCubit>().isobescurepassword,
                validator: (p0) {
                  if (p0 == null || p0 == "") {
                    return "Enter valid password";
                  }
                },
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 25,
                ),
                hintText: "Enter password..",
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          // coonfirm Password
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return customTextFormField(
                controller:
                    context.read<SignupCubit>().confirmpasswordcontroller,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<SignupCubit>().isobsecureConfirmpassword();
                  },
                  icon: Icon(
                    context.read<SignupCubit>().isobescureConfirmpassword
                        ? FontAwesomeIcons.eyeSlash
                        : Icons.remove_red_eye_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                isobscureText:
                    context.read<SignupCubit>().isobescureConfirmpassword,
                validator: (p0) {
                  if (p0 == null || p0 == "") {
                    return "Enter valid password";
                  }
                },
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 25,
                ),
                hintText: "Confirm password..",
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
