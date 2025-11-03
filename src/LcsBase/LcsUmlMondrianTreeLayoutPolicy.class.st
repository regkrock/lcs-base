Class {
	#name : #LcsUmlMondrianTreeLayoutPolicy,
	#superclass : #LcsUmlModelLayoutPolicy,
	#instVars : [
		'levelDistance'
	],
	#category : #'LcsBase-Core'
}

{ #category : #api }
LcsUmlMondrianTreeLayoutPolicy >> applyLayoutTo: aMondrinModel [
	aMondrinModel layout tree levelDistance: 40
]

{ #category : #initialize }
LcsUmlMondrianTreeLayoutPolicy >> initialize [
	super initialize.
	self levelDistance: 40
]

{ #category : #accessing }
LcsUmlMondrianTreeLayoutPolicy >> levelDistance [
	^ levelDistance
]

{ #category : #accessing }
LcsUmlMondrianTreeLayoutPolicy >> levelDistance: anObject [
	levelDistance := anObject
]
