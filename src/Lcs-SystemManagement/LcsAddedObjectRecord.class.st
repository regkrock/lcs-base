Class {
	#name : #LcsAddedObjectRecord,
	#superclass : #LcsObjectChangeRecord,
	#instVars : [
		'creationContext'
	],
	#category : #'Lcs-SystemManagement-UnitOfWork'
}

{ #category : #api }
LcsAddedObjectRecord >> applyChanges [
	<todo: 'This was put in becaue a member of slot had a value of nil and caused this problem. Fixing this is related to the null object pattern which has not yet been implemented.'>
	self domainObject isNil ifTrue: [ ^self ].
	self domainObject isNil ifTrue: [ LcsError signal: 'Cannot apply changes because domain object is nil'].
	self domainObject parent isNil ifTrue: [
		(self domainObject slotDefinitionNamed: 'parent') persistValue: self domainObject  contextObject: self creationContext ].
	self domainObject isSupportDomainObject ifFalse: [
		self domainObject version: self domainObject version + 1 .
		self domainObject history ].
	
]

{ #category : #accessing }
LcsAddedObjectRecord >> creationContext [
	^ creationContext
]

{ #category : #accessing }
LcsAddedObjectRecord >> creationContext: anObject [
	creationContext := anObject
]

{ #category : #accessing }
LcsAddedObjectRecord >> viewItemLabel [
	^ 'Added'
]
