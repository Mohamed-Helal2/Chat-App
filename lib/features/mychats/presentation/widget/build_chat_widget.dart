import 'package:chatapp/features/mychats/presentation/bloc/allmychats_cubit.dart';
import 'package:chatapp/features/mychats/presentation/widget/all_chats_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildChatWidget extends StatelessWidget {
  const BuildChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllmychatsCubit, AllmychatsState>(
      builder: (context, state) {
        if (state is AllmychatsLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else if (state is AllmychatsSucess) {
          return AllChatsListWidget(mychatEntities: state.allmychats);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
