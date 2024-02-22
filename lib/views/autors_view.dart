import 'package:flutter/material.dart';
import 'package:weather_app/utils/custom_colors.dart';

class AuthorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('https://unl.edu.ec/sites/default/files/inline-images/logogris_0.png'), // Reemplaza con la URL correcta
              ),
            ),
          ),

          SizedBox(height: 10),

          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white, // Cambia al color de fondo deseado
            child: Text(
              'PROYECTO INTEGRADOR DE SABERES',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0), // Margen a los lados
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0), // Bordes circulares
              color: CustomColors.secondGradientColor, // Cambia al color de fondo deseado
            ),
            child: Text(
              'Proyecto integrador de saberes\nEco clima Tracker',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Lista de nombres
          Expanded(child:
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Realizado por:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _buildAuthorRow('Jhair Agila'),
                _buildAuthorRow('Viviana Calva'),
                _buildAuthorRow('Thais Cartuche'),
                _buildAuthorRow('Dalton Maza'),
                _buildAuthorRow('Daniel Ortega'),
              ],
            )
          )
          )

        ],
      ),
    );
  }
  Widget _buildAuthorRow(String authorName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.person, size: 24.0),
          SizedBox(width: 8.0),
          Text(authorName),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AuthorsView(),
  ));
}
