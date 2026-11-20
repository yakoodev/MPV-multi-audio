# MPV Multi-Audio Track Mixer - Enhanced Audio Experience for MPV Player  
# MPV Multi-Audio Track Mixer - Улучшенный опыт работы с несколькими аудиодорожками  

---

## 🌟 Overview | Обзор  

**EN:**  
This Lua script for MPV allows **simultaneous playback of multiple audio tracks** with individual volume control and mute options. It supports both numeric keypad and standard keyboard hotkeys, features an OSD volume interface, and automatically remembers per-track volume across sessions.  

**RU:**  
Этот Lua-скрипт для MPV позволяет **одновременно воспроизводить несколько аудиодорожек** с индивидуальной регулировкой громкости и возможностью выключения звука. Поддерживаются горячие клавиши как для цифровой клавиатуры, так и для обычной, предусмотрен OSD-интерфейс для громкости и автоматическое сохранение настроек громкости между сессиями.  

---

## 🔑 Key Features | Ключевые особенности  

**EN:**  
- Per-track volume control with persistent saving  
- OSD interface with volume bars and active track indicator  
- Mute toggle per track  
- Supports both numpad and non-numpad keyboards  
- Automatic activation of all audio tracks on file load  
- On-the-fly ON/OFF toggle via `NumPad 0` (multi-audio is OFF by default)
- Off by default avoids simultaneous playback of all audio tracks returned by yt-dlp for YouTube URLs

**RU:**  
- Индивидуальная регулировка громкости с сохранением настроек  
- OSD-интерфейс с индикаторами громкости и текущей дорожки  
- Возможность отключения звука для выбранной дорожки  
- Поддержка клавиатур с NumPad и без него  
- Автоматическая активация всех аудиодорожек при загрузке файла  
- Включение/выключение на лету по клавише `NumPad 0` (по умолчанию мульти-аудио выключено)
- Выключенное по умолчанию состояние предотвращает одновременное воспроизведение всех аудиодорожек, которые yt-dlp возвращает для YouTube

---

## ⚙️ Technical Details | Технические детали  

**EN:**  
- Compatibility: MPV Player (tested on [mpv-winbuild](https://github.com/zhongfly/mpv-winbuild/releases))  
- Language: Lua  
- License: MIT  
- Status: Active stable script  

**RU:**  
- Совместимость: MPV Player (тестировалось на [mpv-winbuild](https://github.com/zhongfly/mpv-winbuild/releases))  
- Язык: Lua  
- Лицензия: MIT  
- Статус: Стабильный рабочий скрипт  

---

## 📥 Installation | Установка  

**EN (Portable version):**  
1. Download both files: [main.lua](main.lua) and [multi-audio.lua](multi-audio.lua)
2. Create the folder `<MPV.exe directory>\portable_config\scripts\multi-audio\` and place both files into it:
   - `main.lua` — controller
   - `multi-audio.lua` — original mixer (unmodified)


**RU (Portable-версия):**  
1. Скачайте оба файла: [main.lua](main.lua) и [multi-audio.lua](multi-audio.lua)
2. Создайте папку `<MPV.exe directory>\portable_config\scripts\multi-audio\` и поместите в неё оба файла:
   - `main.lua` — контроллер
   - `multi-audio.lua` — оригинальный микшер (без изменений)

**Scripts directory | Директория для скрипта**

%APPDATA%\mpv\scripts\multi-audio\
├── main.lua
└── multi-audio.lua



---

## ⌨️ Controls | Управление  

| Numpad Key | Non-Numpad Key | EN Description          | RU Описание                  |  
|------------|----------------|-------------------------|------------------------------|  
| `NumPad 8` | `Ctrl + ↑`     | Select previous track   | Предыдущая дорожка           |  
| `NumPad 2` | `Ctrl + ↓`     | Select next track       | Следующая дорожка            |  
| `NumPad 4` | `Ctrl + ←`     | Decrease volume (step)  | Уменьшить громкость (шаг)    |  
| `NumPad 6` | `Ctrl + →`     | Increase volume (step)  | Увеличить громкость (шаг)    |  
| `NumPad 5` | `Ctrl + M`     | Toggle mute             | Вкл/выкл звук                |  
| `NumPad -` | `Ctrl + -`     | Large decrease volume   | Уменьшить громкость (много)  |  
| `NumPad +` | `Ctrl + =`     | Large increase volume   | Увеличить громкость (много)  |  
| `NumPad 0` | `0`            | Toggle multi-audio ON/OFF (default: OFF) | Вкл/выкл мульти-аудио (по умолчанию: выкл.) |

---

## 📂 Example Directory Structure | Пример структуры папок  

```
MPV_portable/
├── mpv.exe
├── mpv.conf
└── portable_config/
    └── scripts/
        └── multi-audio/
            ├── main.lua
            └── multi-audio.lua
```

---

## ℹ️ Notes | Важные замечания  

**EN:**  
- Saves per-track volumes globally and restores them automatically.  
- Works out-of-the-box with no dependencies.  
- Provided under MIT license.  
- Multi-audio is OFF by default; press `NumPad 0` to enable it and `NumPad 0` again to disable it. This is the recommended way to avoid the yt-dlp/YouTube issue where all returned audio tracks play simultaneously.

**RU:**  
- Громкость дорожек сохраняется глобально и восстанавливается автоматически.  
- Работает "из коробки", без зависимостей.  
- Распространяется под лицензией MIT.  
- По умолчанию мульти-аудио выключено; `NumPad 0` включает его, повторное `NumPad 0` — выключает. Это рекомендуемый способ избежать проблемы yt-dlp/YouTube, когда одновременно играют все возвращённые аудиодорожки.

