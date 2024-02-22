Class {
	#name : #NewClass,
	#superclass : #Object,
	#instVars : [
		'lcsBaseModule'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
NewClass >> lcsBaseModule [
	^ lcsBaseModule
]

{ #category : #accessing }
NewClass >> lcsBaseModule: anObject [
	^ lcsBaseModule := anObject
]
