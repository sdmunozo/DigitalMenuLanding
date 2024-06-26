import 'package:flutter/material.dart';
import 'package:landing_v2/ui/shared/custom_app_menu.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';
import 'package:provider/provider.dart';

import 'package:landing_v2/providers/page_provider.dart';

import 'package:landing_v2/ui/views/about_view.dart';
import 'package:landing_v2/ui/views/contact_view.dart';
import 'package:landing_v2/ui/views/location_view.dart';
import 'package:landing_v2/ui/views/home_view.dart';
import 'package:landing_v2/ui/views/pricing_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: buildBoxDecoration(),
        child: Stack(
          children: [
            _HomeBody(),
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: PromotionalWidget(),
                )),
            Positioned(right: 5, bottom: 5, child: CustomAppMenu()),
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.pink, Colors.purpleAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.5, 0.5]));
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          // Si el scroll alcanza el final de la página actual
          final currentPage = pageProvider.scrollController.page?.round() ?? 0;
          if (currentPage <
              pageProvider.scrollController.positions.length - 1) {
            // Avanza a la siguiente página si no es la última
            pageProvider.scrollController.nextPage(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          }
        }
        return true; // Devuelve true para indicar que el notification fue manejado
      },
      child: ValueListenableBuilder<double>(
        valueListenable: pageProvider.topPadding,
        builder: (context, topPadding, child) {
          return PageView(
            controller: pageProvider.scrollController,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: topPadding), child: HomeView()),
              AboutView(),
              PricingView(),
              ContactView(),
              //LocationView(),
            ],
          );
        },
      ),
    );
  }
}




/*import 'package:flutter/material.dart';
import 'package:landing_v2/ui/shared/custom_app_menu.dart';
import 'package:landing_v2/ui/shared/promotional_widget.dart';
import 'package:provider/provider.dart';

import 'package:landing_v2/providers/page_provider.dart';

import 'package:landing_v2/ui/views/about_view.dart';
import 'package:landing_v2/ui/views/contact_view.dart';
import 'package:landing_v2/ui/views/location_view.dart';
import 'package:landing_v2/ui/views/home_view.dart';
import 'package:landing_v2/ui/views/pricing_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: buildBoxDecoration(),
        child: Stack(
          children: [
            _HomeBody(),
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: PromotionalWidget(),
                )),
            Positioned(right: 5, bottom: 5, child: CustomAppMenu()),
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.pink, Colors.purpleAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.5, 0.5]));
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);

    return ValueListenableBuilder<double>(
      valueListenable: pageProvider.topPadding,
      builder: (context, topPadding, child) {
        return PageView(
          controller: pageProvider.scrollController,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
                padding: EdgeInsets.only(top: topPadding), child: HomeView()),
            AboutView(),
            PricingView(),
            ContactView(),
            //LocationView(),
          ],
        );
      },
    );
  }
}


*/