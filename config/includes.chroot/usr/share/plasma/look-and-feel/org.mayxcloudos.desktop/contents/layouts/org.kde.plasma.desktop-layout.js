// Bố cục mặc định của mayxcloudos:
// - Hình nền mayxcloudos
// - Thanh tác vụ nổi ở giữa: nút Start (logo), các app, khay hệ thống, đồng hồ
// Nếu có lỗi, dùng bố cục mặc định của KDE để máy vẫn có thanh tác vụ.

function tryDo(fn) {
    try {
        fn();
    } catch (e) {
        // bỏ qua thuộc tính không hỗ trợ ở phiên bản Plasma này
    }
}

try {
    var desktopsArray = desktopsForActivity(currentActivity());
    for (var j = 0; j < desktopsArray.length; j++) {
        desktopsArray[j].wallpaperPlugin = "org.kde.image";
        desktopsArray[j].currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
        desktopsArray[j].writeConfig("Image", "file:///usr/share/backgrounds/mayxcloudos/wallpaper.png");
    }

    var panel = new Panel();
    panel.location = "bottom";
    panel.height = 2 * Math.floor(gridUnit * 2.6 / 2);
    tryDo(function () { panel.alignment = "center"; });
    tryDo(function () { panel.lengthMode = "fit"; });
    tryDo(function () { panel.floating = true; });

    var start = panel.addWidget("org.kde.plasma.kickoff");
    start.currentConfigGroup = ["General"];
    start.writeConfig("icon", "mayxcloudos");

    var tasks = panel.addWidget("org.kde.plasma.icontasks");
    tasks.currentConfigGroup = ["General"];
    tasks.writeConfig("launchers",
        "applications:org.kde.dolphin.desktop,applications:firefox-esr.desktop,applications:org.kde.konsole.desktop");

    panel.addWidget("org.kde.plasma.marginsseparator");
    panel.addWidget("org.kde.plasma.systemtray");
    panel.addWidget("org.kde.plasma.digitalclock");
} catch (e) {
    var existing = panels();
    for (var i = 0; i < existing.length; i++) {
        existing[i].remove();
    }
    loadTemplate("org.kde.plasma.desktop.defaultPanel");
}
