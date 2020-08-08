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
import Ubuntu.Components.Popups 1.3

import HangmanBackend 1.0

Page {
	id: gameView
	header: DefaultHeader {}

	property bool isLandscape: root.width > root.height

	signal resetButtons()

	HangmanBackend {
		id: backend
		onState_changed: {
			var stateIdx = getStateIndex()
			hangingState.source = "states/state" + stateIdx + ".png"
			if (backend.game_ongoing()) {
				stateLabel.text = backend.get_status().replace(/_/g, "_ ")
				if (backend.get_max_attempts() != 8) {
					stateLabel.text += "  (" + (backend.get_max_attempts() - backend.get_attempts()) + " attempts remaining)"
				}
			} else {
				var feedback = ""
				if (backend.get_attempts() < backend.get_max_attempts()) {
					feedback = i18n.tr("You win! The word was \"%1\".").arg(backend.get_secret())
				} else {
					feedback = i18n.tr("Game over. The word was \"%1\".").arg(backend.get_secret())
				}
				stateLabel.text = feedback
			}
		}
	}

	Component {
		id: inputDialog
		WordInputDialog {
			onStartGame: {
				var attempts = pageViewer.settingsPage.getAttempts()
				if (backend.new_game_with_word(word, attempts)) {
					gameView.resetButtons()
				} else {
					PopupUtils.open(wordErrorDialog)
				}
			}
		}
	}

	Component {
		id: wordErrorDialog
		ErrorDialog {
			error: i18n.tr("Word contains invalid characters")
		}
	}

	Component {
		id: gameErrorDialog
		ErrorDialog {
			error: i18n.tr("An error occurred while creating the game.")
		}
	}

	Component {
		id: emptyImportDialog
		ErrorDialog {
			error: i18n.tr("Please import a word list or use one of the provided lists.")
		}
	}

	function getStateIndex() {
		return Math.floor(backend.get_attempts() * 8 / backend.get_max_attempts())
	}

	function newGameWithWord() {
		PopupUtils.open(inputDialog)
	}

	function newGameFromWordList() {
		var attempts = pageViewer.settingsPage.getAttempts()
		var wordlist = pageViewer.settingsPage.wordlist
		if (wordlist.length == 0) {
			PopupUtils.open(emptyImportDialog)
		} else {
			if (backend.new_game_from_word_list(wordlist, attempts)) {
				gameView.resetButtons()
			} else {
				PopupUtils.open(gameErrorDialog)
			}
		}
	}

	function guess(btn) {
		if (backend.game_ongoing()) {
			backend.guess(btn.letter)
			btn.disable()
		}
	}

	Image {
		id: hangingState
		anchors {
			left: parent.left
			leftMargin: margin
			top: header.bottom
			topMargin: margin
			right: isLandscape ? parent.horizontalCenter : parent.right
			rightMargin: isLandscape ? 0 : margin
		}
		fillMode: Image.PreserveAspectFit
		source: "states/state8.png"
	}

	Label {
		id: stateLabel
		anchors {
			top: hangingState.bottom
			bottomMargin: margin
			horizontalCenter: hangingState.horizontalCenter
		}
		text: i18n.tr("No game in progress")
	}

	Column {
		id: controlCol
		anchors {
			top: (isLandscape ? header : stateLabel).bottom
			topMargin: margin
			left: isLandscape ? hangingState.right : parent.left
			right: parent.right
		}

		Repeater {
			model: [
				["A", "B", "C", "D", "E", "F", "G", "H", "I"],
				["J", "K", "L", "M", "N", "O", "P", "Q", "R"],
				["S", "T", "U", "V", "W", "X", "Y", "Z"]
			]
			Row {
				property var btnWidth: root.width / (isLandscape ? 2 : 1)  / modelData.length
				Repeater {
					model: modelData
					KeyboardButton {
						buttonText: modelData
						letter: modelData.toLowerCase()
						width: btnWidth
					}
				}
			}
		}
	}
}
