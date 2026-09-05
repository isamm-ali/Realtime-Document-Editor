# Real-Time Document Editor

A Google Docs-style document editor built from scratch with Flutter, Node.js, MongoDB and Socket.IO.

![Document Editor](https://raw.githubusercontent.com/isamm-ali/Realtime-Document-Editor/main/images/image1.png)
<img width="510" height="912" alt="Screenshot 2026-09-05 124004" src="https://github.com/user-attachments/assets/3d936e86-2e04-4835-a755-516db7d5aba8" />
<img width="536" height="948" alt="Screenshot 2026-09-05 123859" src="https://github.com/user-attachments/assets/e78d6c0d-a5e7-4691-9d1d-89e65e25d088" />
<img width="533" height="927" alt="Screenshot 2026-09-05 123631" src="https://github.com/user-attachments/assets/4fb127de-e067-4fa5-a4f6-c4871504e86d" />
<img width="532" height="952" alt="Screenshot 2026-09-05 123555" src="https://github.com/user-attachments/assets/e82d3247-f8f4-4c6e-9cad-68c45468e7e3" />

## DEMO
https://github.com/user-attachments/assets/aaee8f68-eb44-41eb-8f40-b8dc74b9a495

The project started as a way to learn how a collaborative editor actually works beyond the UI. It now has authentication, document storage, a rich text editor, real-time document updates and automatic saving.

## What it does
* Create and edit documents
* Rename documents
* Store documents in MongoDB
* User authentication with JWT
* Password hashing with bcrypt
* Rich text editing with Flutter Quill
* Real-time document updates with Socket.IO
* Document-specific Socket.IO rooms
* Automatic document saving
* Cross-platform Flutter frontend

## Tech stack

### Frontend
* Flutter
* Dart
* Riverpod
* Flutter Quill
* Socket.IO Client
* Routemaster

### Backend
* Node.js
* Express
* MongoDB
* Mongoose
* Socket.IO
* JWT
* bcrypt

## Project structure

```text
Realtime-Document-Editor/

├── backend/
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── middlewares/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── socket/
│   │   ├── app.js
│   │   └── server.js
│   └── package.json
│
└── frontend/
    ├── lib/
    │   ├── clients/
    │   ├── models/
    │   ├── providers/
    │   ├── repositories/
    │   ├── screens/
    │   ├── services/
    │   └── main.dart
    └── pubspec.yaml
```

## How real-time editing works

Each document gets its own Socket.IO room. When a user makes a change in Quill, the frontend sends the change to the server. The server broadcasts it to the other clients currently editing the same document.

The document is also periodically saved back to MongoDB, so the latest content is persisted instead of only existing in the active Socket.IO session.

## Getting started

### 1. Clone the repo
```bash
git clone https://github.com/isamm-ali/Realtime-Document-Editor.git
cd Realtime-Document-Editor
```

### 2. Start the backend
```bash
cd backend
npm install
```

Create a `.env` file in `backend/`:
```env
PORT=5000
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret
```

Then run:
```bash
npm start
```

### 3. Run the Flutter app
From the `frontend/` directory:
```bash
flutter pub get
flutter run
```

The current Socket.IO client is configured to connect to `http://localhost:5000`, so update the host in `frontend/lib/clients/socket_client.dart` when running the app against a remote backend or a physical device.

## Current status
This is a working version of the core editor rather than a finished Google Docs clone. The main document flow and real-time editing pipeline are implemented, while features such as the actual sharing/invite flow are still being built.

## Why I built it
I wanted to understand what sits behind a collaborative editor instead of only building a text editor UI. The project covers authentication, REST APIs, database persistence, Flutter state management and WebSocket-based synchronization in one codebase.

## License
No license has been added yet.
