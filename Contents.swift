
func decodeHex(from hexString: String) -> [UInt8] {

    var index = hexString.startIndex
    var result: [UInt8] = []

    for _ in 0..<hexString.count / 2 {
        let nextIndex = hexString.index(index, offsetBy: 2)

        if let hexDecodedValue = UInt8(hexString[index..<nextIndex], radix: 16) {
            result.append(hexDecodedValue)
        }

        index = nextIndex
    }

    return result
}

func convertToAscii(from textString: String, key: String) -> (stringAsciiValue: [UInt8], keyAsciiValue: [UInt8]) {

    return (Array(textString.utf8), Array(key.utf8))
}

func repeatingXor(for asciiValues: [UInt8], key: [UInt8]) -> [UInt8] {

    var result: [UInt8] = []

    for (index, _) in asciiValues.enumerated() {
        result.append(asciiValues[index] ^ key[index % key.count])
    }

    return result
}

func runTest() {
    let stringsToAscii = convertToAscii(from: "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal",
                                        key: "ICE")
    let output = repeatingXor(for: stringsToAscii.stringAsciiValue, key: stringsToAscii.keyAsciiValue)

    let hexToAscii = decodeHex(from: "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f")

    if output == hexToAscii {
        print("Test passed")
    } else {
        print("Test failed")
    }
}

runTest()
