Class {
	#name : #LcsUndefinedSlotModelError,
	#superclass : #LcsError,
	#instVars : [
		'domainClass'
	],
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #'instance creation' }
LcsUndefinedSlotModelError class >> signalSuperclassWithoutSlotModel: aClass [
	^ self new
		signalSuperclassWithoutSlotModel: aClass
]

{ #category : #accessing }
LcsUndefinedSlotModelError >> domainClass [
	^ domainClass
]

{ #category : #accessing }
LcsUndefinedSlotModelError >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #'instance creation' }
LcsUndefinedSlotModelError >> signalSuperclassWithoutSlotModel: aClass [ 
	self domainClass: aClass.
	self signal: 'No slot model defined for ' , self domainClass name
]
