import 'features/posts/presentaion/bloc/add_update_delet_posts_bloc/add_update_delet_posts_bloc.dart';
import 'features/posts/presentaion/bloc/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/service/service_locator.dart';
import 'features/posts/presentaion/pages/posts_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<PostsBloc>()..add(GetAllPostsEvents()),
        ),
        BlocProvider(
          create: (_) => sl<AddUpdateDeletPostsBloc>(),
        ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: PostScreen(),
      ),
    );
  }
}
