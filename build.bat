@echo off
setlocal

:: Initialize MSVC x64 Environment (VS 2026 / v18)
call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"

:: Add CMake bin directory to PATH if not already present
set "PATH=C:\Program Files\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\CMake\bin;%PATH%"

:: Ensure build directory exists
if not exist "build" mkdir "build"

:: Clean stale CMake cache if paths changed
if exist "build\CMakeCache.txt" (
    echo Cleaning stale CMake cache...
    del /f /q "build\CMakeCache.txt"
    if exist "build\CMakeFiles" rmdir /s /q "build\CMakeFiles"
)

cd build

:: Configure and build using NMake
cmake .. -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH="C:/Qt/6.12.0/msvc2022_64"
if %errorlevel% neq 0 exit /b %errorlevel%

cmake --build .
if %errorlevel% neq 0 exit /b %errorlevel%

echo Build successful!