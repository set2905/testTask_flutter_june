import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testtaskflutterjune/blocs/cart/cartbloc.dart';
import 'package:testtaskflutterjune/ui/pages/mainpage.dart';
import 'package:testtaskflutterjune/ui/widgets/navbar.dart';

import 'blocs/bottom_nav/bottomnavbloc.dart';
import 'blocs/bottom_nav/bottomnavevent.dart';
import 'blocs/bottom_nav/bottomnavstate.dart';
import 'repositories/cartpagerepository.dart';
import 'repositories/mainpagerepository.dart';
import 'ui/pages/cartpage.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const Application());
}

/// {@template app_bloc_observer}
/// Custom [BlocObserver] that observes all bloc and cubit state changes.
/// {@endtemplate}
class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(error.toString());
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint(event.toString());
  }
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromARGB(255, 51, 100, 224),
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Color.fromARGB(255, 165, 169, 178),
            background: Colors.white,
            onBackground: Colors.black,
            error: Colors.black,
            onError: Colors.red,
            onSurface: Colors.black,
            surface: Color.fromARGB(255, 248, 247, 245),
          ),
          fontFamily: 'SF UI Display',
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 20),
            headlineMedium: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 18),
            headlineSmall: TextStyle(
                color: Color.fromARGB(128, 0, 0, 0),
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14),
          ),
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<BottomNavBloc>(
              create: (context) => BottomNavBloc(
                firstPageRepository: MainPageRepository(),
                secondPageRepository: CartPageRepository(),
              )..add(AppStarted(index: -1)),
            ),
            BlocProvider(
              create: (context) => CartBloc(),
            ),
          ],
          child: const HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavBloc bottomNavigationBloc =
        BlocProvider.of<BottomNavBloc>(context);
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: 58,
            child: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png")),
          ),
        ],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
                alignment: Alignment.topCenter,
                child: Icon(Icons.location_on_outlined)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Санкт-Петербург",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "12 августа, 2023",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            )
          ],
        ),
      ),
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        bloc: bottomNavigationBloc,
        builder: (BuildContext context, BottomNavState state) {
          if (state is PageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MainPageLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: MainPage(categories: state.categories),
            );
          }
          if (state is CartPageLoaded) {
            return CartPage(cartBloc:cartBloc);
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
          bloc: bottomNavigationBloc,
          builder: (BuildContext context, BottomNavState state) {
            return NavBar(bottomNavigationBloc: bottomNavigationBloc);
          }),
    );
  }
}
