Class {
	#name : 'LcsPasswordHasher',
	#superclass : 'LcsObject',
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
LcsPasswordHasher class >> generateSalt [
	"Generates a 16-byte random salt using UUID v4 bytes"
	^ UUID new asInteger asByteArray
]

{ #category : 'as yet unclassified' }
LcsPasswordHasher class >> hashPassword: aPasswordString [
	"Returns a self-contained string: iterations:saltHex:hashHex"

	| iterations salt derivedKey |
	iterations := 10000"0".
	salt := self generateSalt.
	derivedKey := self 
		pbkdf2HmacSha256Password: aPasswordString 
		salt: salt 
		iterations: iterations.
	
	^ String streamContents: [ :s |
		s 
			print: iterations; nextPut: $:;
			nextPutAll: salt hex; nextPut: $:;
			nextPutAll: derivedKey hex ]
]

{ #category : 'as yet unclassified' }
LcsPasswordHasher class >> pbkdf2HmacSha256Password: aPasswordString salt: aSaltByteArray iterations: anInteger [
	"Standard PBKDF2-HMAC-SHA256 implementation (32-byte derived key)"

	| passwordBytes hmac block1 u xorResult |
	passwordBytes := aPasswordString utf8Encoded.
	hmac := SHA256 new hmac key: passwordBytes.
	
	"Block index 1 (big-endian 32-bit integer: #[0 0 0 1])"
	block1 := aSaltByteArray , #[0 0 0 1].
	u := hmac digestMessage: block1.
	xorResult := u copy.
	
	2 to: anInteger do: [ :i |
		u := hmac digestMessage: u.
		1 to: xorResult size do: [ :byteIndex |
			xorResult 
				at: byteIndex 
				put: ((xorResult at: byteIndex) bitXor: (u at: byteIndex)) ] ].
	
	^ xorResult
]

{ #category : 'as yet unclassified' }
LcsPasswordHasher class >> verifyPassword: aPasswordString againstStoredHash: aStoredString [
	"Parses the stored string and compares digests in constant time"

	| parts iterations salt expectedHash actualHash diff |
	parts := $: split: aStoredString.
	parts size = 3 ifFalse: [ ^ false ].
	
	iterations := parts first asInteger.
	salt := ByteArray readHexFrom: parts second.
	expectedHash := ByteArray readHexFrom: parts third.
	
	actualHash := self 
		pbkdf2HmacSha256Password: aPasswordString 
		salt: salt 
		iterations: iterations.
	
	actualHash size = expectedHash size ifFalse: [ ^ false ].
	
	"Constant-time comparison to prevent timing side-channel attacks"
	diff := 0.
	1 to: actualHash size do: [ :i |
		diff := diff bitOr: ((actualHash at: i) bitXor: (expectedHash at: i)) ].
	
	^ diff = 0
]
