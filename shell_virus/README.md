##  SimpleShellVirus

Вирус заражает shell-скрипты через вставку в них своего кода.

### Description

Вирус просматривает все объекты в каталоге, отбрасывая те, которые не являются файлами.<br />
У каждого файла проверяется наличие в первой строке подстроки `#!/bin/bash`. Файлы без этой подстроки пропускаются.<br />
Уже заражённые файлы так же пропускаются.<br />
Когда найден файл-жертва, вирус копирует свой код в этот файл, останавливает свою работу и передаёт управление родительскому скрипту.