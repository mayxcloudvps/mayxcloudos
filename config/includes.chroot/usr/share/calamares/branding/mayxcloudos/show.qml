import QtQuick 2.0
import calamares.slideshow 1.0

Presentation {
    id: presentation

    Timer {
        interval: 7000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0A2F7A" }
                GradientStop { position: 1.0; color: "#5BB5FF" }
            }
        }
        Column {
            anchors.centerIn: parent
            width: parent.width * 0.72
            spacing: 18
            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "#FFFFFF"
                font.pixelSize: 30
                font.bold: true
                text: "Nhấp đúp file .exe là chạy"
            }
            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "#E4ECFF"
                font.pixelSize: 16
                text: "mayxcloudos chạy phần mềm Windows bằng MâyX Engine. Mỗi ứng dụng có môi trường riêng, không đụng nhau."
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#123F9E" }
                GradientStop { position: 1.0; color: "#38C6F4" }
            }
        }
        Column {
            anchors.centerIn: parent
            width: parent.width * 0.72
            spacing: 18
            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "#FFFFFF"
                font.pixelSize: 30
                font.bold: true
                text: "Gõ tiếng Việt sẵn có"
            }
            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "#E4ECFF"
                font.pixelSize: 16
                text: "Bộ gõ Unikey đã được cài sẵn, dùng được ngay sau khi đăng nhập."
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0A2F7A" }
                GradientStop { position: 1.0; color: "#2F80FF" }
            }
        }
        Column {
            anchors.centerIn: parent
            width: parent.width * 0.72
            spacing: 18
            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "#FFFFFF"
                font.pixelSize: 30
                font.bold: true
                text: "Sắp xong rồi"
            }
            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "#E4ECFF"
                font.pixelSize: 16
                text: "Sau khi cài xong, khởi động lại và đăng nhập bằng tài khoản vừa tạo."
            }
        }
    }
}
