import QtQuick
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root
  moduleName: "rspurgeon.pitch-agents"

  property string outputText: ""
  property string outputMarkup: ""
  property string outputTooltip: "Pitch Agents"

  visible: outputText !== ""
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function update(raw) {
    var value = String(raw || "").trim()
    if (!value) return

    try {
      var data = JSON.parse(value)
      var text = String(data.text || "")
      outputText = text.replace(/<[^>]*>/g, "")
      outputMarkup = text
        .replace(/<span foreground="([^"]+)">/g, '<font color="$1">')
        .replace(/<\/span>/g, "</font>")
      outputTooltip = String(data.tooltip || "Pitch Agents")
    } catch (error) {
      outputText = value
      outputMarkup = value
      outputTooltip = "Pitch Agents"
    }
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.outputText
    labelVisible: false
    tooltipText: root.outputTooltip
    useActiveColor: false
    horizontalMargin: 6
    fontSize: 15

    Text {
      anchors.centerIn: parent
      text: root.outputMarkup
      textFormat: Text.StyledText
      color: root.bar ? root.bar.barForeground : "white"
      font.family: root.bar ? root.bar.fontFamily : "monospace"
      font.pixelSize: 15
      renderType: Text.NativeRendering
    }

    onPressed: function(button) {
      if (button === Qt.LeftButton && root.bar)
        root.bar.run("notify-send -u low \"Pitch Agents\" \"$(pitch agent-status)\"")
    }
  }

  Process {
    id: statusProcess
    command: ["bash", "-lc", "exec pitch waybar-status --watch"]
    running: true
    stdout: SplitParser {
      onRead: function(line) { root.update(line) }
    }
    onExited: restartTimer.restart()
  }

  Timer {
    id: restartTimer
    interval: 2000
    repeat: false
    onTriggered: statusProcess.running = true
  }
}
