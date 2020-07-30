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

import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Controls.Suru 2.2

Rectangle {
	id: kbdBtn
	property var buttonText
	property var letter
	width: btnLbl.width + 2 * margin
	height: btnLbl.height + 2 * margin
	color: Suru.backgroundColor

	Connections {
		target: gameView
		onResetButtons: kbdBtn.enable()
	}

	function enable() {
		kbdBtn.color = Suru.backgroundColor
		mouseArea.enabled = true
	}

	function disable() {
		kbdBtn.color = Suru.secondaryBackgroundColor
		mouseArea.enabled = false
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		onClicked: {
			gameView.guess(kbdBtn)
		}
	}

	Text {
		id: btnLbl
		anchors.centerIn: parent
		text: kbdBtn.buttonText
	}
}
