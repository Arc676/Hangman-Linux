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

PageHeader {
	id: header
	title: i18n.tr("Hangman")

	trailingActionBar {
		actions: [
			Action {
				iconName: "info"
				visible: pageViewer.depth === 1
				text: i18n.tr("About")
				onTriggered: pageViewer.push(Qt.resolvedUrl("About.qml"))
			},
			Action {
				iconName: "settings"
				visible: pageViewer.depth === 1
				text: i18n.tr("Settings")
				onTriggered: pageViewer.push(pageViewer.settingsPage)
			},
			Action {
				iconName: "add"
				visible: pageViewer.depth === 1
				text: i18n.tr("New game")
				onTriggered: gameView.newGameWithWord()
			},
			Action {
				iconName: "note-new"
				visible: pageViewer.depth === 1
				text: i18n.tr("New from word list")
				onTriggered: gameView.newGameFromWordList()
			}
		]
	}
}
