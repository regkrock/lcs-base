Class {
	#name : 'LxxFoo',
	#superclass : 'LcsObject',
	#instVars : [
		'bar'
	],
	#category : 'Lcs-WebComponentsTests-Experiment',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Experiment'
}

{ #category : 'instance creation' }
LxxFoo class >> newBar: anObject [
	^ self new
		bar: anObject;
		yourself
]

{ #category : 'accessing' }
LxxFoo >> bar [
	^ bar
]

{ #category : 'accessing' }
LxxFoo >> bar: anObject [
	bar := anObject
]
