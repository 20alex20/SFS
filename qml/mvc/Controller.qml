import QtQuick 2.0

QtObject {
    property QtObject model

    id: main_controller

    // контроллер модели
    function disconnect() {
        if (!model.blocking) {
            model.blocking = true
            model.message = qsTr("Disconnection")

            // код на плюсах

            pageStack.replaceAbove(null, Qt.resolvedUrl("MainPage.qml"))
            model.blocking = false
        }
    }
    function reconnect() {
        if (!model.blocking) {
            model.blocking = true
            model.message = qsTr("Reconnection")
            pageStack.popAttached()

            // код на плюсах
            model.path[1] = "C:/Users/Alex/AuroraIDEProjects/SFS/qml"

            pageStack.pushAttached(Qt.resolvedUrl("SshPage.qml"))
            pageStack.nextPage()
            model.message = qsTr("Connected")
            model.blocking = false
        }
    }
    function stopTransfer() {
        if (model.transfering) {
            model.message = qsTr("Canceling the operation")
            model.transfering = false
        }
    }
    function addDirectory() {
        if (!model.blocking) {
            var dialog = pageStack.push(Qt.resolvedUrl("../dialogs/AddDirectoryPage.qml"))
            dialog.init()
            dialog.accepted.connect(function() {
                model.blocking = true

                var path = model.path[dialog.type - 1]
                // код на плюсах

                if (dialog.type === 1)
                    model.reload1.data()
                else
                    model.reload2.data()
                model.blocking = false
            })
        }
    }
    function reboot(type) {
        // код на плюсах
        model.path[type - 1] = "C:/Users/Alex/AuroraIDEProjects/SFS/qml/pages"
    }

    function reloadData(type) {
        model.records[type].clear()
        var arr = []
        if (model.path[type].search("/") !== -1)
            arr.push({ name: "..", file: false, isChecked: false })

        // код на плюсах
        arr.push({ name: "amogus.png", file: true, isChecked: false })
        arr.push({ name: "life", file: false, isChecked: false })

        for (var i = 0; i < arr.length; i++) {
            model.records[type].append(arr[i])
        }
    }
    function beforeTransfer(type, mode) {
        model.closeMenu()
        model.typeElements = type
        model.modeElements = mode
        model.pathElements = model.path[type - 1]
        model.elements = selected()
    }
    function startTransfer(type, mode) {
        model.closeMenu()
        model.blocking = true
        var arr
        if (mode !== 5) {
            if (model.elements === null) {
                model.blocking = false
                return
            }
            arr = model.elements
            model.elements = null
        }
        else {
            arr = selected()
        }

        // код на плюсах
        var quantity = 41

        model.transfering = true
        for (var num = 0; num < quantity; num++) {
            if (!model.transfering) {
                // код на плюсах

                break
            }
            model.message = qsTr("Processed") + num + " " + qsTr("out of") + " " + quantity

            // код на плюсах
        }
        model.transfering = false
        model.message = qsTr("Connected")
        reloadData()
        model.blocking = false
    }
    function openDialog(type, mode) {
        closeMenu()
        var elem = selected()[0]
        var dialog = pageStack.push(Qt.resolvedUrl(mode === 6 ? "../dialogs/RenamePage.qml" : "../dialogs/PropertiesPage.qml"))
        dialog.init(type, elem.file, elem.name)
        if (mode === 6)
            dialog.accepted.connect(function() {
                model.blocking = true

                var path = model.path[type - 1]
                // код на плюсах

                reloadData()
                model.blocking = false
            })
    }
    function openDirectory(type, flag) {
        if (!model.blocking) {
            if (flag)
                model.path[type - 1] = model.path[type - 1].slice(0, model.path[type - 1].lastIndexOf("/"))
            else
                model.path[type - 1] = path + "/" + name
        }
    }

    function validate(type, file, text) {
        var path = model.path[type - 1]

        // код на плюсах
        var answer = !file || text !== "life"

        return answer
    }

    function send_request(request) {
        // код на плюсах
        return request
    }

    // контроллер представлений
    function closeMenu() {
        if (model.menuObject !== null) {
            model.menuObject.destroy()
            model.menuObject = null
            model.currentRect.z = 0
            model.currentRow.z = 1
            model.loader1_z = 0
        }
    }

    function selected(type) {
        var records = model.records[type - 1]
        var arr = [], elem, i = Number(records.get(0).name === "..")
        while (i < records.count) {
            elem = records.get(i)
            if (elem.isChecked)
                arr.push(elem)
            i++
        }
        return arr
    }
    function openMenu(type, x, y, row, rect, menu) {
        if (!model.blocking) {
            if (type === 1)
                model.loader1_z = 1
            row.z = 0
            rect.z = 2

            var menuObject = menu.createObject(rect)
            x = x + menuObject.width > rect.width ? x - menuObject.width : x
            if (type === 2)
                y -= menuObject.height
            menuObject.x = x
            menuObject.y = y

            vars.currentRow = row
            vars.currentRect = rect
            vars.menuObject = menuObject
        }
    }
    function setPressed(type) {
        var records = model.records[type - 1]
        var flag = name === ".."
        for (var i = 0; i < records.count; i++) {
            var elem = records.get(i)
            if (elem.isChecked !== flag) {
                elem.isChecked = flag
                records.set(i, elem)
            }
        }
    }
    function setPressed2(type) {
        var records = model.records[type - 1]
        if (records.get(0).name !== "..")
            return
        var allTrue = true, flag = name === ".."
        for (var i = 1; i < records.count; i++) {
            var elem = records.get(i)
            if (flag) {
                elem.isChecked = isChecked
                records.set(i, elem)
            }
            if (!elem.isChecked)
                allTrue = false
        }
        elem = records.get(0)
        elem.isChecked = allTrue
        records.set(0, elem)
    }
}
