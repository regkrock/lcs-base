Class {
	#name : #LcsSystemComponent,
	#superclass : #LcsObject,
	#instVars : [
		'modules'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsSystemComponent >> initialize [ 
	super initialize.
	self modules: Dictionary new
]

{ #category : #accessing }
LcsSystemComponent >> modules [
	^ modules
]

{ #category : #accessing }
LcsSystemComponent >> modules: anObject [
	modules := anObject
]
