docker-machine env --shell cmd default
@FOR /f "tokens=*" %%i IN ('docker-machine.exe env --shell cmd default') DO @%%i
docker run -d -p 4445:4444 selenium/standalone-firefox:2.53.0
