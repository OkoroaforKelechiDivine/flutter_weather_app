import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{
  //  Create various variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final  RxDouble _longitude = 0.0.obs;


  //  Instance for them to be called
  RxBool checkLoading () => _isLoading;
  RxDouble getLatitude () => _latitude;
  RxDouble getLongitude () => _longitude;

  @override
  void onInit() {
    if(_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async{
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

  //  return if service is not enabled
    if(!isServiceEnabled) {
      return Future.error("Location service is not enabled.");
    }

  //  status of permission request
    locationPermission = await Geolocator.checkPermission();

    if(locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission is denied.");
    }
    else if(locationPermission == LocationPermission.denied) {
    //  request a new permission
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied.");
      }
    }
  //  Getting the current location or position
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
    //  update our latitude and longitude
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isLoading.value = false;
    });
  }
}