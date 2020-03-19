# SMWrap_IRIS_Docker
Запуск SMWrap MAKOVA  в Intersystems IRIS Docker


<h3>Сборка контейнера:</h3>
1) Запустить build_project.bat<br>
2) Инсталлировать классы в терминале d ##class(%%ZUser.Installer).installSmwrap()<br>

<h4>Студия</h4>
SMWrap/MStudio.exe
<h4>Плеер</h4>
SMWrap/MPlayer.exe
<h4>Классы для IRIS</h4>
SMWrap/SMWrap.xml
<h4>Запуск сервера SMWrap</h4>
d RUN^%ZMRPMD