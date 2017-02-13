//
//  JPString.swift
//  JPString
//
//  Created by デニス on 8/17/28 H.
//  Copyright © 28 Heisei Dennis Russell. All rights reserved.
//  Released under MIT License. See LICENSE for details.
//


import Foundation

/**
Library to assist in transliteration between Japanese scripts and Latin script.
*/
class JPString {

	fileprivate lazy var reading: [String] = ["a", "i", "u", "e", "o", "ka", "ki", "ku", "ke", "ko", "ga", "gi", "gu", "ge", "go", "sa", "shi", "su", "se", "so", "za", "ji", "zu", "ze", "zo", "ta", "chi", "tsu", "te", "to", "da", "ji", "zu", "de", "do", "na", "ni", "nu", "ne", "no", "ha", "hi", "fu", "he", "ho", "ba", "bi", "bu", "be", "bo", "pa", "pi", "pu", "pe", "po", "ma", "mi", "mu", "me", "mo", "ya", "", "yu", "", "yo", "ra", "ri", "ru", "re", "ro", "wa", "wi", "", "we", "wo", "n", "", "", "", "", "cha", "chi", "chu", "chu", "cho", "sha", "shi", "shu", "she", "sho", "ja", "ji", "ju", "je", "jo", "kya", "kyi", "kyu", "kye", "kyo", "nya", "nyi", "nyu", "nye", "nyo", "hya", "hyi", "hyu", "hye", "hyo", "mya", "myi", "myu", "mye", "myo", "rya", "ryi", "ryu", "rye", "ryo", "gya", "gyi", "gyu", "gye", "gyo", "bya", "byi", "byu", "bye", "byo", "pya", "pyi", "pyu", "pye", "pyo"]

	fileprivate lazy var hiragana: [String] = ["あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ", "が", "ぎ", "ぐ", "げ", "ご", "さ", "し", "す", "せ", "そ", "ざ", "じ", "ず", "ぜ", "ぞ", "た", "ち", "つ", "て", "と", "だ", "ぢ", "づ", "で", "ど", "な", "に", "ぬ", "ね", "の", "は", "ひ", "ふ", "へ", "ほ", "ば", "び", "ぶ", "べ", "ぼ", "ぱ", "ぴ", "ぷ", "ぺ", "ぽ", "ま", "み", "む", "め", "も", "や", "", "ゆ", "", "よ", "ら", "り", "る", "れ", "ろ", "わ", "ゐ", "", "ゑ", "を", "ん", "", "", "", "", "ちゃ", "ち", "ちゅ", "ちぇ", "ちょ", "しゃ", "し", "しゅ", "しぇ", "しょ", "じゃ", "じ", "じゅ", "じぇ", "じょ", "きゃ", "きぃ", "きゅ", "きぇ", "きょ", "にゃ", "にぃ", "にゅ", "にぇ", "にょ", "ひゃ", "ひぃ", "ひゅ", "ひぇ", "ひょ", "みゃ", "みぃ", "みゅ", "みぇ", "みょ", "りゃ", "りぃ", "りゅ", "りぇ", "りょ", "ぎゃ", "ぎぃ", "ぎゅ", "ぎぇ", "ぎょ", "びゃ", "びぃ", "びゅ", "びぇ", "びょ", "ぴゃ", "ぴぃ", "ぴゅ", "ぴぇ", "ぴょ"]

	fileprivate lazy var SOKUON: [Character] = ["r", "w", "n", "y", "p", "b", "f", "h", "g", "k", "j", "d", "m", "t", "z", "s", "c"]

	fileprivate func rangeWithString(_ string: String, range: NSRange) -> Range<String.Index> {
		return string.characters.index(string.startIndex, offsetBy: range.location) ..< string.characters.index(string.startIndex, offsetBy: range.location+range.length)
	}
	
	fileprivate lazy var regex = try! NSRegularExpression(pattern: "(tsu)|([ztmdkghfbpyrwn](ya|yu|yo))|((sh|ch)?([aeiou]))|(([sztmdjkghfbpyrwn])?([aeiou]))|([rwnypbfhgkjdmtzsc])", options: [.caseInsensitive])
	
	
	fileprivate let HIRAGANA_MIN: Int64 = 12353
	fileprivate let HIRAGANA_MAX: Int64 = 12447
	fileprivate let KATAKANA_MIN: Int64 = 12448
	fileprivate let KATAKANA_MAX: Int64 = 12543
	
	/**
	Transliterates latin script to katakana script.

	`text` is converted to lowercase automatically, but no attempts are made to scrub diacritics.

	Any character not matched to a katakana text will be returned as a sokuon (促音).

	- returns: Returns text transliterated to katakana script.
	- parameter text:The romaji string to act upon.
	*/
	func romajiToKata(_ text: String) -> String {
		return hiraToKata(romajiToHira(text))
	}


	/**
	Transliterates latin script to hiragana script.

	`text` is converted to lowercase automatically, but no attempts are made to scrub diacritics.

	Any character not matched to a hiragana text will be returned as a sokuon (促音).

	- returns: Returns `text` transliterated to hiragana script.
	- parameter text:The romaji string to act upon.
	*/
	func romajiToHira(_ text: String) -> String {
		var copy = text.lowercased()
		for match in regex.matches(in: copy, options: [], range: NSMakeRange(0, copy.characters.count)) {
			let matchRange = rangeWithString(text, range: match.range)
			let character = text.substring(with: matchRange)
			if let index = reading.index(of: character) {
				print("index: \(index) and hiragana[\(hiragana[index])]")
				copy = copy.replacingOccurrences(of: character, with: hiragana[index])
			}
		}

		for char in copy.characters {
			if SOKUON.contains(char) {
				copy = copy.replacingOccurrences(of: String(char), with: "っ")
			}
		}

		return copy
	}

	/**
	Transliterates hiragana script to katakana script.
	
	Leaves non-hiragana characters as-is.

	- returns: Returns `text` transliterated to katakana script.
	- parameter text:The hiragana string to act upon.
	*/
	func hiraToKata(_ text: String) -> String {
		return text.utf16.reduce("") {
			var value = ""
			if $1.toIntMax() >= HIRAGANA_MIN && $1.toIntMax() < HIRAGANA_MAX {
				value = $0 + String(describing: UnicodeScalar($1.advanced(by: 96))!)
			} else {
				value = $0 + String(describing: UnicodeScalar($1)!)
			}
			return value
		}
	}

	/**
	Transliterates katakana script to hiragana script.
	
	Leaves non-katakana characters as-is.

	- returns: Returns `text` transliterated to hiragana script.
	- parameter text:The katakana string to act upon.
	*/
	func kataToHira(_ text: String) -> String {
		return text.utf16.reduce("") {
			var value = ""
			if $1.toIntMax() >= KATAKANA_MIN && $1.toIntMax() < KATAKANA_MAX {
				value = $0 + String(describing: UnicodeScalar($1.advanced(by: -96))!)
			} else {
				value = $0 + String(describing: UnicodeScalar($1)!)
			}
			return value
		}
	}

	/**
	Transliterates katakana script to latin script.
	
	Leaves non-katakana characters as-is.

	- returns: Returns `text` transliterated to latin script.
	- parameter text:The katakana string to act upon.
	*/
	func kataToRomaji(_ text: String) -> String {
		return hiraToRomaji(kataToHira(text))
	}

	/**
	Transliterates hiragana script to latin script.
	
	Leaves non-hiragana characters as-is.

	- returns: Returns `text` transliterated to latin script.
	- parameter text:The hiragana string to act upon.
	*/
	func hiraToRomaji(_ text: String) -> String {
		return String(text.utf16.reduce("") {
			if $1.toIntMax() >= HIRAGANA_MIN && $1.toIntMax() < HIRAGANA_MAX {
				return $0 + reading[
					hiragana.index(of: String(describing: UnicodeScalar($1)!))!
				]
			} else {
				return $0 + String(describing: UnicodeScalar($1)!)
			}
		})
	}

	/**
	Remove the specified character sets from a string.

	- returns: `text`, less the character sets specified in `target:An`.
	- parameter text:The English or Japanese string to act upon.
	- parameter target:An array of `LangScript`, indicating the language scripts to remove from `text`.
	*/
	func stripScripts(_ text: String, _ target: [LangScript]) -> String {
		let regex = try! NSRegularExpression(pattern: target.flatMap({$0.rawValue}).joined(separator: "|"), options: [.caseInsensitive])
		return regex.stringByReplacingMatches(in: text, options: [], range: NSMakeRange(0, text.characters.count), withTemplate: "")
	}

	/**
	Determines if text is wholly member to specified `[target]` written scripts.

	- returns: `true` if `text` matches one or more of the specified `LangScript`s.
	- parameter target:The character sets to check against.
	*/
	func hasScriptTypes(_ text: String, _ target: [LangScript]) -> Bool {
		let regex = try! NSRegularExpression(pattern: target.flatMap({$0.rawValue}).joined(separator: "|"), options: [.caseInsensitive])
		if regex.numberOfMatches(in: text, options: [NSRegularExpression.MatchingOptions.withoutAnchoringBounds], range: NSMakeRange(0, text.characters.count)) != text.characters.count {
			return false
		}
		return true
	}
}

/**
Enumeration specifiying Unicode ranges for various written scripts.

- parameter JAPANESE:Any Japanese language script.
- parameter KANA:Japanese Hiragana or Katakana scripts.
- parameter KANJI:Chinese characters utilized by Japanese.
- parameter ROMAJI:Latin script.
*/
enum LangScript: String {
	case ROMAJI = "[\\u0000-\\u007F|\\u1E00-\\u1EFF]"
	case KANJI = "[\\u4E00-\\u9FBF]"
	case KANA = "[\\u3040-\\u30FF]"
	case HIRAGANA = "[\\u3040-\\u309F]"
	case KATAKANA = "[\\u30A0-\\u30FF]"
	case JAPANESE = "[\\u4E00-\\u9FBF|\\u3040-\\u30FF]"
	case JPPUNCT = "[\\u3000-\\u303F]"
}
