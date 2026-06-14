Class {
	#name : 'LuiButton',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'components' }
LuiButton >> addLabelComponent [
	self addComponent: (LuiButtonLabel named: 'label')
]

{ #category : 'testing' }
LuiButton >> hasLabelComponent [
	^ (self componentNamed: 'label') notNil
]

{ #category : 'properties' }
LuiButton >> label [
	^ self attributes label
]

{ #category : 'properties' }
LuiButton >> label: aString [
	self attributes labelBlock: [ aString ]
]

{ #category : 'components' }
LuiButton >> labelComponent [
	self hasLabelComponent ifFalse: [ self addLabelComponent ].
	^ self componentNamed: 'label'
]

{ #category : 'configuration' }
LuiButton >> labelString [
	self hasLabelComponent ifFalse: [^ '' ].
	^ self labelComponent labelString
]

{ #category : 'configuration' }
LuiButton >> labelString: aString [
	self labelComponent labelString: aString
]

{ #category : 'as yet unclassified' }
LuiButton >> showLabelOnTranscript [
	Transcript show: self class name , ':clicked ' , self text; cr
]
