import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/custom_colors.dart';

class InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Center(
              child: Text(
                'Bienvenido a "Eco Clima Tracker',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Galería de fotos
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            height: 300, // Ajusta la altura según tus necesidades
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Agrega padding a los lados
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(12.0), // Ajusta el radio de los bordes
              color: CustomColors.secondGradientColor, // Puedes cambiar el color de fondo según tus preferencias
            ),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildPhoto('https://cdn-icons-png.freepik.com/512/9342/9342262.png'),
                _buildPhoto('https://cdn-icons-png.freepik.com/256/12284/12284483.png?ga=GA1.1.1304638162.1708568528&'),
                _buildPhoto('https://cdn-icons-png.freepik.com/256/7902/7902654.png?ga=GA1.1.1304638162.1708568528&'),
                _buildPhoto('https://cdn-icons-png.flaticon.com/512/2562/2562368.png'),
              ],
            ),
          ),
          // Texto informativo
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Text(
                  'Tu compañero meteorológico personalizado. Esta aplicación te sumerge en el corazón de la naturaleza, proporcionándote datos climáticos actualizados con un toque moderno y amigable. '
                  'Con "Eco Clima Tracker", siempre estarás al tanto de las condiciones meteorológicas en tiempo real. Descubre la temperatura, humedad y presión actuales, '
                  'elementos esenciales que definen el ambiente que te rodea. ¿Soleado, nublado o lluvioso? Nuestra aplicación te brinda información precisa para que puedas planificar tu día de manera inteligente'
                  'Pero eso no es todo. "Eco Clima Tracker" va más allá al ofrecerte pronósticos detallados para que puedas anticipar los cambios en el clima. Consulta las proyecciones de temperatura, humedad y presión para el día, '
                      'permitiéndote prepararte para cualquier situación climática que se avecine.',
                  style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto(String imageUrl) {
    return Container(
      width: 10000,
      height: 10000,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
          onError: (exception, stackTrace) {
            print('Error cargando la imagen: $exception');
          },
        ),
      ),
    );
  }
}
