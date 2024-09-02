import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:get_it/get_it.dart';



final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => bingeboxCubit(),
  );
}