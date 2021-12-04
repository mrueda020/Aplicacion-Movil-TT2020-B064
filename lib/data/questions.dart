import '../models/option.dart';
import '../models/question.dart';

final questions = [
  Question(
    text: 'Sistema Operativo de la empresa Apple',
    options: [
      Option(code: 'A', text: 'Linux', isCorrect: false),
      Option(code: 'B', text: 'Windows', isCorrect: false),
      Option(code: 'C', text: 'Solaris', isCorrect: false),
      Option(code: 'D', text: 'MacOS', isCorrect: true),
    ],
  ),
  Question(
    text: '¿Cuáles son los tipos de lenguaje de programación?',
    options: [
      Option(code: 'A', text: 'Estructural, Alto y Bajo', isCorrect: true),
      Option(code: 'B', text: 'Bajo y alto nivel. ', isCorrect: false),
      Option(code: 'C', text: 'SQL, SQL Server. ', isCorrect: false),
      Option(code: 'D', text: 'Lenguajes ensambladores', isCorrect: false),
    ],
  ),
  Question(
    text: 'Son nombres de lenguajes de programación orientado a objetos.',
    options: [
      Option(code: 'A', text: 'C, CSS', isCorrect: false),
      Option(code: 'B', text: 'HTML, XML', isCorrect: false),
      Option(code: 'C', text: 'JavaScript, .NET', isCorrect: false),
      Option(code: 'D', text: 'C#,Java', isCorrect: true),
    ],
  ),
  Question(
    text: 'Tipos de datos que se manejan en Programación.',
    options: [
      Option(code: 'A', text: 'Booleano, Entero', isCorrect: true),
      Option(code: 'B', text: 'Java, C++, Smalltalk', isCorrect: false),
      Option(code: 'C', text: "Phyton,dart", isCorrect: false),
      Option(code: 'D', text: "Datos programables", isCorrect: false),
    ],
  ),
  Question(
    text: 'El entorno IDE NetBeans se programa',
    options: [
      Option(code: 'A', text: 'Programas', isCorrect: false),
      Option(code: 'B', text: 'Docker', isCorrect: false),
      Option(code: 'C', text: 'Java', isCorrect: true),
      Option(code: 'D', text: 'Visual Studio', isCorrect: false),
    ],
  ),
  Question(
    text: 'Numeros binarios son',
    options: [
      Option(code: 'A', text: '1 y 2', isCorrect: false),
      Option(code: 'B', text: '3 y 4', isCorrect: false),
      Option(code: 'C', text: '0 y 1', isCorrect: true),
      Option(
        code: 'D',
        text: '10 y 11',
        isCorrect: false,
      ),
    ],
  ),
  Question(
    text: 'Framework para desarrollo de sistemas moviles',
    options: [
      Option(code: 'A', text: 'Ruby', isCorrect: false),
      Option(code: 'B', text: 'Flutter', isCorrect: false),
      Option(code: 'C', text: 'C', isCorrect: false),
      Option(code: 'D', text: 'Solaris', isCorrect: true),
    ],
  ),
];
