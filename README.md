# 🚀 TaskDog — AI-Powered Service Request App

TaskDog is a full-stack mobile application that enables users to submit service requests through a guided 3-step flow. The system integrates a Flutter frontend with a FastAPI backend powered by a transformer-based NLP model that predicts urgency levels in real time.

The app demonstrates **AI-assisted decision-making, structured mobile UI flow, and full-stack integration**.

---

# 📁 Project Structure

## 🧠 Backend (FastAPI + AI)

```
backend/
│
├── main.py
├── requirements.txt
├── routes/
├── schemas/
├── services/
├── taskdog/
└── __pycache__/
```

### Description:

* `main.py` → Entry point for FastAPI server
* `routes/` → API endpoints (including `/analyze`)
* `schemas/` → Pydantic models (request/response validation)
* `services/` → AI inference logic (transformer + rules)
* `taskdog/` → Virtual environment

---

## 📱 Frontend (Flutter App)

```
frontend/
│
├── lib/
│   ├── features/
│   │   ├── models/
│   │   ├── provider/
│   │   ├── screens/
│   │   ├── services/
│   │   └── utilities/
│   └── main.dart
│
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
└── test/
```

### Description:

* `models/` → Data models (ServiceRequest)
* `provider/` → Riverpod state management
* `screens/` → UI screens (Category, Details, Summary)
* `services/` → API service layer (FastAPI communication)
* `utilities/` → Reusable UI components (buttons, chips, tiles)

---

# 📸 Screenshots

## 🟦 Category Selection Screen

<img width="396" height="834" alt="Category Screen" src="https://github.com/user-attachments/assets/8331361d-8795-4d34-982a-a318c9d27121" />

---

## ⌨️ Details Screen (Typing State + AI Analysis)

<img width="394" height="833" alt="Details Screen" src="https://github.com/user-attachments/assets/714827db-ff38-48f5-b77e-d22751eb8763" />

---

## 🤖 AI Prediction Chip

<img width="387" height="820" alt="Summary Screen" src="https://github.com/user-attachments/assets/fd38ee0b-827f-4e82-8534-c954ceecba40" />

---

## 📋 Summary Screen

<img width="389" height="831" alt="AI Chip" src="https://github.com/user-attachments/assets/e0c1fa83-e149-42a4-803b-77c79e530abe" />

---

# 🤖 AI System Overview

## Model Used

* `facebook/bart-large-mnli` (HuggingFace Transformers)
* Zero-shot classification approach (no training required)

## Functionality

The AI system:

1. Receives a service description from the mobile app
2. Classifies urgency into:

   * Routine
   * Urgent
   * Emergency
3. Returns a confidence score (0–1)
4. Optionally enhances predictions using keyword-based rules for high-risk scenarios

---

## Example

**Input:**

> "the car broke down while I was driving on the bridge"

**Output:**

```json
{
  "urgency": "Emergency",
  "confidence": 0.80
}
```

---

# 🏗️ Tech Stack

## Frontend

* Flutter
* Riverpod (state management)
* HTTP (API calls)

## Backend

* FastAPI
* Python
* HuggingFace Transformers
* PyTorch (model inference)

---

# 🔌 API Endpoint

## POST `/analyze`

### Request

```json
{
  "description": "string"
}
```

### Response

```json
{
  "urgency": "Routine | Urgent | Emergency",
  "confidence": 0.0 - 1.0
}
```

---

# ⚙️ How to Run the Project

## Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
```

Runs at:

```
http://127.0.0.1:8000
```

For Android emulator:

```
http://10.0.2.2:8000
```

---

## Frontend

```bash
cd frontend
flutter pub get
flutter run
```

---

# 🎯 Key Features (Why This Project Stands Out)

## 1. AI-Powered Decision Support

Real-time urgency prediction using transformer-based NLP.

## 2. Hybrid Intelligence

Combines:

* Zero-shot ML model
* Rule-based keyword boosting

## 3. Smooth UX Design

* Step-based flow
* Live AI feedback
* Typing indicator + animated chip states

## 4. State Management

* Riverpod ensures persistent state across screens
* Clean separation of UI and business logic

---

# 🚀 Future Improvements

* Train custom classification model for higher accuracy
* Add authentication (login/signup)
* Store requests in database (PostgreSQL / Firebase)
* Deploy backend (Render / Railway / AWS)
* Add push notifications for request updates

---

# 👤 Author

**Kwode Great Obruche**
OrgByte Builders Program — Mobile/AI Track

