import QtQuick 2.0

QtObject {
    property QtObject model

    function init(m) {
        model = m
    }

    id: controller


    // контроллер представлений с взаимодействием с бинес-логикой на C++
    function disconnect() {
        if (!model.blocking) {
            model.blocking = true
            model.message = qsTr("Disconnection")

            // код на плюсах

            model.destroy()
            pageStack.replaceAbove(null, Qt.resolvedUrl("../pages/ConnectionPage.qml"))
        }
    }
    function reconnect() {
        if (!model.blocking) {
            model.blocking = true
            model.message = qsTr("Reconnection")
            pageStack.popAttached()

            // код на плюсах
            model.path[1] = "C:/Users/Alex/AuroraIDEProjects/SFS/qml"

            reloadData(2)
            pageStack.pushAttached(Qt.resolvedUrl("../pages/SshPage.qml")).init(model, controller)
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
            dialog.init(controller)
            dialog.accepted.connect(function() {
                model.blocking = true

                var path = model.path[dialog.type - 1]
                // код на плюсах

                reloadData(dialog.type)
                model.blocking = false
            })
        }
    }

    function initialize(type) {
        // код на плюсах
        model.path[type - 1] = "C:/Users/Alex/AuroraIDEProjects/SFS/qml/pages"

        reloadData(type)
    }
    function reloadData(type) {
        model.records[type - 1].clear()
        var arr = []
        if (model.path[type - 1].search("/") !== -1)
            arr.push({ name: "..", file: false, isChecked: false })

        // код на плюсах
        arr.push({ name: "amogus0.png", file: true, isChecked: false })
        arr.push({ name: "amogus1.png", file: true, isChecked: false })
        arr.push({ name: "life", file: false, isChecked: false })
        arr.push({ name: "amogus2.png", file: true, isChecked: false })
        arr.push({ name: "amogus3.png", file: true, isChecked: false })
        arr.push({ name: "aurora", file: false, isChecked: false })
        arr.push({ name: "amogus4.png", file: true, isChecked: false })
        arr.push({ name: "amogus5.png", file: true, isChecked: false })

        for (var i = 0; i < arr.length; i++) {
            model.records[type - 1].append(arr[i])
        }
    }
    function beforeTransfer(type, mode) {
        closeMenu()
        model.typeElements = type
        model.modeElements = mode
        model.pathElements = model.path[type - 1]
        model.elements = selected(type)
    }
    function startTransfer(type, mode) {
        closeMenu()
        model.blocking = true
        var arr
        if (mode !== 5) {
            if (model.elements.length === 0) {
                model.blocking = false
                return
            }
            arr = model.elements
            model.elements = []
        }
        else {
            arr = selected(type)
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
        reloadData(type)
        model.message = qsTr("Connected")
        model.blocking = false
    }
    function openDialog(type, mode) {
        closeMenu()
        var elem = selected(type)[0]
        var dialog = pageStack.push(Qt.resolvedUrl(mode === 6 ? "../dialogs/RenamePage.qml" : "../dialogs/PropertiesPage.qml"))
        dialog.init(controller, type, elem.file, elem.name)
        if (mode === 6)
            dialog.accepted.connect(function() {
                model.blocking = true

                var path = model.path[type - 1]
                // код на плюсах

                reloadData(type)
                model.blocking = false
            })
    }
    function openDirectory(type, name) {
        if (!model.blocking) {
            var path = model.path
            if (name === "..")
                path[type - 1] = model.path[type - 1].slice(0, model.path[type - 1].lastIndexOf("/"))
            else
                path[type - 1] = model.path[type - 1] + "/" + name

            // код на плюсах

            model.path = path
            reloadData(type)
        }
    }

    function sendRequest(request) {
        // код на плюсах
        var answer = request

        return answer
    }

    function validate(type, file, text, lastName) {
        var path = model.path[type - 1]

        // код на плюсах

        var answer = (lastName === text) ||
                (!file && text !== "life" && text !== "aurora") ||
                (file && text !== "amogus0.png" && text !== "amogus1.png" &&
                 text !== "amogus2.png" && text !== "amogus3.png" &&
                 text !== "amogus4.png" && text !== "amogus5.png")

        return answer
    }
    function getInfo(type, file, text) {
        var units = [qsTr("B"), qsTr("Kb"), qsTr("Mb"), qsTr("Gb")]
        var path = model.path[type - 1]

        // код на плюсах
        var answer = [path, "12.02.2024", "12" + " " + units[2]]

        return answer
    }

    // контроллер представлений, не требующий взаимодействия с бизнес-логикой
    function openMenu(type, x, y, row, listView, rect, menu) {
        if (!model.blocking) {
            var menuObject = menu.createObject(model.sftpPageObject)
            x = x + menuObject.width > rect.width ? x - menuObject.width : x
            y += rect.y + row.height + model.sftpPageObject.children[0].children[type].y - listView.contentY
            if (type === 2)
                y -= menuObject.height

            menuObject.x = x
            menuObject.y = y
            model.menuObject = menuObject
        }
    }
    function closeMenu() {
        if (model.menuObject !== null) {
            model.menuObject.destroy()
            model.menuObject = null
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
    function setPressed(type, flag) {
        var records = model.records[type - 1]
        for (var i = 0; i < records.count; i++) {
            var elem = records.get(i)
            if (elem.isChecked !== flag) {
                elem.isChecked = flag
                records.set(i, elem)
            }
        }
    }
    function setPressed2(type, flag, isChecked) {
        var records = model.records[type - 1]
        if (records.get(0).name !== "..")
            return
        var allTrue = true
        for (var i = 1; i < records.count; i++) {
            var elem = records.get(i)
            if (flag && elem.isChecked !== isChecked) {
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

    function getLabel(type, file, text, lastName) {
        if (text.length === 0)
            return qsTr("Field is empty")
        else if (!validate(type, file, text, lastName))
            return (file ? qsTr("File") : qsTr("Folder")) + " " + qsTr("with the same name already exists")
        else
            return ""
    }
}
