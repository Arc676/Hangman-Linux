/*
 * Copyright (C) 2020  Arc676/Alessandro Vinciguerra
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * hangman is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem

Page {
	id: settings
	header: DefaultHeader {}

	property string wordlist: "wordlists/2of12.txt"
	property string lastImportedURL: ""
	property ImportPage importView: ImportPage {
		visible: false
	}

	Connections {
		target: importView
		onImported: wordlist = lastImportedURL = url.replace("file://", "")
	}

	function getAttempts() {
		if (maxAttempts.text.length <= 0) {
			return 8
		}
		return parseInt(maxAttempts.text)
	}

	Column {
		spacing: margin
		anchors {
			top: header.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
		}

		Row {
			spacing: margin

			Label {
				text: i18n.tr("Maximum attempts")
				anchors.verticalCenter: maxAttempts.verticalCenter
			}

			TextField {
				id: maxAttempts
				inputMethodHints: Qt.ImhDigitsOnly
				text: "8"
			}
		}

		WrappingLabel {
			text: i18n.tr("(Note that the number of graphically displayable Hangman states is always 8.)")
		}

		CheckBox {
			id: useProvidedList
			text: i18n.tr("Use provided word list")
			checked: true
			onClicked: {
				if (checked) {
					settings.wordlist = listSelector.paths[listSelector.selectedIndex]
				} else {
					settings.wordlist = settings.lastImportedURL
				}
			}
		}

		ListItem.ItemSelector {
			id: listSelector
			visible: useProvidedList.checked
			anchors {
				left: parent.left
				leftMargin: margin
				right: parent.right
				rightMargin: margin
			}
			property var paths: [
				"wordlists/2of12.txt",
				"wordlists/elements.txt",
				"wordlists/countries.txt",
			]
			model: [
				"Alan Beale's US English 2of12",
				"Elements of the Periodic Table (US)",
				"Single Word Country Names (English)",
			]
			expanded: false
			onDelegateClicked: settings.wordlist = listSelector.paths[index]
		}

		Button {
			id: importBtn
			width: parent.width
			visible: !useProvidedList.checked
			text: i18n.tr("Import a newline separated word list...")
			onClicked: pageViewer.push(importView)
		}

		WrappingLabel {
			visible: !useProvidedList.checked
			text: i18n.tr("Imported file: ") + lastImportedURL.split("/").slice(-1)[0]
		}
	}
}
