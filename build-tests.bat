
@echo off

call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"

if errorlevel 1 (
    echo Failed to initialize MSVC environment.
    exit /b 1
)

cmake --build build --config Release --target SmartSchedulerTest

if errorlevel 1 (
    echo Module test build failed.
    exit /b 1
)

exit /b 0
