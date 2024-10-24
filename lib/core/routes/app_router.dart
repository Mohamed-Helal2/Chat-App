import 'package:chatapp/core/di/dipendency_injection.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/features/bottomNavBar/presentation/bloc/bottom_nav_bar_cubit.dart';
import 'package:chatapp/features/bottomNavBar/presentation/ui/bottm_nav_bar.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/home/presentation/widget/full_screen_image_widget.dart';
import 'package:chatapp/features/login/presentation/bloc/login_cubit.dart';
import 'package:chatapp/features/login/presentation/pages/login_screen.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:chatapp/features/message/presentation/pages/google_map_screen.dart';
import 'package:chatapp/features/message/presentation/pages/message_screen.dart';
import 'package:chatapp/features/message/presentation/pages/pdf_viewer_screen.dart';
import 'package:chatapp/features/message/presentation/pages/show_images_screen.dart';
import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:chatapp/features/signup/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginscreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getit<LoginCubit>(),
                  child: const LoginScreen(),
                ));
      case Routes.signupscreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getit<SignupCubit>(),
                  child: const SignupScreen(),
                ));
      case Routes.bottomNavBAr:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getit<BottomNavBarCubit>(),
            child: const BottmNavBar(),
          ),
        );
      case Routes.fullscreenImage:
        final imageUrl = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => FullScreenImage(imageUrl: imageUrl),
        );
      case Routes.messagescreen:
        final userEntites = settings.arguments as UserEntites;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
              value: getit<MessageCubit>()..getMessages(chatId: userEntites.id),
              child: MessageScreen(
                userEntites: userEntites,
              )),
        );
      case Routes.showImgaesScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        final imagespathes = arguments['imagespathes'] as List<String>;
        final userEntites = arguments['userEntites'] as UserEntites;

        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: getit<MessageCubit>(),
                  // create: (context) => getit<MessageCubit>(),
                  child: ShowImageScreen(
                      imagepathes: imagespathes, userEntites: userEntites),
                ));
      case Routes.googlemapScreen:
        final latLng = settings.arguments as LatLng;
        return MaterialPageRoute(
            builder: (context) => GoogleMapScreen(latLng: latLng));
       case Routes.pdfViewerScreen:
        final pdfurl = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => PdfViewerScreen( content: pdfurl));
      default:
        return null;
    }
  }
}
