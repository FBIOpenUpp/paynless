// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:latlong2/latlong.dart';
import 'package:paynless/res/routes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/shop.dart';

class DashboardExpanded extends StatefulWidget {
  final bool isExpanded;
  const DashboardExpanded({
    Key? key,
    required this.isExpanded,
  }) : super(key: key);

  @override
  State<DashboardExpanded> createState() => _DashboardExpandedState();
}

class _DashboardExpandedState extends State<DashboardExpanded> {
  final mapController = MapController();
  LatLng? currentLocation;

  // List<Shop> shops =
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
    Future.delayed(Duration.zero, () {
      if (widget.isExpanded) {
        final Random random = Random();
        final i = 2;

        final data = Shop(
          lat: 0.0 + (random.nextDouble() - 0.5) * 0.02,
          lng: 0.0 + (random.nextDouble() - 0.5) * 0.02,
          name: 'Store $i',
          upiId: 'store$i@upi',
          address: '123 Main St, San Francisco, CA 94110',
          phone: '555-123-4567',
          email: 'store$i@example.com',
          paymentMethods: ['UPI', 'Cash'],
          id: i.toString(),
        );
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return Container(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      data.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isThreeLine: true,
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                          ],
                        ),
                        5.heightBox,
                        Row(
                          children: [
                            for (int i = 0;
                                i < data.paymentMethods!.length;
                                i++)
                              Chip(
                                backgroundColor: Color(0xfff19a3c),
                                label: Text(
                                  data.paymentMethods![i],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        5.heightBox,
                        Text("Address: ${data.address!}"),
                      ],
                    ),
                    trailing: GFButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(MyRoute.payment);
                      },
                      color: Color(0xfff19a3c),
                      text: "Pay with FamPay",
                      textColor: Color(0xfff19a3c),
                      icon: Image.asset(
                        'assets/images/fpay.png',
                        height: 20,
                        width: 20,
                      ),
                      type: GFButtonType.outline,
                    ),
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    return Scaffold(
      body: SafeArea(
          child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          bounds:
              LatLngBounds(LatLng(29.8659, 77.8963), LatLng(29.8659, 77.8963)),
        ),
        nonRotatedChildren: [],
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.tb.paynless',
            maxNativeZoom: 19,
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
          currentLocation == null
              ? Container()
              : CircleLayer(
                  circles: [
                    CircleMarker(
                      point: currentLocation!,
                      color: Colors.green.withOpacity(0.3),
                      borderStrokeWidth: 1,
                      borderColor: Colors.red,
                      useRadiusInMeter: true,
                      radius: 300,
                    ),
                  ],
                ),
          for (int i = 0; i < 10; i++)
            currentLocation == null
                ? Container()
                : InkWell(
                    onTap: () {
                      print('tapped');
                      final data = Shop(
                        lat: currentLocation!.latitude +
                            (random.nextDouble() - 0.5) * 0.02,
                        lng: currentLocation!.longitude +
                            (random.nextDouble() - 0.5) * 0.02,
                        name: 'Store $i',
                        upiId: 'store$i@upi',
                        address: '123 Main St, San Francisco, CA 94110',
                        phone: '555-123-4567',
                        email: 'store$i@example.com',
                        paymentMethods: ['UPI', 'Cash'],
                        id: i.toString(),
                      );
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Container(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    data.name!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  isThreeLine: true,
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        children: [
                                          for (int i = 0; i < 5; i++)
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 20,
                                            ),
                                        ],
                                      ),
                                      5.heightBox,
                                      Row(
                                        children: [
                                          for (int i = 0;
                                              i < data.paymentMethods!.length;
                                              i++)
                                            Chip(
                                              backgroundColor:
                                                  Color(0xfff19a3c),
                                              label: Text(
                                                data.paymentMethods![i],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      5.heightBox,
                                      Text("Address: ${data.address!}"),
                                    ],
                                  ),
                                  trailing: GFButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(MyRoute.payment);
                                    },
                                    color: Color(0xfff19a3c),
                                    text: "Pay with FamPay",
                                    textColor: Color(0xfff19a3c),
                                    icon: Image.asset(
                                      'assets/images/fpay.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    type: GFButtonType.outline,
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                              currentLocation!.latitude +
                                  (random.nextDouble() - 0.5) * 0.02,
                              currentLocation!.longitude +
                                  (random.nextDouble() - 0.5) * 0.02),
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
                  ),
        ],
      )),
    );
  }
}
