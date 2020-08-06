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

#[macro_use]
extern crate cstr;
#[macro_use]
extern crate cpp;
#[macro_use]
extern crate qmetaobject;

use qmetaobject::*;

use std::path::Path;
use std::env;
use std::path::PathBuf;

use hangman::hangman::Hangman;

use gettextrs::{bindtextdomain, textdomain};

mod qrc;

#[derive(QObject,Default)]
struct HangmanBackend {
	base: qt_base_class!(trait QObject),
	game: Option<Hangman>,
	new_game_with_word: qt_method!(fn new_game_with_word(&mut self, secret_word: String, max_attempts: u32) -> bool {
		match Hangman::new(secret_word, max_attempts) {
			Ok(game) => {
				self.game = Some(game);
				self.state_changed();
				true
			},
			Err(_) => false
		}
	}),
	new_game_from_word_list: qt_method!(fn new_game_from_word_list(&mut self, list: String, max_attempts: u32) -> bool {
		match Hangman::new_from_word_list(Path::new(&list), max_attempts) {
			Ok(game) => {
				self.game = Some(game);
				self.state_changed();
				true
			},
			Err(_) => false
		}
	}),
	get_attempts: qt_method!(fn get_attempts(&self) -> u32 {
		match &self.game {
			Some(game) => game.get_attempts(),
			None => 8
		}
	}),
	get_max_attempts: qt_method!(fn get_max_attempts(&self) -> u32 {
		match &self.game {
			Some(game) => game.get_max_attempts(),
			None => 8
		}
	}),
	guess: qt_method!(fn guess(&mut self, guess: String) {
		match &mut self.game {
			Some(game) => {
				game.handle_guess(guess).expect("Invalid guess");
				self.state_changed();
			},
			None => {}
		}
	}),
	state_changed: qt_signal!(),
	get_status: qt_method!(fn get_status(&self) -> QString {
		match &self.game {
			Some(game) => game.get_current_status().to_string().into(),
			None => "".to_string().into()
		}
	}),
	get_secret: qt_method!(fn get_secret(&self) -> QString {
		match &self.game {
			Some(game) => game.get_secret().into(),
			None => "".to_string().into()
		}
	}),
	game_ongoing: qt_method!(fn game_ongoing(&self) -> bool {
		match &self.game {
			Some(game) => game.game_ongoing(),
			None => false
		}
	})
}

fn init_gettext() {
	let domain = "hangman.arc676";
	textdomain(domain);

	let app_dir = env::var("APP_DIR").expect("Failed to read the APP_DIR environment variable");

	let mut app_dir_path = PathBuf::from(app_dir);
	if !app_dir_path.is_absolute() {
		app_dir_path = PathBuf::from("/usr");
	}

	let path = app_dir_path.join("share/locale");

	bindtextdomain(domain, path.to_str().unwrap());
}

fn main() {
	init_gettext();
	unsafe {
		cpp! { {
			#include <QtCore/QCoreApplication>
			#include <QtCore/QString>
		}}
		cpp!{[]{
			QCoreApplication::setApplicationName(QStringLiteral("hangman.arc676"));
		}}
	}
	QQuickStyle::set_style("Suru");
	qrc::load();
	qml_register_type::<HangmanBackend>(cstr!("HangmanBackend"), 1, 0, cstr!("HangmanBackend"));
	let mut engine = QmlEngine::new();
	engine.load_file("qrc:/qml/Main.qml".into());
	engine.exec();
}
