Class {
	#name : #LcsValueObjectClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#instVars : [
		'defaultInstance'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsValueObjectClassBuilder >> beDefaultInstance [
	defaultInstance := true
]

{ #category : #accessing }
LcsValueObjectClassBuilder >> defaultInstance [
	^ defaultInstance
]

{ #category : #accessing }
LcsValueObjectClassBuilder >> defaultInstance: aBoolean [ 
	defaultInstance := aBoolean
]

{ #category : #initialize }
LcsValueObjectClassBuilder >> initialize [
	super initialize.
	self defaultInstance: false
]

{ #category : #testing }
LcsValueObjectClassBuilder >> isDefaultInstance [
	^ self defaultInstance == true
]
