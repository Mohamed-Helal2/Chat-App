import 'package:chatapp/core/widget/custom_text_form_field.dart';
import 'package:chatapp/features/login/presentation/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailAndPasswordWidget extends StatelessWidget {
  const EmailAndPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().loginformkey,
      child: Card(
          shadowColor: const Color.fromARGB(255, 85, 2, 7),
          elevation: 10,
          color: const Color.fromRGBO(255, 255, 255, 0.82),
          child: Column(
            children: [
              SizedBox(
                height: 9.h,
              ),
              // Email
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: const BoxDecoration(),
                child: customTextFormField(
                  controller: context.read<LoginCubit>().emailcontroller,
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
              ),
              SizedBox(
                height: 5.h,
              ),
              // password
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return customTextFormField(
                      controller: context.read<LoginCubit>().passwordcontroller,
                      suffixIcon: IconButton(
                          onPressed: () {
                            context.read<LoginCubit>().isobsecure();
                          },
                          icon: context.read<LoginCubit>().isobescurepassword
                              ? const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.black,
                                  size: 30,
                                )
                              : const Icon(FontAwesomeIcons.eyeSlash,
                                  color: Colors.black, size: 30)),
                      isobscureText:
                          context.read<LoginCubit>().isobescurepassword,
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
              ),
              SizedBox(
                height: 9.h,
              ),
            ],
          )),
    );
  }
}
