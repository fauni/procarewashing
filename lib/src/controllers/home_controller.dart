import 'dart:io';

import 'package:procarewashing/src/models/reserva_inner.dart';
import 'package:procarewashing/src/repository/reserva_repository.dart';
import 'package:procarewashing/src/repository/servicio_repository.dart';
import 'package:procarewashing/src/repository/vehiculo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../repository/user_repository.dart' as userRepo;

class HomeController extends ControllerMVC {
  String? _platformVersion = 'Unknown';

  bool vehiculo_elegido = false;
  bool servicio_elegido = false;
  List<ReservaInner> reservasInner = [];

  HomeController() {
    obtenerVehiculo();
    obtenerServicio();
    listarReservasInnerByIdCli();
  }

  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    // if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void obtenerVehiculo() async {
    String vehiculo_json = await getVehiculo();
    if (vehiculo_json == null) {
      vehiculo_elegido = false;
    } else {
      vehiculo_elegido = true;
    }
    // print(jsonEncode(vehiculoElegido));
  }

  void obtenerServicio() async {
    String? strServicios = await getServicio();
    if (strServicios == null) {
      servicio_elegido = false;
    } else {
      servicio_elegido = true;
    }
  }

  void launchWhatsApp({
    @required String? phone,
    @required String? message,
  }) async {
    // FlutterOpenWhatsapp.sendSingleMessage(phone, message);
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message!)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message!)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  void launchMaps() async {
    String url() {
      if (Platform.isIOS) {
        return "https://www.google.com/maps/place/ProCare+Washing/@-16.5464371,-68.079098,17z/data=!3m1!4b1!4m5!3m4!1s0x915f21e62eec6d5b:0x896894a86534283d!8m2!3d-16.5464371!4d-68.0769093";
      } else {
        return "https://www.google.com/maps/place/ProCare+Washing/@-16.5464371,-68.079098,17z/data=!3m1!4b1!4m5!3m4!1s0x915f21e62eec6d5b:0x896894a86534283d!8m2!3d-16.5464371!4d-68.0769093";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

//listar reservas para mostrar
  void listarReservasInnerByIdCli() async {
    final Stream<List<ReservaInner>> stream =
        await obtenerReservasInnerXIdCli();
    stream.listen((List<ReservaInner> _reservas) {
      setState(() {
        reservasInner = _reservas;
      });
    }, onError: (a) {}, onDone: () {});
  }
}
