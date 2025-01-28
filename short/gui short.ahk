#Requires AutoHotkey v2.0

; ===== ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ =====
IniFile := "Hotkeys.ini"
Hotkeys := Map()  ; Хранит бинды

; Читаем настройки из INI-файла
LoadHotkeys()

; ===== GUI =====
MyGui := Gui("+AlwaysOnTop", "Hotkey Manager")

MyGui.SetFont("s10", "Consolas")
MyGui.Add("Text", "x10 y10 w100", "Горячая клавиша:")
HotkeyInput := MyGui.Add("Edit", "x120 y8 w80 vHotkey")
MyGui.Add("Text", "x10 y40 w100", "Программа:")
ProgramPath := MyGui.Add("Edit", "x120 y38 w250 vProgramPath")

BrowseBtn := MyGui.Add("Button", "x380 y35 w30", "...") ; Кнопка выбора файла
BindBtn := MyGui.Add("Button", "x10 y70 w100", "Добавить")
DeleteBtn := MyGui.Add("Button", "x120 y70 w100", "Удалить")

MyGui.Show("w420 h120")

; ===== ОБРАБОТЧИКИ СОБЫТИЙ =====
BrowseBtn.OnEvent("Click", SelectFile)
BindBtn.OnEvent("Click", BindHotkey)
DeleteBtn.OnEvent("Click", DeleteHotkey)
MyGui.OnEvent("Close", ExitApp)

; ===== ФУНКЦИИ =====

LoadHotkeys() {
    global Hotkeys, IniFile
    if !FileExist(IniFile)
        return
    loop read, IniFile {
        if InStr(A_LoopReadLine, "=") {
            parts := StrSplit(A_LoopReadLine, "=")
            if parts.Length = 2 {
                Hotkeys[parts[1]] := parts[2]
                Hotkey(parts[1], (*) => Run(parts[2])) ; Активируем бинды
            }
        }
    }
}

SelectFile(*) {
    file := FileSelect(3, "", "Выберите программу")
    if file
        ProgramPath.Value := file
}

BindHotkey(*) {
    global Hotkeys, IniFile, HotkeyInput, ProgramPath
    key := HotkeyInput.Value
    prog := ProgramPath.Value

    if (key = "" || prog = "") {
        MsgBox("Выберите горячую клавишу и укажите путь к программе!", "Ошибка", "OK Icon!")
        return
    }

    Hotkeys[key] := prog
    IniWrite(prog, IniFile, "Hotkeys", key)
    Hotkey(key, (*) => Run(prog)) ; Назначаем горячую клавишу
    MsgBox("Бинд добавлен: " key " → " prog, "Успешно")
}

DeleteHotkey(*) {
    global Hotkeys, IniFile, HotkeyInput
    key := HotkeyInput.Value

    if !Hotkeys.Has(key) {
        MsgBox("Такого бинда нет!", "Ошибка", "OK Icon!")
        return
    }

    IniDelete(IniFile, "Hotkeys", key)
    Hotkeys.Delete(key)
    Hotkey(key, "Off") ; Отключаем бинд
    MsgBox("Бинд удалён: " key, "Готово")
}
