
# Calculadora de Calorias


###Calculadora de Calorias

Este aplicativo Flutter calcula a quantidade diária recomendada de calorias com base no perfil físico do usuário, nível de atividade física e objetivo (perda ou ganho de peso). Além disso, exibe artigos relacionados ao objetivo do usuário e salva os cálculos localmente.

## Funcionalidades

- **Cálculo de Calorias**: Baseado na fórmula de **Harris-Benedict**, ajustada para perda ou ganho de peso.
- **Exibição de Artigos Relacionados**: Lista de artigos relevantes com base no objetivo (perda ou ganho de peso).
- **Armazenamento Local**: O último cálculo de calorias é salvo localmente e recuperado ao reabrir o app.
- **Interface Simples e Responsiva**: Usabilidade clara e intuitiva em dispositivos móveis (Android e iOS).

## Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Flutter SDK**
- Um emulador Android/iOS ou um dispositivo físico
- Um editor de código como **Android Studio** ou **VSCode**

## Instalação

1. Clone o repositório:


   git clone <https://github.com/Vitu26/calculadora_calorias>
   cd calculo_calorias
Instale as dependências:




flutter pub get
Conecte um emulador ou dispositivo físico e execute o app:




flutter run
Estrutura do Projeto

calculo_calorias/
├── lib/
│   ├── components/        # Componentes reutilizáveis (botões, campos de texto)
│   ├── models/            # Modelos de dados (UserProfile, Article)
│   ├── screens/           # Telas principais do app (InputScreen, ResultScreen)
│   ├── services/          # Lógica de chamadas API e cache local
│   ├── main.dart          # Ponto de entrada do app
├── assets/                # Imagens e ícones
├── pubspec.yaml           # Configurações e dependências do Flutter
└── README.md              # Documentação do projeto
Uso
1. Tela de Entrada (InputScreen)
Insira seu peso, altura, idade, gênero, nível de atividade física e objetivo (perda ou ganho de peso).
Clique no botão Calcular para ver a quantidade recomendada de calorias.
2. Tela de Resultado (ResultScreen)
Exibe o cálculo de calorias e uma lista de artigos relacionados ao seu objetivo.
Clique em qualquer artigo para lê-lo em detalhes.
3. Armazenamento Local
O último cálculo é salvo automaticamente no dispositivo. Quando o app é reaberto, se houver um cálculo salvo, o app exibirá diretamente a tela de resultados.
4. Splash Screen
Verifica se há cálculos salvos no cache ao iniciar o app.
Exemplo de Uso
Entrada de Dados:
Preencha seus dados como peso, altura, idade, etc.
Escolha seu objetivo (perda ou ganho de peso) e nível de atividade física.
Cálculo:
O app calcula as calorias diárias recomendadas e exibe o resultado na próxima tela.
Artigos Relacionados:
Veja artigos que podem ajudá-lo a alcançar seu objetivo, seja perder peso ou ganhar massa.
Dependências Principais
flutter: SDK principal para desenvolvimento mobile.
cached_network_image: Usado para carregar e salvar imagens da internet de forma eficiente.
shared_preferences: Armazenamento local para salvar o último cálculo.
intl: Manipulação de datas.
http: Realiza chamadas API para buscar artigos.




Contribuindo
Faça um fork do projeto.

Crie um branch para suas alterações:


git checkout -b minha-nova-feature
Commit suas alterações:


git commit -m "Minha nova feature"
Envie seu branch:


git push origin minha-nova-feature

