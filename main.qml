import QtQuick 2.0

// Przykład 1
// Zmiana stanu po kliknięciu przyciskiem myszki:
/*
Item {
    Rectangle {
        id: myRect
        width: 100; height: 100
        color: "black"

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: myRect.state == 'clicked' ? myRect.state = "" : myRect.state = 'clicked';
        }

        states: [
            State {
                name: "clicked"
                PropertyChanges { target: myRect; color: "red" }
            }
        ]
    }
}
*/


/*
// Przykład 2
// Używanie property "when" w State

Item {
    id: container
    width: 300; height: 300

    Rectangle {
        id: rect
        width: 100; height: 100
        color: "red"

        MouseArea {
           id: mouseArea
           anchors.fill: parent
        }

        states: State {
           name: "resized"; when: mouseArea.pressed
           PropertyChanges { target: rect; color: "blue"; height: container.height }
        }
    }
}
*/


// Przykład 3
// Resetowanie wartości dla property "width" używając do tego "undefined"
// Nie działa....
/*
Rectangle {
    width: 500; height: 200

    Text {
        id: myText
        width: 100
        wrapMode: Text.WordWrap
        text: "a text string that is longer than 50 pixels"

        states: State {
            name: "widerText"
            PropertyChanges { target: myText; width: undefined }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: myText.state = "widerText"
    }
}
*/


// Przykład 4
// Po kliknięciu przyciskiem myszy na Rectangle zostaje włączony stan "rotated"
// który spowoduje obrót i pozycje końcową "transformOrigin: Item.BottomRight"
// "PropertyAction" ustawia property "transformOrigin" do wartości zdefiniowanej
// w końcowym stanie Transition, dlatego Animacja rotacji zaczyna się
// z poprawną wartością property "transformOrigin"
// Animacja zostanie wykonana względem punktu "Item.BottomRight"
// Obrót względem wskazówek zegara: RotationAnimation.Counterclockwise
//
// SequentialAnimation - pozwala na wykonanie animacji jedna po drugiej
/*
Item {
    width: 400; height: 400

    Rectangle {
        id: rect
        width: 200; height: 100
        color: "red"

        states: State {
            name: "rotated"
            PropertyChanges { target: rect; rotation: 180; transformOrigin: Item.BottomRight }
        }

        transitions: Transition {
            SequentialAnimation {
                // This immediately sets the transformOrigin property to the value defined in
                // the end state of the Transition (i.e. the value defined in the
                // PropertyAction object) so that the rotation animation begins with the
                // correct transform origin.
                PropertyAction { target: rect; property: "transformOrigin" }
                RotationAnimation { duration: 1000; direction: RotationAnimation.Counterclockwise }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: rect.state = "rotated"
        }
    }
}
*/


// Przykład 5
// Prezentacja animacji RotationAnimation.
// Prostokąt obróci się względem punktu, który jest środkiem prostokąta, ponieważ domyślnie
// transformOrigin: Item.Center
// Obrót względem wskazówek zegara: RotationAnimation.Counterclockwise
/*
Item {
    width: 300; height: 300

    Rectangle {
        id: rect
        width: 150; height: 100; anchors.centerIn: parent
        color: "red"
        antialiasing: true

        states: State {
            name: "rotated"
            PropertyChanges { target: rect; rotation: 180 }
        }

        transitions: Transition {
            RotationAnimation { duration: 1000; direction: RotationAnimation.Counterclockwise }
        }
    }

    MouseArea { anchors.fill: parent; onClicked: rect.state = "rotated" }
}
*/


// Przykład 6
// Zmiana wartości dla property z "anchor" AnchorChanges
/*
Rectangle {
    id: window
    width: 120; height: 120
    color: "black"

    Rectangle { id: myRect; width: 50; height: 50; color: "red" }

    states: State {
        name: "reanchored"

        // w AnchorChanges nie mogę zmieniać np. marginesów !
        AnchorChanges {
            target: myRect
            anchors.top: window.top
            anchors.bottom: window.bottom
        }

        // Marginesy mogą być zmieniane w PropertyChanges
        PropertyChanges {
            target: myRect
            anchors.topMargin: 10
            anchors.bottomMargin: 10
        }
    }

    MouseArea { anchors.fill: parent; onClicked: window.state = "reanchored" }
}
*/


// Przykład 7
// Animacja property anchors.right dla Rectangle.
// Zostaje zanimowana pozycja Rectangle, który przejdzie z lewej strony na prawą w Item-ie
// property "easing.type:" deklaruje jak będzie wyglądać animacja
// (domyślnie Linear)
/*
Item {
    id: container
    width: 200; height: 200

    Rectangle {
        id: myRect
        width: 100; height: 100
        color: "red"
    }

    states: State {
        name: "reanchored"
        AnchorChanges { target: myRect; anchors.right: container.right }
    }

    transitions: Transition {
        // smoothly reanchor myRect and move into new position
        AnchorAnimation { duration: 1000; easing.type: Easing.InOutQuad; }
    }

    Component.onCompleted: container.state = "reanchored"
}
*/


// Przykład 8
// Prezentacja "NumberAnimation" . Animacja pomniejszenia szerokości prostokąta.
/*
Rectangle {
    width: 100; height: 100
    color: "red"

    NumberAnimation on x { to: 50; duration: 1000 }
}
*/


// Przykład 9
// Użycie "SmoothedAnimation"
// Jedne prostokąt śledzi drugi płynnie
// "Behavior on x" - animacja zadeklarowana wewnątrz Behavior zostanie wykonana, gdy
// property "x" nagle się zmieni.
/*
Rectangle {
    width: 800; height: 600
    color: "blue"

    Rectangle {
        width: 60; height: 60
        x: rect1.x - 5; y: rect1.y - 5
        color: "green"

        Behavior on x { SmoothedAnimation { velocity: 200 } }
        Behavior on y { SmoothedAnimation { velocity: 200 } }
    }

    Rectangle {
        id: rect1
        width: 50; height: 50
        color: "red"
    }

    focus: true
    Keys.onRightPressed: rect1.x = rect1.x + 100
    Keys.onLeftPressed: rect1.x = rect1.x - 100
    Keys.onUpPressed: rect1.y = rect1.y - 100
    Keys.onDownPressed: rect1.y = rect1.y + 100
}
*/


// Przykład 10
// ParallelAnimation - pozwala na wykonanie wielu animacji w tym samym czasie, zaś
// SequentialAnimation jedna po drugiej.
/*
Rectangle {
    id: rect
    width: 100; height: 100
    color: "red"

    ParallelAnimation {
        running: true
        NumberAnimation { target: rect; property: "x"; to: 50; duration: 1000 }
        NumberAnimation { target: rect; property: "y"; to: 50; duration: 1000 }
    }
}
*/


// Przykład 11
// SequentialAnimation pozwala na wykonanie wielu animacji jedna po drugiej.
/*
Rectangle {
    id: rect
    width: 100; height: 100
    color: "red"

    SequentialAnimation {
        running: true
        NumberAnimation { target: rect; property: "x"; to: 50; duration: 1000 }
        NumberAnimation { target: rect; property: "y"; to: 50; duration: 1000 }
    }
}
*/

// Przykład 12
// Przykład pokazuje użycie property "loops", czyli ile razy ma wykonać się animacja.
// Property "loops" znajduje się w obiekcie "Animation" po którym dziedziczy np. RotationAnimation
// "paused" - Zatrzymanie animacji
//
/*
Item {
    id: container
    width: 300; height: 300

    Rectangle {
        id: rect
        width: 100; height: 100; color: "green"
        RotationAnimation on rotation {
            paused: myMouse.pressed
            duration: 1000
            loops: Animation.Infinite
            from: 0
            to: 360

        }

        MouseArea { id: myMouse; anchors.fill: parent; }
    }
}
*/


// Przykład 13
// Użycie "ParentChange"
// zmiana wartości dla prostokąta określonego w "target" względem nowego "parent"-a
// Następuje tutaj zmiana "parent-a" wybranego obiektu (target)

/*
Item {
    width: 200; height: 100

    Rectangle {
        id: redRect
        width: 100; height: 100
        color: "red"
    }

    Rectangle {
        id: blueRect
        x: redRect.width
        width: 50; height: 50
        color: "blue"

        states: State {
            name: "reparented"
            ParentChange { target: blueRect; parent: redRect; x: 10; y: 10 }
        }

        MouseArea { anchors.fill: parent; onClicked: blueRect.state = "reparented" }
    }
}
*/


// Przykład 14
// Użycie "ParentAnimation"
// Animowanie obiektów typu "ParentChange"
/*
Item {
    width: 200; height: 100

    Rectangle {
        id: redRect
        width: 100; height: 100
        color: "red"
    }

    Rectangle {
        id: blueRect
        x: redRect.width
        width: 50; height: 50
        color: "blue"

        states: State {
            name: "reparented"
            ParentChange { target: blueRect; parent: redRect; x: 10; y: 10 }
        }

        transitions: Transition {
            ParentAnimation {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }
        }

        MouseArea { anchors.fill: parent; onClicked: blueRect.state = "reparented" }
    }
}
*/

// Przykład 15
// Użycie "PauseAnimation" jako pauzy pomiędzy animacjami
/*
Rectangle {
    id: rect
    width: 100; height: 100
    color: "red"

    SequentialAnimation {
        running: true
        NumberAnimation { target: rect; property: "x"; to: 50; duration: 1000 }
        PauseAnimation { duration: 1000 }
        NumberAnimation { target: rect; property: "y"; to: 50; duration: 1000 }
    }
}
*/


// Przykład 16
// Użycie "ScriptAction" do wykonania skryptu podczas animacji.

Item {
    width: 200; height: 200

    function doSomething(){
        rect.color = "blue";
    }

    Rectangle {
        id: rect
        width: 100; height: 100
        color: "red"

        SequentialAnimation {
            running: true
            NumberAnimation { target: rect; property: "x"; to: 50; duration: 1000 }
            ScriptAction { script: doSomething(); }
            NumberAnimation { target: rect; property: "y"; to: 50; duration: 1000 }
        }
    }
}


