import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_sample_app/app_cubit.dart';
import 'package:todo_sample_app/core/app/app_assets.dart';
import 'package:todo_sample_app/core/app/app_theme.dart';
import 'package:todo_sample_app/core/injector/injection_container.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/auth/auth_widget.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final appCubit = sl<AppCubit>();

  @override
  void initState() {
    super.initState();
    appCubit.internetCheck();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: Scaffold(
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
                // return TodoDashboardWidget();
                return AuthWidget();
              } else {
                return const InternetNotAvailableWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}

class InternetNotAvailableWidget extends StatelessWidget {
  const InternetNotAvailableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets.noInternetConnection),
            const SizedBox(height: 10),
            Text(
              'Please connect to internet and try again',
              textAlign: TextAlign.center,
              style: theme.bodyText1,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Try again'),
            )
          ],
        ),
      ),
    );
  }
}
