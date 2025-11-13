# App Flutter para Lista de Tarefas - Gestão Online

Aplicativo Flutter de gerenciamento de tarefas desenvolvido como teste técnico para vaga de desenvolvedor júnior. O app consome a API fake [JSONPlaceholder](https://jsonplaceholder.typicode.com/) para demonstrar CRUD completo com integração backend, cache local e funcionalidade offline.

---

## Funcionalidades

- ✅ **Listar tarefas** da API JSONPlaceholder
- ✅ **Adicionar nova tarefa** (POST fake para API)
- ✅ **Marcar como concluída** ao clicar na tarefa
- ✅ **Remover tarefa** via swipe-to-delete ou botão X
- ✅ **Cache local** com SharedPreferences (modo offline)
- ✅ **Tratamento de erros** com mensagens específicas
- ✅ **Optimistic updates** para melhor UX

---

## Como Rodar o Projeto

### **Pré-requisitos**

Certifique-se de ter instalado:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão 3.x ou superior)
- [Dart SDK](https://dart.dev/get-dart) (^3.9.2)
- Um editor de código VS Code ou Android Studio
- Emulador Android/iOS ou dispositivo físico conectado

### **Passo 1: Clone o Repositório**

### **Passo 2: Instale as Dependências**

```bash
flutter pub get
```

### **Passo 3: Execute o Aplicativo**

**No emulador/dispositivo conectado:**
```bash
flutter run
```

**No navegador Chrome (web):**
```bash
flutter run -d chrome
```

## Arquitetura

### **Estrutura de Pastas**

```
lib/
├── models/
│   └── tarefa_model.dart          # Model com serialização JSON
├── services/
│   ├── api_service.dart           # Requisições HTTP (GET/POST/PATCH/DELETE)
│   └── armazenamento_service.dart # Persistência local (SharedPreferences)
├── controllers/
│   └── tarefa_controller.dart     # Gerenciamento de estado (Provider)
├── screens/
│   └── tela_tarefas.dart          # Tela principal
├── widgets/
│   ├── badge_offline.dart         # Componente de badge offline
│   ├── banner_erro.dart           # Componente de exibição de erros
│   ├── estado_vazio.dart           # Componente de lista vazia
│   ├── input_nova_tarefa.dart     # Componente de input
│   ├── tarefa_item.dart           # Componente de item da lista
│   └── widgets.dart               #  Barrel file
└── main.dart                      # Entry point
```

### **Comunicação com API**

**Package HTTP**
- ✅ Pacote oficial do Dart para requisições HTTP
- ✅ Implementação de todos métodos REST: GET, POST, PATCH, DELETE
- ✅ Timeout configurado (10 segundos)
- ✅ Tratamento de erros com exceção customizada (`ApiException`)
- ✅ Headers apropriados (`Content-Type: application/json`)

**Estratégia de Requisições:**
```
1. Tenta API primeiro (dados frescos)
   ↓
2. Se sucesso → Salva no cache local
   ↓
3. Se falha → Carrega do cache (modo offline)
```

## Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.6.0                    # Requisições HTTP
  shared_preferences: ^2.5.3      # Persistência local
  provider: ^6.1.5                # Gerenciamento de estado

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0           # Linting e boas práticas
```

---

## Tecnologias Utilizadas

- **Flutter** 3.x
- **Dart** ^3.9.2
- **Provider** (State Management)
- **HTTP Package** (API Communication)
- **SharedPreferences** (Local Storage)
- **Material Design 3** (UI/UX)

---

## API Utilizada

**JSONPlaceholder - Fake REST API**
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoint: `/todos`
- Métodos: GET, POST, PATCH, DELETE

##  Feito por

**Filipe Gomes dos Santos**
- GitHub: [@FilipeSantos22](https://github.com/FilipeSantos22)
- LinkedIn: [(https://www.linkedin.com/in/filipe-gomes22/)]
