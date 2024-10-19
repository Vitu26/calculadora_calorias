class UserProfile {
  final double peso;
  final double altura;
  final int idade;
  final String genero;
  final String nivelAtividade;
  final String objetivo;

  UserProfile({
    required this.peso,
    required this.altura,
    required this.idade,
    required this.genero,
    required this.nivelAtividade,
    required this.objetivo,
  });

  // Método para calcular as calorias com base na fórmula de Harris-Benedict
  double calcularCaloriasDiarias() {
    double tmb;

    // Fórmula de Harris-Benedict
    if (genero == 'Masculino') {
      tmb = 88.362 + (13.397 * peso) + (4.799 * altura) - (5.677 * idade);
    } else {
      tmb = 447.593 + (9.247 * peso) + (3.098 * altura) - (4.330 * idade);
    }

    // Fator de Atividade Física
    double fatorAtividade;
    switch (nivelAtividade) {
      case 'Sedentário':
        fatorAtividade = 1.2;
        break;
      case 'Levemente ativo':
        fatorAtividade = 1.375;
        break;
      case 'Moderadamente ativo':
        fatorAtividade = 1.55;
        break;
      case 'Muito ativo':
        fatorAtividade = 1.725;
        break;
      default:
        fatorAtividade = 1.2;
    }

    double caloriasDiarias = tmb * fatorAtividade;

    // Ajuste de Calorias de acordo com o objetivo
    if (objetivo == 'Perda de peso') {
      caloriasDiarias *= 0.8; // Reduz 20% das calorias para perda de peso
    } else if (objetivo == 'Ganho de peso') {
      caloriasDiarias *= 1.15; // Aumenta 15% das calorias para ganho de peso
    }

    return caloriasDiarias;
  }

  // Converter o perfil do usuário em um mapa para salvar localmente
  Map<String, dynamic> toMap() {
    return {
      'peso': peso,
      'altura': altura,
      'idade': idade,
      'genero': genero,
      'nivelAtividade': nivelAtividade,
      'objetivo': objetivo,
    };
  }

  // Criar um perfil de usuário a partir de um mapa (por exemplo, para restaurar do armazenamento local)
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      peso: map['peso'],
      altura: map['altura'],
      idade: map['idade'],
      genero: map['genero'],
      nivelAtividade: map['nivelAtividade'],
      objetivo: map['objetivo'],
    );
  }
}
