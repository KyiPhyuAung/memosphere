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
- 🌙 Dark mode (saved preference)  
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

- **Home Screen** — View and search memos  
- **Add/Edit Screen** — Create or update memos  
- **Detail Screen** — View full memo and share  
- **DatabaseHelper** — Handles SQLite operations  

---

## 💡 Key Improvements

- Added delete confirmation to prevent accidental deletion  
- Improved visibility of multi-delete feature  
- Refined UI layout and typography  
- Persisted dark mode preference  
- Separated screens for better usability  

---

## 📦 Installation

```bash
flutter pub get
flutter run