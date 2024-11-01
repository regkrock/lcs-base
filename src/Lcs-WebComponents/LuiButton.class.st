Class {
	#name : #LuiButton,
	#superclass : #LuiComponent,
	#instVars : [
		'type'
	],
	#category : #'Lcs-WebComponents-Buttons'
}

{ #category : #components }
LuiButton >> addLabelComponent [
	self addComponent: (LuiButtonLabel named: 'label' on: self)
]

{ #category : #testing }
LuiButton >> hasLabelComponent [
	^ (self componentNamed: 'label') notNil
]

{ #category : #configuration }
LuiButton >> icon: anIcon [
	self addComponent: (
		(LuiIcon named: 'icon' on: self) 
			"domainObject: anIcon;"
			yourself)
]

{ #category : #components }
LuiButton >> labelComponent [
	self hasLabelComponent ifFalse: [ self addLabelComponent ].
	^ self componentNamed: 'label'
]

{ #category : #configuration }
LuiButton >> labelString [
	self hasLabelComponent ifFalse: [^ '' ].
	^ self labelComponent labelString
]

{ #category : #configuration }
LuiButton >> labelString: aString [
	self labelComponent labelString: aString
]

{ #category : #'as yet unclassified' }
LuiButton >> showLabelOnTranscript [
	Transcript show: self class name , ':clicked ' , self label; cr
]
