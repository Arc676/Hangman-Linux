qrc!(qml_resources,
	"/" {
		"qml/states/state0.png",
		"qml/states/state1.png",
		"qml/states/state2.png",
		"qml/states/state3.png",
		"qml/states/state4.png",
		"qml/states/state5.png",
		"qml/states/state6.png",
		"qml/states/state7.png",
		"qml/states/state8.png",
		"qml/Main.qml",
		"qml/About.qml",
		"qml/SettingsPage.qml",
		"qml/ImportPage.qml",
		"qml/DefaultHeader.qml",
		"qml/GamePage.qml",
		"qml/KeyboardButton.qml",
		"qml/WordInputDialog.qml",
		"qml/ErrorDialog.qml",
		"qml/WrappingLabel.qml"
	},
);

pub fn load() {
	qml_resources();
}
