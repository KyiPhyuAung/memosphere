# MemoSphere Flutter App Specification

## Project Overview

MemoSphere is a Flutter mobile application that allows users to create, manage, store, search, and share text-based posts with optional image attachments. The app works like a simple blog, wiki note app, or lightweight social media message client.

## Purpose

The purpose of MemoSphere is to provide users with a clean and flexible mobile interface for writing personal messages, attaching images, storing them locally, and sharing them externally to other online platforms.

## Required Features

MemoSphere includes the following required features:

1. Text input for blog, wiki, or social media style messages
2. Create a new message
3. Edit an existing message
4. View one message
5. View a list of messages
6. Delete one message
7. Select and delete multiple messages
8. Search messages by text
9. Store all messages locally using SQLite
10. Attach an image from the photo gallery
11. Attach an image from the camera
12. Share one message externally with text and image
13. Light and dark mode support

## Technology Stack

- Flutter
- Dart
- SQLite
- sqflite package
- image_picker package
- share_plus package

## User Flow

1. User opens MemoSphere.
2. User views the memo list.
3. User taps New Memo.
4. User enters text.
5. User attaches an image from gallery or camera.
6. User saves the memo.
7. User views memo details.
8. User edits, deletes, searches, or shares the memo.
9. User can long press memos to select and delete multiple messages.
10. User can switch between light mode and dark mode.

## UI Design

MemoSphere uses a clean and modern card-based user interface. It includes rounded cards, soft spacing, responsive layout, search input, floating action button, and separate light and dark color themes.

## Light Mode Colors

- Primary: #2563EB
- Primary Variant: #1D4ED8
- Secondary: #14B8A6
- Secondary Variant: #0D9488
- Background: #F8FAFC
- Surface: #FFFFFF
- App Bar: #FFFFFF
- Primary Text: #0F172A
- Secondary Text: #475569
- Hint Text: #94A3B8
- Border/Divider: #E2E8F0
- Input Background: #F1F5F9
- Success: #22C55E
- Error: #EF4444
- Warning: #F59E0B

## Dark Mode Colors

- Primary: #3B82F6
- Primary Variant: #2563EB
- Secondary: #2DD4BF
- Secondary Variant: #14B8A6
- Background: #020617
- Surface: #0F172A
- App Bar: #020617
- Primary Text: #F1F5F9
- Secondary Text: #94A3B8
- Hint Text: #64748B
- Border/Divider: #1E293B
- Input Background: #0F172A
- Success: #4ADE80
- Error: #F87171
- Warning: #FBBF24

## Local Database Design

MemoSphere stores data locally using SQLite.

Database name:

```text
memosphere.db