import QtQuick
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root
  moduleName: "rspurgeon.pitch-agents"

  property string outputText: ""
  property string outputTooltip: "Pitch Agents"
  property bool outputActive: false

  visible: outputText !== ""
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function update(raw) {
    var value = String(raw || "").trim()
    if (!value) return

    try {
      var data = JSON.parse(value)
      var klass = data.class || data.alt || ""
      outputText = String(data.text || "").replace(/<[^>]*>/g, "")
      outputTooltip = String(data.tooltip || "Pitch Agents")
      outputActive = klass === "active" || klass === "running"
        || (Array.isArray(klass) && (klass.indexOf("active") !== -1 || klass.indexOf("running") !== -1))
    } catch (error) {
      outputText = value
      outputTooltip = "Pitch Agents"
      outputActive = false
    }
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.outputText
    tooltipText: root.outputTooltip
    active: root.outputActive
    horizontalMargin: 6
    fontSize: 15

    onPressed: function(button) {
      if (button === Qt.LeftButton && root.bar)
        root.bar.run("notify-send -u low \"Pitch Agents\" \"$(pitch agent-status)\"")
    }
  }

  Process {
    id: statusProcess
    command: ["bash", "-lc", "pitch waybar-status"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.update(text)
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: if (!statusProcess.running) statusProcess.running = true
  }
}
