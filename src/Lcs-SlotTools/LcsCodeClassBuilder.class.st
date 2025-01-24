Class {
	#name : #LcsCodeClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#instVars : [
		'defaultInstance'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsCodeClassBuilder >> beDefaultInstance [
	defaultInstance := true
]

{ #category : #accessing }
LcsCodeClassBuilder >> defaultInstance [
	^ defaultInstance
]

{ #category : #accessing }
LcsCodeClassBuilder >> defaultInstance: aBoolean [ 
	defaultInstance := aBoolean
]

{ #category : #initialize }
LcsCodeClassBuilder >> initialize [
	super initialize.
	self defaultInstance: false
]

{ #category : #testing }
LcsCodeClassBuilder >> isDefaultInstance [
	^ self defaultInstance == true
]
