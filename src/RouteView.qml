import QtQuick 2.0

import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 1.4

Rectangle {
    Rectangle {
        height: parent.height
        width: parent.width * 2 / 3
        anchors.left: parent.left
        anchors.top: parent.top

        RouteQuery {
            id: routeQuery
            waypoints: []
        }

        RouteModel {
            id: routeModel
            plugin: mapboxglPlugin
            query: routeQuery
            autoUpdate: true
        }

        Map {
            id: map
            anchors.fill: parent
            plugin: mapboxglPlugin
            zoomLevel: 14
            center: QtPositioning.coordinate(59.86, 17.64)

            MapItemView {
                model: routeQuery.waypoints
                delegate: MapQuickItem {
                    property int iconSize: 20
                    anchorPoint.x: iconSize / 2
                    anchorPoint.y: iconSize / 2
                    coordinate: routeQuery.waypoints[index]
                    sourceItem: Rectangle {
                        width: iconSize
                        height: iconSize
                        radius: width
                        color: "#f29200"
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    routeQuery.addWaypoint(map.toCoordinate(Qt.point(mouse.x, mouse.y)))
                }
            }
        }
    }

    Rectangle {
        height: parent.height
        width: parent.width * 1 / 3
        anchors.right: parent.right

        Text {
            text: "Routes"
        }
    }
}
