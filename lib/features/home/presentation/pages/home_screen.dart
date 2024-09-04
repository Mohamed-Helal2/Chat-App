import 'package:chatapp/core/widget/custom_text_form_field.dart';
import 'package:chatapp/features/home/presentation/bloc/users_cubit.dart';
import 'package:chatapp/features/home/presentation/widget/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2D2D37),
      body: Padding(
          padding: EdgeInsets.only(top: 40.h, right: 10.w, left: 10.w),
          child: Column(
            children: [
              customTextFormField(
                hintText: 'Search',
                contentPadding: const EdgeInsets.all(12),
                fillColor: const Color.fromARGB(54, 252, 251, 251),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
              BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) {
                  if (state is LoadingUsersState) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  } else if (state is SucessUsersState
                      // context.read<UsersCubit>().alluses.isNotEmpty
                      ) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => _onRefresh(context),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return UserWidget(
                                imageUrl: state.allusers[index].photourl,
                                name: state.allusers[index].name,
                                status: state.allusers[index].status,
                                id: state.allusers[index].id,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.white,
                                thickness: 0.2,
                                height: 10.h,
                              );
                            },
                            itemCount: state.allusers.length),
                      ),
                    );
                  }
                  return Center(
                    child: Text(context.read<UsersCubit>().test),
                  );
                },
              )
            ],
          )),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    return await context.read<UsersCubit>().refreshuser();
  }
}
