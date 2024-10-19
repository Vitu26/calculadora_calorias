import 'package:calculo_calorias/components/custom_appbar.dart';
import 'package:calculo_calorias/components/dropdown_input.dart';
import 'package:calculo_calorias/components/text_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../components/action_button.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _idadeController = TextEditingController();

  final FocusNode _pesoFocusNode = FocusNode();
  final FocusNode _alturaFocusNode = FocusNode();
  final FocusNode _idadeFocusNode = FocusNode();

  String _genero = 'Masculino';
  String _nivelAtividade = 'Sedentário';
  String _objetivo = 'Perda de peso';

  Future<void> _salvarHistorico(String resultado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ultimo_calculo', resultado);
  }

  Future<void> _salvarCaloriasNoCache(String resultado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'resultado_calorias', resultado); // Salva o resultado das calorias
  }

  void _calcularCalorias() {
    if (_formKey.currentState!.validate()) {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text);
      int idade = int.parse(_idadeController.text);

      UserProfile perfil = UserProfile(
        peso: peso,
        altura: altura,
        idade: idade,
        genero: _genero,
        nivelAtividade: _nivelAtividade,
        objetivo: _objetivo,
      );

      double caloriasDiarias = perfil.calcularCaloriasDiarias();

      String resultado =
          'Calorias diárias recomendadas: ${caloriasDiarias.round()} kcal';

      // Salvar resultado no histórico e no cache
      _salvarHistorico(resultado);
      _salvarCaloriasNoCache(resultado); // Aqui o cache é salvo

      // Navegar para a tela de resultado
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(resultado: resultado),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Libera os recursos dos FocusNodes e TextEditingControllers
    _pesoController.dispose();
    _alturaController.dispose();
    _idadeController.dispose();
    _pesoFocusNode.dispose();
    _alturaFocusNode.dispose();
    _idadeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Utilizando MediaQuery para detectar a largura da tela
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(title: 'Calculadora de Calorias'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 3,),
              Text(
                'Preencha com suas informações para saber a quantidade diária de calorias você vai precisar!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5,),
              Text(
                'Peso (kg):',
                style: TextStyle(fontSize: screenWidth * 0.05),
              ), // Tamanho ajustado dinamicamente
              SizedBox(height: 5),
              TextInputField(
                controller: _pesoController,
                inputType: TextInputType.number,
                currentFocusNode: _pesoFocusNode,
                nextFocusNode: _alturaFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu peso';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Altura (cm):',
                style: TextStyle(fontSize: screenWidth * 0.05),
              ), // Texto ajustado
              SizedBox(height: 5),
              TextInputField(
                controller: _alturaController,
                inputType: TextInputType.number,
                currentFocusNode: _alturaFocusNode,
                nextFocusNode: _idadeFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua altura';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Idade:',
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              SizedBox(height: 5),
              TextInputField(
                controller: _idadeController,
                inputType: TextInputType.number,
                currentFocusNode: _idadeFocusNode,
                nextFocusNode: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua idade';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Gênero:',
                style: TextStyle(fontSize: screenWidth * 0.05),
              ), // Gênero com texto responsivo
              SizedBox(height: 5),
              DropdownInputField(
                value: _genero,
                items: ['Masculino', 'Feminino'],
                onChanged: (value) {
                  setState(() {
                    _genero = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Nível de atividade:',
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              SizedBox(height: 5),
              DropdownInputField(
                value: _nivelAtividade,
                items: [
                  'Sedentário',
                  'Levemente ativo',
                  'Moderadamente ativo',
                  'Muito ativo'
                ],
                onChanged: (value) {
                  setState(() {
                    _nivelAtividade = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Objetivo:',
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              SizedBox(height: 5),
              DropdownInputField(
                value: _objetivo,
                items: ['Perda de peso', 'Ganho de peso'],
                onChanged: (value) {
                  setState(() {
                    _objetivo = value!;
                  });
                },
              ),
              SizedBox(height: 30),
              ActionButton(
                text: 'Calcular',
                onPressed: _calcularCalorias,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
