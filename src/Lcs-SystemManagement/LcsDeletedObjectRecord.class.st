Class {
	#name : #LcsDeletedObjectRecord,
	#superclass : #LcsObjectChangeRecord,
	#category : #'Lcs-SystemManagement-UnitOfWork'
}

{ #category : #api }
LcsDeletedObjectRecord >> applyChanges [
	self domainObject version: SmallInteger minVal.
	self error: 'Needs to be implemented'
]

{ #category : #accessing }
LcsDeletedObjectRecord >> viewItemLabel [
	^ 'Deleted'
]
