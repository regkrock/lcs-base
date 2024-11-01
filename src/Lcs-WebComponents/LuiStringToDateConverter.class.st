Class {
	#name : #LuiStringToDateConverter,
	#superclass : #LuiDisplayConverter,
	#category : #'Lcs-WebComponents-Transformers'
}

{ #category : #converting }
LuiStringToDateConverter >> value: aString [
	^ [ aString asDate ] on: Error do: [ :s | s return: nil ]
]
