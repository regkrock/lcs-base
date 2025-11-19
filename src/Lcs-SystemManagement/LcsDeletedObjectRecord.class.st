Class {
	#name : 'LcsDeletedObjectRecord',
	#superclass : 'LcsObjectChangeRecord',
	#category : 'Lcs-SystemManagement-UnitOfWork',
	#package : 'Lcs-SystemManagement',
	#tag : 'UnitOfWork'
}

{ #category : 'api' }
LcsDeletedObjectRecord >> applyChanges [
	self domainObject version: SmallInteger minVal.
	self error: 'Needs to be implemented'
]

{ #category : 'accessing' }
LcsDeletedObjectRecord >> viewItemLabel [
	^ 'Deleted'
]
