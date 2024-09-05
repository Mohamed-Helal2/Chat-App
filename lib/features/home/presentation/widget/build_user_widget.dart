import 'package:chatapp/features/home/presentation/bloc/users_cubit.dart';
import 'package:chatapp/features/home/presentation/widget/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildUserWidget extends StatelessWidget {
  const BuildUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is LoadingUsersState) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (state is SucessUsersState) {
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
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    return await context.read<UsersCubit>().refreshuser();
  }
}
