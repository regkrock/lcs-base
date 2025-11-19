Class {
	#name : 'LcsUmlMondrianCustomLayoutPolicy',
	#superclass : 'LcsUmlModelLayoutPolicy',
	#instVars : [
		'positions'
	],
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'api' }
LcsUmlMondrianCustomLayoutPolicy >> applyLayoutTo: aMondrinModel [
	self positions isEmpty ifTrue: [ ^self ].
	aMondrinModel layout custom: BlBasicLayout new.
	aMondrinModel root children 
		withIndexDo: [ :child :n | child relocate: (self positions at: n) ] 
]

{ #category : 'initialize' }
LcsUmlMondrianCustomLayoutPolicy >> initialize [
	super initialize.
	self positions: OrderedCollection new
]

{ #category : 'accessing' }
LcsUmlMondrianCustomLayoutPolicy >> positions [
	^ positions
]

{ #category : 'accessing' }
LcsUmlMondrianCustomLayoutPolicy >> positions: anObject [
	positions := anObject
]
