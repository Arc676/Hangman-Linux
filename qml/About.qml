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
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
	id: aboutPage
	header: DefaultHeader {}

	ScrollView {
		id: scroll
		anchors {
			top: header.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
		}

		Column {
			width: scroll.width
			spacing: margin

			WrappingLabel {
				text: "Hangman - " + i18n.tr("written by Arc676/Alessandro Vinciguerra. Project available under") + " GPLv3. Copyright 2020 Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>"
			}

			WrappingLabel {
				text: i18n.tr("This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation (version 3).")
			}

			WrappingLabel {
				text: i18n.tr("This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.")
			}

			WrappingLabel {
				text: i18n.tr("For the full license text, visit the <a href='https://github.com/Arc676/Hangman-Linux'>repository</a> or the <a href='http://www.gnu.org/licenses/'>GNU licenses page</a>")
			}

			WrappingLabel {
				text: i18n.tr("<a href='https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode'>CC BY-NC-SA 4.0</a> Assets")
				textSize: Label.Large
			}

			WrappingLabel {
				text: i18n.tr("Application icon and hangman states adapted from <a href='https://www.flaticon.com/free-icon/hangman-game_2241186?term=hangman&page=1&position=6'>this image</a> by <a href='https://www.flaticon.com/authors/smalllikeart'>smalllikeart</a> on <a href='https://www.flaticon.com/'>flaticon</a>. Modifications by Arc676/Alessandro Vinciguerra.")
			}

			WrappingLabel {
				text: i18n.tr("Word Lists")
				textSize: Label.Large
			}

			WrappingLabel {
				text: i18n.tr("US English word list <a href='http://wordlist.aspell.net/12dicts/'>2of12</a> compiled by Alan Beale and released into the public domain.")
			}
		}
	}
}
