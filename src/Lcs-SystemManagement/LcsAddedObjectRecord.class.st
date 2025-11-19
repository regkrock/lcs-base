Class {
	#name : 'LcsAddedObjectRecord',
	#superclass : 'LcsObjectChangeRecord',
	#instVars : [
		'creationContext'
	],
	#category : 'Lcs-SystemManagement-UnitOfWork',
	#package : 'Lcs-SystemManagement',
	#tag : 'UnitOfWork'
}

{ #category : 'api' }
LcsAddedObjectRecord >> applyChanges [
	<todo: 'This was put in becaue a member of slot had a value of nil and caused this problem. Fixing this is related to the null object pattern which has not yet been implemented.'>
	"self domainObject isNil ifTrue: [ ^self ]."
	self domainObject isNil ifTrue: [ LcsError signal: 'Cannot apply changes because domain object is nil'].
	self domainObject parent isNil ifTrue: [ LcsError signal: 'Cannot apply changes because domain object''s parent slot is nil'.
		"(self domainObject slotDefinitionNamed: 'parent') persistValue: self domainObject  contextObject: self creationContext "].
	self domainObject incrementVersionNumber.
	self domainObject isSupportDomainObject ifFalse: [
		self domainObject history recordSlotChanges ]
	
]

{ #category : 'accessing' }
LcsAddedObjectRecord >> creationContext [
	^ creationContext
]

{ #category : 'accessing' }
LcsAddedObjectRecord >> creationContext: anObject [
	creationContext := anObject
]

{ #category : 'accessing' }
LcsAddedObjectRecord >> viewItemLabel [
	^ 'Added'
]
