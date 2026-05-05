Class {
	#name : 'LuiStringToDateConverter',
	#superclass : 'LuiDisplayConverter',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiStringToDateConverter >> value: aString [
	^ [ aString asDate ] on: Error do: [ :s | s return: nil ]
]
