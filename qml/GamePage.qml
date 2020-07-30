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

	HangmanBackend {
		id: backend
		onState_changed: {
			var stateIdx = getStateIndex()
			hangingState.source = "states/state" + stateIdx + ".png"
			stateLabel.text = backend.get_status().replace(/_/g, "_ ")
		}
	}

	Component {
		id: inputDialog
		WordInputDialog {
			onStartGame: {
				if (!backend.new_game_with_word(word, 8)) {
					PopupUtils.open(errorDialog)
				}
			}
		}
	}

	Component {
		id: errorDialog
		WordErrorDialog {}
	}

	function getStateIndex() {
		return Math.floor(backend.get_attempts() * 8 / backend.get_max_attempts())
	}

	function newGameWithWord() {
		PopupUtils.open(inputDialog)
	}

	function newGameFromWordList() {
	}

	Image {
		id: hangingState
		anchors {
			left: parent.left
			leftMargin: margin
			top: header.bottom
			topMargin: margin
			right: parent.right
			rightMargin: margin
		}
		fillMode: Image.PreserveAspectFit
		source: "states/state8.png"
	}

	Label {
		id: stateLabel
		anchors {
			top: hangingState.bottom
			bottomMargin: margin
			horizontalCenter: parent.horizontalCenter
		}
		text: i18n.tr("No game in progress")
	}
}
