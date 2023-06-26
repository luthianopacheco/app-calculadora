import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        fontFamily: 'NunitoSans-ExtraLight',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String numero = '0';
  String operacao = '';
  double n1 = 0;
  List<Color> cor = [
    /*LARANJA*/ const Color.fromARGB(255, 240, 166, 28),
    /*CINZA ESCURO*/ const Color.fromARGB(255, 34, 34, 34),
    /*CINZA CLARO*/ Colors.grey,
    /*PRETO*/ Colors.black,
    /*BRANCO*/ Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Column(
        children: [
          //VISOR ↓↓↓↓
          //Tentei fazer como o do Iphone que desliza o dedo no visor e apaga, porém no Iphone só apaga
          //deslizando o dedo na horizontal e esse comando faz deslizando para qualquer lado
          GestureDetector(
              onTapCancel: () {
                setState(() {
                  if (numero.isNotEmpty && numero != '0') {
                    numero = numero.substring(0, numero.length - 1);
                  }
                  if (numero.isEmpty) {
                    numero = '0';
                  }
                });
              },
              child: Container(
                color: Colors.black,
                width: 450,
                height: 220,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    numero,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 90,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              )),

          //BOTÕES ↓↓↓
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              botao('C', cor[2], cor[3]),
              botao('+/-', cor[2], cor[3]),
              botao('%', cor[2], cor[3]),
              botao('÷', cor[0], cor[4]),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              botao('7', cor[1], cor[4]),
              botao('8', cor[1], cor[4]),
              botao('9', cor[1], cor[4]),
              botao('×', cor[0], cor[4]),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              botao('4', cor[1], cor[4]),
              botao('5', cor[1], cor[4]),
              botao('6', cor[1], cor[4]),
              botao('–', cor[0], cor[4]),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              botao('1', cor[1], cor[4]),
              botao('2', cor[1], cor[4]),
              botao('3', cor[1], cor[4]),
              botao('+', cor[0], cor[4]),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              zero('0'),
              botao(',', cor[1], cor[4]),
              botao('=', cor[0], cor[4]),
            ],
          )
        ],
      ),
    )); // This trailing comma makes auto-formatting nicer for build methods.
  }

//BOTÕES ↓↓↓

  Widget botao(String btnNome, Color btnCor, Color txtCor) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          calcular(btnNome);
        },
        // ignore: sort_child_properties_last
        child: Text(
          btnNome,
          style: TextStyle(
              fontSize: 35, color: txtCor, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
          backgroundColor: MaterialStateProperty.all(btnCor),
        ),
      ),
    );
  }

  Widget zero(String btnNome) {
    return SizedBox(
      width: 178,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          calcular(btnNome);
        },
        // ignore: sort_child_properties_last
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '   $btnNome',
            style: const TextStyle(fontSize: 35, color: Colors.white),
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 34, 34, 34)),
        ),
      ),
    );
  }

  //LÓGICA ↓↓↓
  void calcular(String btnNome) {
    switch (btnNome) {
      case 'C':
        setState(() {
          numero = '0';
          n1 = 0;
        });
        break;
      case '0':
        numeroSetState(btnNome);
        break;
      case '1':
        numeroSetState(btnNome);
        break;
      case '2':
        numeroSetState(btnNome);
        break;
      case '3':
        numeroSetState(btnNome);
        break;
      case '4':
        numeroSetState(btnNome);
        break;
      case '5':
        numeroSetState(btnNome);
        break;
      case '6':
        numeroSetState(btnNome);
        break;
      case '7':
        numeroSetState(btnNome);
        break;
      case '8':
        numeroSetState(btnNome);
        break;
      case '9':
        numeroSetState(btnNome);
        break;
      case ',':
        setState(() {
          if (numero.length < 7) {
            if (!numero.contains(',')) {
              numero += btnNome;
            }
          }
        });

      //OPERAÇÕES ↓↓↓
      case '+':
        operSetState(btnNome);
        break;
      case '–':
        operSetState(btnNome);
        break;
      case '×':
        operSetState(btnNome);
        break;
      case '÷':
        operSetState(btnNome);
        break;

      case '=':
        double resultado = 0;
        if (operacao == '+') {
          resultado = n1 + double.parse(numero.replaceAll(',', '.'));
          calcSetState(resultado);
        }

        if (operacao == '–') {
          resultado = n1 - double.parse(numero.replaceAll(',', '.'));
          calcSetState(resultado);
        }

        if (operacao == '×') {
          resultado = n1 * double.parse(numero);
          calcSetState(resultado);
        }

        if (operacao == '÷') {
          if (double.parse(numero) * 1 == 0) {
            numero.toString();
            setState(() {
              numero = 'error';
            });
          } else {
            resultado = n1 / double.parse(numero);
            calcSetState(resultado);
          }
        }

      //OPERAÇÕES DE PORCENTAGEM E +/-
      case '%':
        double resultado = 0;
        if (operacao == '+') {
          resultado = (n1 * double.parse(numero)) / 100 + n1;
        }

        if (operacao == '–') {
          resultado = n1 - ((n1 * double.parse(numero)) / 100);
        }

        if (operacao == '×') {
          resultado = n1 * double.parse(numero) / 100;
        }

        calcSetState(resultado);
        break;

      case '+/-':
        double resultado = 0;
        resultado = double.parse(numero.replaceAll(',', '.')) * -1;

        calcSetState(resultado);
        break;
    }
  }

  //MÉTODOS ↓↓↓

  void operSetState(String btnNome) {
    operacao = btnNome;

    n1 = double.parse(numero.replaceAll(',', '.'));
    numero = '0';
  }

  void calcSetState(double resultado) {
    String resultString = resultado.toString();
    List<String> partes = resultString.split('.');

    if (int.parse(partes[1]) * 1 == 0) {
      setState(() {
        numero = int.parse(partes[0]).toString().replaceAll('.', ',');
      });
    } else {
      setState(() {
        numero = resultado.toString().replaceAll('.', ',');
      });
    }
  }

  void numeroSetState(String btnNome) {
    setState(() {
      if (numero.length < 7) {
        numero += btnNome;
        if (!numero.contains(',')) {
          int numeroInt = int.parse(numero);
          numero = numeroInt.toString();
        }
      }
    });
  }
}
