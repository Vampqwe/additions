@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ==========================================
:: Скрипт настройки проекта для OpenServer
:: ==========================================

:: Получение названия проекта (можно передать как параметр %1)
if "%~1"=="" (
    :: Если параметр не передан, пробуем использовать имя текущей папки
    for %%I in (".") do set "folder_name=%%~nxI"
    set /p PROJECT_NAME="Введите название проекта (по умолчанию: !folder_name!): "
    if "!PROJECT_NAME!"=="" set "PROJECT_NAME=!folder_name!"
) else (
    set "PROJECT_NAME=%~1"
    echo Используем название проекта из параметра: !PROJECT_NAME!
)

:: Создаем папку .osp, если она еще не существует
if not exist ".osp" mkdir ".osp"

:: Делаем папку .osp скрытой (стандартная практика для OpenServer)
attrib +h ".osp"

:: Создаем файл project.ini и записываем в него конфигурацию
(
echo [!PROJECT_NAME!]
echo php_engine   = PHP-8.5
echo mysql_engine = MySQL-8.4
) > ".osp\project.ini"

echo.
echo -----------------------------------
echo  Готово! Настройки успешно созданы.
echo  Проект: !PROJECT_NAME!
echo -----------------------------------
echo.
pause