import 'examen.dart';
import 'package:flutter/material.dart';

class ExamenDetailWidget extends StatelessWidget {
  final Examen examen;
  final ValueChanged<Examen> examenSeleccionado;

  const ExamenDetailWidget({
    Key key,
    @required this.examen,
    @required this.examenSeleccionado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => examenSeleccionado(examen),
        child: Container(
          margin: EdgeInsets.only(right: 15),
          padding: EdgeInsets.all(12),
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            color: Colors.greenAccent.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color: Colors.limeAccent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Resolver",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                child: Text(
                  examen.titulo,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildImage() => Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
      );
}
