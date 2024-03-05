# SFTP/SSH client application

## Description

Using this application, the user can connect to a remote server,
execute commands using ssh and send/receive files using sftp

## Project structure

The project has a common structure
of an application based on C++ and QML for Aurora OS.

* **[QT.razrabotchiki.SFS.pro](QT.razrabotchiki.SFS.pro)** file
  describes the project structure for the qmake build system.
* **[icons](icons)** directory contains application icons for different screen resolutions.
* **[qml](qml)** directory contains the QML source code and the UI resources.
  * **[cover](qml/cover)** directory contains the application cover implementations.
  * **[icons](qml/icons)** directory contains the custom UI icons.
  * **[pages](qml/pages)** directory contains the application pages.
  * **[SFS.qml](qml/SFS.qml)** file
    provides the application window implementation.
* **[rpm](rpm)** directory contains the rpm-package build settings.
  **[QT.razrabotchiki.SFS.spec](rpm/QT.razrabotchiki.SFS.spec)** file is used by rpmbuild tool.
  It is generated from **[QT.razrabotchiki.SFS.yaml](rpm/QT.razrabotchiki.SFS.yaml)** file.
* **[src](src)** directory contains the C++ source code.
  * **[main.cpp](src/main.cpp)** file is the application entry point.
* **[translations](translations)** directory contains the UI translation files.
* **[QT.razrabotchiki.SFS.desktop](QT.razrabotchiki.SFS.desktop)** file
  defines the display and parameters for launching the application.
