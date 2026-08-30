@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
echo ==========================================
echo Скрипт клонирования проекта
echo ==========================================

:: Проверка наличия Git
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ОШИБКА: Git не установлен или не добавлен в PATH!
    echo Пожалуйста, установите Git: https://git-scm.com/
    pause
    exit /b 1
)

:: Получение URL репозитория (можно передать как параметр %1)
if "%~1"=="" (
    set /p repo_url="Введите URL репозитория GitHub (или оставьте пустым для значения по умолчанию): "
) else (
    set "repo_url=%~1"
    echo Используем URL из параметра: !repo_url!
)
if "!repo_url!"=="" set "repo_url=https://github.com/Vampqwe/VampqweEngine.git"

:: Получение имени папки назначения (можно передать как параметр %2)
if "%~2"=="" (
    set /p dest_folder="Введите имя папки для клонирования (или оставьте пустым для автоматического): "
) else (
    set "dest_folder=%~2"
    echo Используем папку из параметра: !dest_folder!
)

echo.
echo Начинаю клонирование...

:: Клонирование с указанием папки назначения (если задана)
if not "!dest_folder!"=="" (
    git clone !repo_url! !dest_folder!
) else (
    git clone !repo_url!
)

if %errorlevel% equ 0 (
    echo.
    if "!dest_folder!"=="" (
        echo УСПЕШНО: Проект успешно клонирован!
    ) else (
        echo УСПЕШНО: Проект успешно клонирован в папку !dest_folder!
    )
) else (
    echo.
    echo ОШИБКА: Не удалось клонировать репозиторий.
    echo Проверьте подключение к интернету или права доступа.
)

pause