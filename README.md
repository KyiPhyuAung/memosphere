# 🎓 MemoSphere — Mobile Memo & Blogging App

MemoSphere is a Flutter-based mobile application designed to help users create, manage, and share personal memos with a clean and modern interface.

The app works fully offline using local storage and supports image attachments and sharing features.

---

## ✨ Features

- 📝 Create, edit, and delete memos  
- 🏷️ Add title and content  
- 🖼️ Attach images (Gallery & Camera)  
- 🔍 Search memos  
- 🗑️ Single and multi-delete (with confirmation)  
- 📌 Pin important memos  
- 🔃 Sort memos (Newest / Oldest)  
- 🌙 Dark mode (saved preference)  
- 🖼️ Custom background support  
- 📤 Share memos to other apps  

---

## 🛠️ Technologies Used

- Flutter (UI Framework)  
- Dart  
- SQLite (`sqflite`)  
- Image Picker (`image_picker`)  
- Sharing (`share_plus`)  
- Google Fonts  

---

## 📱 App Structure

- **Home Screen** — View, search, sort, and manage memos  
- **Add/Edit Screen** — Create or update memos  
- **Detail Screen** — View full memo and share  
- **DatabaseHelper** — Handles SQLite operations  

---

## 💡 Key Improvements

- Added delete confirmation to prevent accidental deletion  
- Improved visibility of multi-delete feature  
- Added pinned memo system  
- Added sorting options for better organization  
- Added custom background feature  
- Persisted dark mode preference  
- Refined UI layout and typography  

---

## 📦 Installation

```bash
flutter pub get
flutter run