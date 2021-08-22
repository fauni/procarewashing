import 'dart:io';

import 'package:procarewashing/src/models/reserva_inner.dart';
import 'package:procarewashing/src/repository/reserva_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MainController extends ControllerMVC {
  List<ReservaInner> reservasInner = [];
  MainController() {
    listarReservasInnerByIdCli();
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
