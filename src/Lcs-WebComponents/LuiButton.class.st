Class {
	#name : #LuiButton,
	#superclass : #LuiComponent,
	#instVars : [
		'type'
	],
	#category : #'Lcs-WebComponents-Buttons'
}

{ #category : #configuration }
LuiButton >> addIcon: anIcon [
	self addComponent: (
		(LuiIcon named: 'icon' on: self) 
			"domainObject: anIcon;"
			yourself)
]

{ #category : #initialize }
LuiButton >> beButtonType [
	self properties buttonTypeProperty
]

{ #category : #configuration }
LuiButton >> icon: anIcon [
]

{ #category : #initialize }
LuiButton >> initialize [
	super initialize.
]

{ #category : #configuration }
LuiButton >> label [
	^ (self labelComponent ifNil: [ ^ nil ]) label
]

{ #category : #configuration }
LuiButton >> label: aString [
	| labelComponent |
	labelComponent := self labelComponent ifNil: [ 
						self addComponent: (LuiLabel named: 'label' on: self) ].
	labelComponent domainObject: aString
]

{ #category : #configuration }
LuiButton >> labelComponent [
	^ self componentNamed: 'label'
]

{ #category : #'as yet unclassified' }
LuiButton >> showLabelOnTranscript [
	Transcript show: self class name , ':clicked ' , self label; cr
]
