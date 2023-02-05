import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sample_app/app_cubit.dart';
import 'package:todo_sample_app/core/common/internet_not_avaliable.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/auth/auth_widget.dart';

class LandingWidget extends StatefulWidget {
  const LandingWidget({Key? key}) : super(key: key);

  @override
  State<LandingWidget> createState() => _LandingWidgetState();
}

class _LandingWidgetState extends State<LandingWidget> {
  final appCubit = sl<AppCubit>();

  @override
  void initState() {
    super.initState();

    /// Call internetCheck on the appCubit when the widget is initialized
    appCubit.internetCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        bloc: appCubit,
        builder: (context, state) {
          if (state is AppLoading) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator.adaptive(),
                Text('Checking internet connectivity...')
              ],
            );
          } else if (state is AppInternetAvailable) {
            // Show the AuthWidget if the state is AppInternetAvailable
            return const AuthWidget();
          } else {
            // Show the InternetNotAvailableWidget if the state is not AppLoading or AppInternetAvailable
            return InternetNotAvailableWidget(
              tryAgainTap: onTryAgainTap,
            );
          }
        },
      ),
    );
  }

  void onTryAgainTap() {
    appCubit.internetCheck();
  }
}
