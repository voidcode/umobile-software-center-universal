/*
    Ubuntu Mobile Software Center
    Copyright (C) 2013  Ashley Johnson

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
*/


// Import Required

import QtQuick 2.0
import Ubuntu.Components 0.1
import QtQuick.XmlListModel 2.0
import Ubuntu.Components.ListItems 0.1
import Ubuntu.Components.Popups 0.1
//import "views" as Components -> Not implemented yet


MainView {
    id: root
    width: units.gu(60)
    height: units.gu(80)

    /* My Apps - A list  on installed apps on users device. */

    Tabs {
        id: myAppsTabs
        visible: false
        anchors.fill: parent

        Tab {
            title: "My Apps"
            page: Page {
                Column {
                    anchors {
                        fill: parent
                        margins: 10
                        topMargin: title.height
                    }


                    ListModel {
                        id: softwareIn

                    }

                    XmlListModel {
                        id: myapps
                        source: "myapps.xml"
                        query: "/rss/sections/section"

                        onStatusChanged: {
                            if (status === XmlListModel.Ready) {
                                for (var i = 0; i < count; i++)
                                    softwareIn.append({"section": get(i).name, "imgsrc": get(i).imgsrc, "version": get(i).ver})
                            }
                        }



                        XmlRole { name: "name"; query: "@name/string()" }
                        XmlRole { name: "imgsrc"; query: "@imgsrc/string()" }
                        XmlRole { name: "ver"; query: "@ver/string()" }


                    }

                    ActivityIndicator {
                            anchors.right: parent.right
                            running: catergories.status === XmlListModel.Loading
                    }

                    Component {
                           id: catlistdelegate

                           Item {
                               height: 90

                               Row {
                                   Column {
                                       spacing: units.gu(4)
                                       Row {
                                           width: 100
                                           Image { source: imgsrc; width: 80; height: 80 }
                                       }
                                    }

                                   Column {
                                       width: 480
                                       spacing: units.gu(4)
                                       Row {
                                           Label { text: '<b>'+section+'</b> <br>'+version }
                                       }
                                    }
                                   Column {
                                       spacing: units.gu(4)

                                       Row {
                                           Button {
                                               width: 180
                                               color: "#dd4814"
                                               text: 'Uninstall'
                                           }
                                       }
                                    }
                               }
                           }
                       }

                    ListView {
                        id: catlist
                        anchors.fill: parent
                        anchors.margins: 5
                        visible: true
                        clip: true
                        model: softwareIn
                        delegate: catlistdelegate
                    }

                }
            }
        }
    }

    /* Apt Sources - A list  of apt-repos that the user has added */

    Tabs {
        id: sourcesTabs
        visible: false
        anchors.fill: parent

        Tab {
            title: "Apt Sources"
            page: Page {
                anchors.margins: units.gu(2)
                Column {
                    anchors {
                        fill: parent
                        margins: root.margins
                        topMargin: title.height
                    }
                    spacing: units.gu(2)
                    Row {
                        height: 50

                        CheckBox {
                            width: 50
                            height: 50
                            checked: true
                        }
                        Label {
                            text: " (UbuntuPhone) PPA updates.ubuntu.com/bounty tail/"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Row {
                        CheckBox {
                            width: 50
                            height: 50
                            checked: false
                        }
                        Label {
                            text: " (TestRepo) PPA apt.elbuntuprojects.com/mobile/"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }
        }
    }

    /* Updates - finds/installs updates */

    Tabs {
        id: updatesTabs
        visible: false
        anchors.fill: parent

        Tab {
            title: "Software Updates"
            page: Page {
                Column {
                    anchors.centerIn: parent
                    spacing: unit.gu(4)
                    Row {
                        Label {
                            text: "No updates available as of yet \n"
                        }
                    }

                    Row {
                        Button {
                            text: i18n.tr("Check for Updates")
                            color: "#772953"
                            width: 350
                        }
                    }

                }


            }
        }
    }

    /* Store front */

    Tabs {
        id: storeFront
        anchors.fill: parent

        Tab {
            id: tabMe
            title: "Software Centre"
            page: Page {
                Column {
                    anchors {
                        fill: parent
                        margins: 10
                        topMargin: title.height
                    }

                    spacing: units.gu(4)

                    Row{
                        Image {
                            source: "app-store-banner1.jpg"
                            width: avSoft.width
                            height: 320
                        }
                    }

                    Column {
                        anchors {
                            fill: parent
                            margins: 10
                            topMargin: 300
                        }
                        Row {
                            Label {
                                width: avSoft.width
                                text: "<h2>Categories</h2>"
                            }
                        }
                    }


                    ListModel {
                        id: softwareAv
                        ListElement {
                            section: "Multimedia"
                            imgsrc: "iTunes.png"
                            desc: "Audio and Video Applications"
                        }
                        ListElement {
                            section: "Internet"
                            imgsrc: "Firefox.png"
                            desc: "Facebook, Twitter and Co."
                        }
                        ListElement {
                            section: "Productivity"
                            imgsrc: "product.png"
                            desc: "Office suites and business tools"
                        }
                        ListElement {
                            section: "Education"
                            imgsrc: "Calculator.png"
                            desc: "Educations apps for people of all ages"
                        }
                        ListElement {
                            section: "Games"
                            imgsrc: "games.png"
                            desc: "Action, Arcade, RPG, Boards Games etc..."
                        }
                        ListElement {
                            section: "Ebooks and Magazines"
                            imgsrc: "CopierciN.png"
                            desc: "A collection of E-Zines and Ebooks"
                        }
                        ListElement {
                            section: "Utilities"
                            imgsrc: "Network.png"
                            desc: "Useful utilities for Ubuntu Mobile"
                        }

                    }

                    Row {

                    Component {
                           id: sectionslistdelegate

                           Item {
                               height: 90

                               Row {
                                   Column {
                                       spacing: units.gu(4)
                                       Row {
                                           width: 100
                                           Image { source: imgsrc; width: 80; height: 80 }
                                       }
                                    }

                                   Column {
                                       width: 480
                                       spacing: units.gu(4)
                                       Row {
                                           Label { text: '<b>'+section+'</b> <br>'+desc }
                                       }
                                    }
                                   Column {
                                       spacing: units.gu(4)

                                       Row {
                                           Button {
                                               width: 180
                                               color: "#dd4814"
                                               text: 'View'
                                           }
                                       }
                                    }
                               }
                           }
                       }
                    }

                    ListView {
                        id: avSoft
                        anchors.fill: parent
                        anchors.topMargin: 430
                        anchors.margins: 5
                        visible: true
                        model: softwareAv
                        delegate: sectionslistdelegate
                    }

                }
            }
        }
    }

    tools: ToolbarActions {

        Action {
            iconSource: "store.png"
            text: "Store"
            onTriggered: {
                storeFront.visible = true
                myAppsTabs.visible = false
                sourcesTabs.visible = false
                updatesTabs. visible = false
            }
        }

        Action {
            iconSource: "apps.png"
            text: "My Apps"
            onTriggered: {
                storeFront.visible = false
                myAppsTabs.visible = true
                sourcesTabs.visible = false
                updatesTabs. visible = false
            }
        }
        Action {
            iconSource: "sources.png"
            text: "Sources"
            onTriggered: {
                storeFront.visible = false
                myAppsTabs.visible = false
                sourcesTabs.visible = true
                updatesTabs. visible = false
            }
        }
        Action {
            iconSource: "update.png"
            text: "Updates"
            onTriggered: {
                storeFront.visible = false
                myAppsTabs.visible = false
                sourcesTabs.visible = false
                updatesTabs.visible = true
            }
        }

    }
}

