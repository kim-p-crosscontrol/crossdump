import QtQuick 2.6
import QtQuick.Controls 2.6

Item {
    id: base
    width: displayWidth
    height: displayHeight
    visible: true

    // this will provide automatic adaption to screen size and orientation
    //property int orientationOverride: 0  // -90 , 0 , 90, 180
    //readonly property bool orientationPortrait: Math.abs(orientationOverride % 180) == 90


    Rectangle {
        id: view

        anchors.centerIn: parent

        // this will provide automatic adaption to screen size and orientation
        width: (targetARM && orientationPortrait) ? base.height : base.width;
        height: (targetARM && orientationPortrait) ? base.width : base.height;
        rotation: parent.orientationOverride


        // add your GUI code below this line

        color: "black"

        Rectangle {
            id: navBar
            width: parent.width
            height: 60
            anchors.top: parent.top
            color: "#888"
            //anchors.margins: 10

            Rectangle {
                width: childrenRect.width
                height: parent.height
                anchors.left: parent.left
                anchors.top: parent.top
                color: parent.color

                Text {
                    // TODO: Hur ger man texten horisontell padding?
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20
                    color: "#fff"
                    text: "Todo List"
                }
            }

            Rectangle {
                width: childrenRect.width
                height: parent.height
                anchors.right: parent.right
                anchors.top: parent.top
                color: parent.color

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.margins: 20
                    color: "#fff"
                    text: "Quit"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { Qt.quit(); }
                }
            }
        }

        Rectangle {
            id: todoList
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width
            height: parent.height - navBar.height

            TextField {
                id: noteInput
                placeholderText: "What to do..."
            }

            ListModel {
                id: notes

                ListElement {
                    text: "Apple"
                    done: false
                }
                ListElement {
                    text: "Orange"
                    done: false
                }
                ListElement {
                    text: "Banana"
                    done: true
                }
            }

            ListView {
                id: noteList
                width: parent.width
                height: 500
                anchors.top: noteInput.bottom
                model: notes
                delegate: Row {
                    Text {
                        text: "Text: " + text
                    }
                    Text {
                        text: "Done: " + done
                    }
                }
            }
        }
    }
}