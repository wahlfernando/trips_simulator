# Trips Simulator

Simulação de viagens corporativas para o teste técnico da **Fretadão**.

O projeto foi desenvolvido em **Flutter** com foco em:

- Arquitetura em camadas (Data / Domain / Presentation)
- Separação clara de responsabilidades (RemoteDataSource, Repository, UseCases, BLoC)
- Mapeamento entre camadas com **mappers e DTOs**
- Consumo de API fake via **Beeceptor** (HTTP)
- Possibilidade de rodar também com uma **API local fake** (`TripRemoteDataSourceFake`) sem depender de rede

---

## Tecnologias principais

- **Flutter** 3.38.5
- **flutter_bloc** – Gerência de estado
- **go_router** – Navegação declarativa
- **http** – Requisições REST
- **flutter_dotenv** – Configuração via `.env`
- **dartz** – `Either` para tratar falhas
- **equatable** – Comparação de objetos por valor
- **bloc_test / mocktail** – Testes de BLoC e integração (sugeridos)

---

## Arquitetura

A estrutura principal está sob `lib/features/trips`:

- `data/`
  - `datasources/`
    - `trip_remote_datasource.dart`
      - `TripRemoteDataSourceHttp` – faz chamadas HTTP para a API configurada no `.env`
      - `TripRemoteDataSourceFake` – fonte de dados em memória para rodar sem rede
  - `models/`
    - `trip_model.dart` – representação dos dados vindos da API (camada de data)
  - `mappers/`
    - `trip_mapper.dart` – converte entre **Model ⇄ DTO ⇄ Entity ⇄ DB**
  - `repositories/`
    - `trip_repository_impl.dart` – implementação de `TripRepository` usando o RemoteDataSource + Mapper
- `domain/`
  - `entities/` – entidades de domínio (`Trip`)
  - `enums/` – enums de domínio (`TripStatus`)
  - `dto/` – DTO intermediário (`TripDto`)
  - `repositories/` – contratos (`TripRepository`)
  - `usecases/` – casos de uso (`GetTrips`, `GetTripDetail`)
- `presentation/`
  - `bloc/` – `TripListBloc`, `TripDetailBloc`, eventos e estados
  - `pages/` – `TripListPage`, `TripDetailPage`
  - `widgets/` – componentes de UI (`SuccessPage`, `FailurePage`, etc.)
  - `viewmodels/` – `TripsViewModel` (orquestra BLoCs, usecases, etc.)
- `trips_module.dart`
  - Módulo que monta e expõe o `TripsViewModel` com todas as dependências montadas (datasource, repository, usecases).

Outras partes importantes:

- `core/constants/base_connect/base_connect.dart`
  - Centraliza a `baseUrl` da API, carregada do `.env`.
- `trip_remote_data_source.dart` (na raiz de `lib/`)
  - Versão mais simples de DI global (mantida para compatibilidade, mas a abordagem preferida é via `TripsModule` + `TripsViewModel`).

---

## Configuração do ambiente

### 1. Pré-requisitos

- Flutter instalado (SDK compatível com `sdk: 3.38.5`)
- Dart configurado
- Android Studio / VSCode (opcional, mas recomendado)

Verifique sua instalação:

```bash
flutter doctor
```

## Versão do Flutter

- **Versão utilizada no desenvolvimento:** `Flutter 3.38.5`
- **Versão mínima recomendada:** `Flutter 3.10.4` ou qualquer versão estável **3.x** compatível com o constraint do `pubspec.yaml`:

```yaml
environment:
  sdk: 3.38.5
```
