@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
echo ==========================================
echo Загрузка изменений на GitHub
echo ==========================================

:: Проверка наличия Git
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ОШИБКА: Git не найден!
    pause
    exit /b 1
)

:: Проверка, находимся ли в репозитории
if not exist .git (
    echo ОШИБКА: Эта папка не является Git-репозиторием!
    echo Запустите этот файл внутри папки проекта.
    pause
    exit /b 1
)

:: Ввод комментария к коммиту (можно передать как параметр %1)
if "%~1"=="" (
    set /p commit_msg="Введите комментарий к обновлению (например, 'Обновлен дизайн'): "
) else (
    set "commit_msg=%~1"
    echo Используем сообщение из параметра: !commit_msg!
)
if "%commit_msg%"=="" set commit_msg="Автоматическое обновление"

:: Ввод имени ветки (можно передать как параметр %2)
if "%~2"=="" (
    set /p branch_name="Введите имя ветки (по умолчанию master): "
) else (
    set "branch_name=%~2"
    echo Используем ветку из параметра: !branch_name!
)
if "%branch_name%"=="" set branch_name=master

echo.
echo [1/4] Добавление файлов...
git add .

echo [2/4] Создание коммита...
git commit -m "%commit_msg%"

echo [3/4] Отправка на сервер (GitHub)...
git push origin %branch_name%

if %errorlevel% equ 0 (
    echo.
    echo ==========================================
    echo УСПЕШНО: Изменения загружены на GitHub!
    echo ==========================================
) else (
    echo.
    echo ==========================================
    echo ОШИБКА при загрузке.
    echo Возможные причины:
    echo 1. Нет прав доступа (нужен SSH ключ или логин/пароль).
    echo 2. Изменения уже были загружены кем-то другим (сделайте git pull).
    echo ==========================================
)

pause