# 💰 FinTrack — Personal Capital Management System

**FinTrack** — это мобильное приложение для стратегического управления личным капиталом, контроля расходов и повышения финансовой грамотности. Проект разработан в рамках программы **Tech Orda 2025/26** в **Data Group Academy** как финальная работа.

---

## 🚀 Основной функционал

*   **📊 Формирование капитала:** Отслеживание динамики накоплений в реальном времени на основе доходов и расходов.
*   **🔔 Смарт-уведомления:** Ежедневные напоминания о внесении данных для поддержания 100% точности учета.
*   **📄 PDF-Отчеты:** Генерация профессионального финансового аудита за месяц в формате PDF.
*   **🔍 Интеллектуальный поиск:** Быстрая фильтрация транзакций по категориям, датам и типам операций.
*   **🌙 Adaptive UI:** Полная поддержка Dark и Light режимов интерфейса.

---

## 🛠 Технологический стек

*   **Framework:** Flutter SDK (Dart)
*   **State Management:** BLoC (Business Logic Component)
*   **Architecture:** Clean Architecture (Data, Domain, Presentation layers)
*   **Database:** SQLite (Local storage)

---

## 🏗 Архитектура

Проект построен на принципах **Clean Architecture**, что обеспечивает тестируемость и чистоту кода:
1.  **Domain Layer:** Бизнес-логика, сущности (Entities) и Use Case-ы.
2.  **Data Layer:** Реализация репозиториев (Repository Pattern) и работа с локальной базой данных.
3.  **Presentation Layer:** UI-компоненты и логика отображения, управляемая через BLoC.

---

## 📸 Скриншоты (Screenshots)

| 1. Welcome screen | 2. Аналитика | 3. Транзакция |
| :---: | :---: | :---: |
| ![Welcome](<img width="488" height="1011" alt="Снимок экрана 2026-05-06 162812" src="https://github.com/user-attachments/assets/e3bf09a6-2969-4228-8456-b3072e7b3c57" />
) | ![Analys](<img width="512" height="1006" alt="Снимок экрана 2026-05-06 162551" src="https://github.com/user-attachments/assets/0d8144b9-9963-47fd-8cc0-c74b46bda7a8" />
) | ![Transaction](<img width="541" height="1024" alt="Снимок экрана 2026-05-06 162425" src="https://github.com/user-attachments/assets/dc52e03e-42d2-4e98-ad7b-3f247031a56c" />
) |

*(Примечание: Скриншоты доступны в папке `assets/` репозитория)*

---

## 📦 Инструкция по запуску (Setup Guide)

Для запуска проекта на вашем локальном устройстве выполните следующие шаги:

1.  **Клонируйте репозиторий:**
    ```bash
    git clone [https://github.com/Ali01-kal/FinTrack-final-project.git](https://github.com/Ali01-kal/FinTrack-final-project.git)
    ```
2.  **Перейдите в директорию проекта:**
    ```bash
    cd FinTrack-final-project
    ```
3.  **Установите все необходимые зависимости:**
    ```bash
    flutter pub get
    ```
4.  **Запустите приложение на эмуляторе или реальном устройстве:**
    ```bash
    flutter run
    ```

> **Важно:** Готовый APK-файл в release-режиме можно скачать в разделе [Releases](https://github.com/Ali01-kal/FinTrack-final-project/releases).

---
**Автор:** Ахметәли Қалыбек — Flutter Developer (Tech Orda / Data Group Academy).
