import 'package:flutter/material.dart';

import 'account_page.dart';
import 'cart_page.dart';
import 'grocery_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  static const String routeName = '/homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    PageController _pageController = PageController();
    List<Widget> _screens = [GetGroceries(), GetCatalog(), GetAccount()];
    void _onPageChanged(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    void _onItemTapped(int selectedIndex) {
      setState(() {
        _pageController.jumpToPage(selectedIndex);
      });
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
              backgroundColor: Colors.black12),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'Cart',
              backgroundColor: Colors.black12),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Account',
            backgroundColor: Colors.black12,
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}



