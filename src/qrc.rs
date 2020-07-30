qrc!(qml_resources,
	"/" {
		"qml/Main.qml",
		"qml/About.qml",
		"qml/DefaultHeader.qml",
		"qml/GamePage.qml",
		"qml/WrappingLabel.qml"
	},
);

pub fn load() {
	qml_resources();
}
