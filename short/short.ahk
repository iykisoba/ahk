#Requires AutoHotkey v2.0

global savedX := 0
global savedY := 0
global togs := false

F1:: {
    global savedX, savedY, togs

    CoordMode("Mouse", "Screen")  ; Устанавливаем режим координат на экранные
    if (!togs) {
        ; Получаем позицию мыши в координатах экрана
        MouseGetPos(&savedX, &savedY)  ; Сохраняем координаты
        Send("{Ctrl down}{LWin down}{Right}{LWin up}{Ctrl up}")  ; Отправляем комбинацию клавиш Ctrl + Win + Стрелка вправо
        togs := true
    } else {
        ; Перемещаем мышь на сохраненные координаты относительно экрана
        MouseMove(savedX, savedY, 0)  ; Перемещаем мышь на сохраненные координаты
        Send("{Ctrl down}{LWin down}{Left}{LWin up}{Ctrl up}")  ; Отправляем комбинацию клавиш Ctrl + Win + Стрелка влево
        togs := false
    }
}

short(targetClass, runCommand) {
    if WinExist(targetClass) {
        WinActivate()
        WinShow()
    } else {
        Run(runCommand)
    }
}

#c::short("ahk_exe Cursor.exe", "C:\Users\iykis\AppData\Local\Programs\cursor\Cursor.exe")

#f::short("ahk_exe GitHubDesktop.exe", "C:\Users\iykis\AppData\Local\GitHubDesktop\GitHubDesktop.exe")

#2::short("Google Chrome", "C:\Program Files\Google\Chrome\Application\chrome.exe")

#w::short("ChatGPT", "C:\Users\iykis\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Приложения Chrome\ChatGPT.lnk")

#t::short("UBA - Google Sheets", "C:\Users\apetrash\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Приложения Chrome\UBA.lnk")

#x::short("ahk_exe Postman.exe", "C:\Users\iykis\AppData\Local\Postman\Postman.exe")

#q::short("Telegram.exe", "C:\Users\iykis\AppData\Roaming\Telegram Desktop\Telegram.exe")

#e::short("ahk_class CabinetWClass", "explorer C:\Users\iykis\Documents")

+#q::Run '"C:\Program Files\Google\Chrome\Application\chrome.exe"' 'https://translate.google.ru/'

#o::Run '"C:\Program Files\Google\Chrome\Application\chrome.exe"' 'https://gist.github.com/qikisoba/e7cd056ff1366e9eb1585586b915bc06'

; sc03B:: {
;     Send("^sc051")
; }

; !sc03B:: {
;     Send("^sc049")
; }

RCtrl:: {
    Send("console.log(")
}

^+Space:: {
    WinSetAlwaysOnTop(, "A")
}

!sc29:: {
    Send("``")
}

^p:: {
    ; Вводим "t1\apetrash" с задержкой после каждой клавиши
    InputText := "inno\apetrash"
    for char in StrSplit(InputText)
    {
        Send char
        Sleep 50
    }

    ; Нажимаем Tab с задержкой
    Send "{Tab}"
    Sleep 50

    ; Вводим "Artur42ru_000!" с задержкой после каждой клавиши
    ; Password := "Artur42ru_000!"
    Password := "N82922@59997e"
    for char in StrSplit(Password)
    {
        Send char
        Sleep 50
    }
}

global xpos := 0
global ypos := 0
global pos := false

Loop
{
    MouseGetPos(&xpos, &ypos)

    if (!pos) {
        MouseMove(xpos - 1, ypos)
        pos := true
    } else {
        MouseMove(xpos + 1, ypos)
        pos := false
    }

    Sleep(60000)
}