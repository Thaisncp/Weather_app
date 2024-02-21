import 'package:weather_app/controller/service/RespuestaGenerica.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Conexion {
  final String URL = "https://api-pis5to.fly.dev";
  static bool NO_TOKEN = false;

  Future<RespuestaGenerica> solicitudGet(String recurso, bool token) async{
    Map<String, String> _header = {'Content-Type':'application/json'};
    final String _url = URL + recurso;
    final uri = Uri.parse(_url);
    try{
      final response = await http.get(uri, headers: _header);
      if(response.statusCode != 200){
        if(response.statusCode == 404){
          return _response("Recurso no encontrado",404, []);
        }else{
          Map<dynamic, dynamic> mapa = jsonDecode(response.body);
          return _response(mapa['msg'], mapa['totalCount'], mapa['results']);
        }
        //log("Page no found");
      }else{
        Map<dynamic, dynamic> mapa = jsonDecode(response.body);
        return  _response(mapa['msg'], mapa['totalCount'], mapa['results']);
        log(response.body);
      }
      //return RespuestaGenerica();
    }catch(e){
      return _response("Error inesperado",500 , []);
    }

  }

  RespuestaGenerica _response(String msg, int totalCount, dynamic results){
    var respuesta = RespuestaGenerica();
    respuesta.msg = msg;
    respuesta.totalCount = totalCount;
    respuesta.results = results;
    return respuesta;
  }
}