import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnerapp/feature/home_page/home_page.dart';
import 'package:partnerapp/feature/landing_page/landing_provider.dart';
import 'package:partnerapp/utils/route/color/app_colors.dart';
import 'package:partnerapp/widgets/clipper.dart';
import 'package:partnerapp/widgets/custom_image.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  LandingScreen({super.key});

  buildBottomNavigationMenu(context) {
    return Consumer<LandingProvider>(builder: (context, value, child) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: SizedBox(
            height: 72,
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              showSelectedLabels: true,
              enableFeedback: true,
              type: BottomNavigationBarType.fixed,
              onTap: value.changeTabIndex,
              elevation: 1,
              currentIndex: value.tabIndex,
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.red,
              unselectedLabelStyle: unselectedLabelStyle,
              selectedLabelStyle: selectedLabelStyle,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: CustomSvgImage(
                          imageName: 'home',
                          height: 24,
                          color:
                              value.tabIndex == 0 ? Colors.red : Colors.grey)),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: CustomSvgImage(
                          imageName: 'Services',
                          height: 24,
                          color:
                              value.tabIndex == 1 ? Colors.red : Colors.grey)),
                  label: 'Services',
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 30,
                  ),
                  label: 'Product',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: CustomSvgImage(
                          imageName: 'Group',
                          height: 26,
                          color:
                              value.tabIndex == 3 ? Colors.red : Colors.grey)),
                  label: 'Groupe',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: CustomSvgImage(
                          imageName: 'myshope',
                          height: 20,
                          color:
                              value.tabIndex == 4 ? Colors.red : Colors.grey)),
                  label: 'myShope',
                ),
              ],
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final staticprovider = Provider.of<LandingProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 90,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0x7fe0e0e0),
                offset: Offset(5, 5),
                blurRadius: 4.5,
              ),
            ], shape: BoxShape.circle, color: Colors.white),
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: CustomSvgImage(
                  height: 30,
                  imageName: 'product',
                ),
              ),
            ),
          ),
          bottomNavigationBar: buildBottomNavigationMenu(context),
          body: Consumer<LandingProvider>(builder: (context, provider, child) {
            return IndexedStack(
              index: provider.tabIndex,
              children: [
                const HomePage(),
                Container(),
                Container(),
                Container(),
                Container()
                // const MyTask(),
                // const MenuScreen(),
                // Container(),
                // const QuickNotes(),

                // const ProfileScreen()
                ,
              ],
            );
          })),
    );
  }
}
