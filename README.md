# JPString

A library Swift, that offers easy conversion between Japanese and Latin scripts. 

## Usage
```
let jps = JPString()
```

### Hiragana or Katakana to Romaji
```
jps.hiraToRomaji("にほんにいきました") // produces: nihonniikimashita
jps.kataToRomaji("にほんにいきました") // produces: nihonniikimashita
```

### Romaji to Hiragana or Katakana
```
jps.romajiToHira("nihonniikimashita") // produces: にほんにいきました
jps.romajiToKata("nihonniikimashita") // produces: ニホンニイキマシタ
```

### Strip character sets
```
jps.stripScripts("ice creamを食べました。", [.KANA, .ROMAJI]) // produces: 食
```

### Has character sets
```
jps.hasScriptTypes("ice creamを食べました。", [.KANA, .ROMAJI]) // returns true
```

## Installation
Copy JPString.swift to project.

## License

JPString is available under the MIT license. See the LICENSE file for more info.
