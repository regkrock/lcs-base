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

{ #category : #components }
LuiButton >> hasLabelComponent [
	^ self componentNamed: 'label'
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
	^ self hasLabelComponent
		ifNil: [ self addComponent: (LuiButtonLabel named: 'label' on: self) ]
]

{ #category : #configuration }
LuiButton >> labelString [
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
