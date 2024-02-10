Class {
	#name : #LcsObjectChangeRecord,
	#superclass : #LcsObject,
	#instVars : [
		'domainObject',
		'parent'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsObjectChangeRecord class >> newFor: aDomainObject parent: anObject [
	^self new
		initializeFor: aDomainObject parent: anObject;
		yourself
]

{ #category : #api }
LcsObjectChangeRecord >> applyChanges [
	self subclassResponsibility
]

{ #category : #accessing }
LcsObjectChangeRecord >> domainObject [
	^ domainObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> domainObject: anObject [
	domainObject := anObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> initializeFor: aDomainObject parent: anObject [
	self 
		domainObject: aDomainObject;
		parent: anObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> parent [
	^ parent
]

{ #category : #accessing }
LcsObjectChangeRecord >> parent: anObject [
	parent := anObject
]
