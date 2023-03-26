import 'dart:async';
import 'dart:math';

import 'package:android_intent_plus/android_intent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:paynless/handlers/auth_handler.dart';
import 'package:paynless/providers/user_provider.dart';
import 'package:paynless/res/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/shop.dart';
import '../../models/user.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final mapController = MapController();
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((value) {
      setState(() {
        currentLocation = LatLng(value.latitude, value.longitude);
        mapController.move(currentLocation!, 15);
      });
    });
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      setState(() {
        currentLocation = LatLng(position!.latitude, position.longitude);
        mapController.move(currentLocation!, 15);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final Random random = Random();
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/images/menu.png'),
          onPressed: () {
            AuthHandler().logOut(context);
          },
        ),
        actions: [
          CachedNetworkImage(
            imageUrl: user?.avatar ??
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
            imageBuilder: (context, imageProvider) => Container(
              width: 57.0,
              height: 57.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff000000).withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ).pOnly(left: 8, top: 8, bottom: 8),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          16.heightBox,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7),
            height: 452,
            width: 380,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff4285F4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                ),
              ],
              color: const Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
                height: 425,
                width: 367,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(41),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(41),
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          onTap: (tapPosition, point) {
                            Navigator.of(context).pushNamed(MyRoute.mapDetails);
                          },
                          bounds: LatLngBounds(LatLng(29.8659, 77.8963),
                              LatLng(29.8659, 77.8963)),
                        ),
                        nonRotatedChildren: [],
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName: 'com.tb.paynless',
                          ),
                          currentLocation == null
                              ? Container()
                              : MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: currentLocation!,
                                      width: 80,
                                      height: 80,
                                      builder: (context) => const Icon(
                                        Icons.location_on,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                          for (int i = 0; i < 10; i++)
                            currentLocation == null
                                ? Container()
                                : MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: LatLng(
                                            currentLocation!.latitude +
                                                (random.nextDouble() - 0.5) *
                                                    0.02,
                                            currentLocation!.longitude +
                                                (random.nextDouble() - 0.5) *
                                                    0.02),
                                        width: 80,
                                        height: 80,
                                        builder: (context) => const Icon(
                                          Icons.shopify_rounded,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                        ],
                      ),
                    ),
                    const Positioned(
                        bottom: 17,
                        right: 17,
                        child: Icon(
                          Icons.expand,
                          color: Colors.black,
                          size: 40,
                        ))
                  ],
                )),
          ).centered(),
        ],
      ))),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        height: context.screenHeight *
            (MediaQuery.of(context).viewInsets.bottom > 0 ? 0.8 : 0.36),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              offset: const Offset(0, -4),
              blurRadius: 30,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                43.heightBox,
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(MyRoute.nearby, arguments: true);
                    },
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(const BorderSide(
                            color: Color(0xff067A04), width: 2)),
                        shadowColor: MaterialStateProperty.all(
                            const Color(0xff000000).withOpacity(.25)),
                        fixedSize:
                            MaterialStateProperty.all(const Size(348, 50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff34AF32))),
                    icon: const Icon(Icons.location_on),
                    label: "Nearby".text.make()),
                21.heightBox,
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(MyRoute.distance, arguments: true);
                    },
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(const BorderSide(
                            color: Color(0xffD78804), width: 2)),
                        shadowColor: MaterialStateProperty.all(
                            const Color(0xff000000).withOpacity(.25)),
                        fixedSize:
                            MaterialStateProperty.all(const Size(348, 50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffFFAD32))),
                    icon: const Icon(Icons.location_searching_sharp),
                    label: "Distance".text.make()),
                21.heightBox,
                ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.of(context)
                          .pushNamed(MyRoute.payReq, arguments: true);
                    },
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(const BorderSide(
                            color: Color(0xff3E7EE7), width: 2)),
                        shadowColor: MaterialStateProperty.all(
                            const Color(0xff000000).withOpacity(.25)),
                        fixedSize:
                            MaterialStateProperty.all(const Size(348, 50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff0351D2))),
                    icon: const Icon(Icons.location_history_rounded),
                    label: "Upcoming".text.make()),
              ]),
        ),
      ),
    );
  }
}
