import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utilities/responsive_function.dart';

class CustomGoogleMap extends StatefulWidget {
  final LatLng receiverLocation;
  final String receiverAddress;
  final String phone;

  const CustomGoogleMap({
    super.key,
    required this.receiverLocation,
    required this.receiverAddress,
    required this.phone,
  });

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: widget.receiverLocation,
      zoom: 12,
    );
    // initialCameraPosition= const CameraPosition(
    //   // zoom:8,
    //     target: LatLng(26.82698675681327, 29.514760849384743)
    // );
    initMarkers();
  }

  void initMarkers() {
    markers.add(
      Marker(
        markerId: const MarkerId('Location'),
        position: widget.receiverLocation,
        infoWindow: InfoWindow(title: widget.receiverAddress),
      ),
    );
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          GoogleMap(
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
            // initMapStyle();
            },
            initialCameraPosition: initialCameraPosition,
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 15.sh,left: 2.sw,right: 2.sw),
        child: SizedBox(
          width: responsiveSize(context, 15.sw, 10.sw),
          height:  responsiveSize(context, 15.sw, 10.sw),
          child: FloatingActionButton(
            onPressed: () => _handlePhoneNumber(widget.phone, context),
            backgroundColor: Colors.greenAccent,
            child: Icon(Icons.phone,size:5.sw,),
          ),
        ),
      ),
    ) ;
  }

  void _handlePhoneNumber(String phoneNumber, BuildContext context) {
    List<String> phoneNumbers = phoneNumber.split(',');

    if (phoneNumbers.length > 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Number'.tr),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: phoneNumbers.map((number) {
                return ListTile(
                  title: Text(number
                      .trim()), // method is used to remove any leading and trailing whitespace from a string
                  onTap: () {
                    Navigator.of(context).pop();
                    _makePhoneCall(number.trim());
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    } else {
      // Call the only available number
      _makePhoneCall(phoneNumbers[0].trim());
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } else if (status.isDenied) {
      // Request permission if it's denied
      if (await Permission.phone.request().isGranted) {
        _makePhoneCall(phoneNumber); // Retry making the call
      } else {
        throw 'Phone call permission denied';
      }
    }
  }


// void initMapStyle() async {
  //   var nightMapStyle = await DefaultAssetBundle.of(context)
  //       .loadString('assets/map_style/night_map_style.js');
  //   googleMapController.setMapStyle(nightMapStyle);
  // }
}
