 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm/core/utils/injections.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth/presentaion/bloc/auth_bloc.dart';

List<SingleChildWidget> providers() {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => sl(),
    ),
  ];
}
