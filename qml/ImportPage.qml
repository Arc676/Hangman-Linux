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
import Ubuntu.Content 1.3

Page {
	id: importView
	header: PageHeader{
		title: i18n.tr("Import Word List From...")
	}

	property var url
	property var activeTransfer
	signal imported(string url)

	ContentPeerPicker {
		id: cpp
		objectName: "peerPicker"
		anchors.fill: parent
		contentType: ContentType.Text
		handler: ContentHandler.Source
		showTitle: false

		onPeerSelected: {
			pageStack.pop()
			importView.activeTransfer = peer.request()
			importView.activeTransfer.stateChanged.connect(function() {
				if (importView.activeTransfer === null) return

				if (importView.activeTransfer.state === ContentTransfer.InProgress) {
					importView.activeTransfer.items = importView.activeTransfer.items[0].url = url
					importView.activeTransfer.state = ContentTransfer.Charged
				} else if (importView.activeTransfer.state === ContentTransfer.Charged) {
					importView.imported(importView.activeTransfer.items[0].url)
					importView.activeTransfer = null
				}
			})
		}

		onCancelPressed: pageStack.pop()
	}

	Component {
		id: resultComponent
		ContentItem {}
	}
}
