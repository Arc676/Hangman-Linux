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
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

ApplicationWindow {
	id: root
	objectName: 'mainView'

	width: units.gu(45)
	height: units.gu(75)
	visible: true

	property real margin: units.gu(2)

	PageStack {
		id: pageViewer
		anchors.fill: parent

		property GamePage gamePage: GamePage {
			visible: false
		}

		property SettingsPage settingsPage: SettingsPage {
			visible: false
		}

		Component.onCompleted: {
			pageViewer.clear()
			pageViewer.push(gamePage)
		}
	}
}
