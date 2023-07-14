import QtQuick

Timer {
    id: timer
    function setTimeout(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.triggered.connect(function release() {
                timer.triggered.disconnect(cb); // This is important
                timer.triggered.disconnect(release); // This is important as well
            });
        timer.start();
    }

    function setInterval(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = true;
        timer.triggered.connect(cb);
        timer.start();
    }
}
