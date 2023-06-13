import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/bottom_nav/bottomnavbloc.dart';
import '../../blocs/bottom_nav/bottomnavevent.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.bottomNavigationBloc,
  }) : super(key: key);

  final BottomNavBloc bottomNavigationBloc;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
      currentIndex: bottomNavigationBloc.currentIndex,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/home.svg',
                color: bottomNavigationBloc.currentIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSecondary),
            label: 'Главная'),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/search.svg',
          color: bottomNavigationBloc.currentIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSecondary),
          label: 'Поиск',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/cart.svg',
          color: bottomNavigationBloc.currentIndex == 2
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSecondary),
          label: 'Корзина',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/account.svg',
          color: bottomNavigationBloc.currentIndex == 3
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSecondary),
          label: 'Аккаунт',
        ),
      ],
      onTap: (index) =>
          bottomNavigationBloc.add(PageTapped(index: index)),
    );
  }
}